require_dependency "source"

class Article < ActiveRecord::Base
  belongs_to :category
  
  has_and_belongs_to_many :authors, :class_name => "User", :association_foreign_key => "author_id"
  
  validates_presence_of :title
  validates_presence_of :category
  validates_presence_of :intro, :body
  validates_presence_of :author
  validates_presence_of :image
  
  validates_format_of :image,
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
    :if => Proc.new { |a| a.image != "" && a.image != nil }
  
  validates_format_of :short_url,
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
    :if => Proc.new { |a| a.short_url != "" && a.short_url != nil }  
  
  has_many :sources
  accepts_nested_attributes_for :sources, :allow_destroy => true
  
  default_scope order("publish_date DESC, updated_at DESC") # EX created_at
  
  scope :published,
     where(:published => 1)
    .where(:hidden => 0)
    .where("publish_date <= ?", Time.zone.now)
    
  scope :recommended,
     where(:published => 1)
    .where("publish_date <= ?", Time.zone.now)
    .where(:recommended => 1)
    .where(:hidden => 0)
  
  after_initialize :default_values

  def default_values
    self.publish_date ||= Time.now
  end
  
  #def publish_date
  #  read_attribute(:publish_date).strftime("%Y-%m-%d %H:%M:%S")
  #end

  def self.top_viewed(limit=10)
    with_exclusive_scope do
      where(:published => true)
      .where(:recommended => 1)
      .where(:hidden => 0)
      .where("publish_date <= ?", Time.zone.now)
      .limit(limit)
      .order("views DESC")
    end
  end

  def jid
    return nil if self.id.nil?
    return  "jid-#{self.id}" if Rails.env.production?
    "jid-#{self.id}-test"
  end
  
  def published_at
    self.publish_date
  end
  
  def self.search(query)
    ids = ArticleObserver.tank_index
      .search(query)["results"].map {|r| r["docid"].to_i }
    Article.published.where("id IN (?)", ids)
  end
  
  def self.comment_details(comment_id)
    require "net/http"
    
    url = "http://disqus.com/api/3.0/posts/details.json?related=thread&api_secret=#{DISQUS['api_secret']}&post=#{comment_id}"
    
    begin
      logger.info "Fetching: disqus_posts - Started."
      posts = JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
      posts = posts["response"]
    rescue => e
      logger.info "Fetching: disqus_posts - Failed!"
      posts = []
    end
    
    posts
  end
  
  def related(limit=10,p_date=nil)
    # p_date ||= Time.now.to_s(:db) #strftime("%Y-%m-%d %H:%M:%S")
    # p_date ||= Time.zone.now.to_s(:db)
    p_date ||= Time.now.to_s(:db)
    
    Article.find_by_sql(%Q{
      SELECT
      	a.*,
      	((SELECT COUNT(*) FROM
      	((SELECT t.name FROM taggings tg, tags t
      		WHERE tg.taggable_id = a.id AND tg.tag_id = t.id
      	) INTERSECT
      	(SELECT t_2.name FROM taggings tg_2, tags t_2
      		WHERE tg_2.taggable_id = #{self.id} AND tg_2.tag_id = t_2.id
      	)) as intersection
      	)::float /
      	(SELECT COUNT(*) FROM
      	((SELECT t.name FROM taggings tg, tags t
      	WHERE tg.taggable_id = a.id AND tg.tag_id = t.id
      	) UNION
      	(SELECT t_2.name FROM taggings tg_2, tags t_2
      		WHERE tg_2.taggable_id = #{self.id} AND tg_2.tag_id = t_2.id
      	)) as union_total
      	)::float) as score
      FROM
      	articles a
      WHERE
      	a.published = 1 AND
        a.publish_date <= '#{p_date}' AND
      	a.id != #{self.id}
      ORDER BY score DESC, a.created_at DESC
      LIMIT #{limit}      
    })
  end
  
  # Plugins
  acts_as_taggable_on :tags     # acts_as_taggable_on
  paginates_per         7       # kaminari
  
  after_initialize :set_no_image
  
  def author=(value)
    self.authors = []
    self.authors << value
  end
  
  def source=(value)
    self.sources = []
    self.sources << value
  end
  
  def author
    return nil if self.authors == nil
    return self.authors.first
  end
  
  def to_s() "#{self.title}"; end
  
  def to_param
    return self.slug if self.slug != nil && self.slug != ""
    "#{self.id}-#{self.title}".parameterize
  end
  
  def published?
    return self.published == 1
  end
  
  def comments_visible?
    return self.comments_visible == 1
  end
  
  def image_visible?
    return self.image_visible == 1
  end
  
  def share_visible?
    return self.share_visible == 1
  end
  
  def recommend_visible?
    return self.recommend_visible == 1
  end
  
  def hidden?
    return self.hidden == 1
  end
  
  def body_html
    return nil if self.body == nil
    return RedCloth.new(self.body).to_html
  end
  
  def intro_html
    return nil if self.intro == nil
    return RedCloth.new(self.intro).to_html
  end
  
  def tank_document
    {
      title:  self.title.to_s,
      # intro:  self.intro.to_s,
      # body:   self.body.to_s,
      text:   self.body.to_s
    }
  end


  
  private
    def set_no_image
      self.image||="http://sveze-jabolko-common.s3.amazonaws.com/images/nomainimage.jpg"
    end

end

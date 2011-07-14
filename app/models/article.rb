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
  
  default_scope order("created_at DESC")
  scope :published, where(:published => true)
  scope :recommended, where(:recommended => 1)
  
  def self.top_viewed(limit=10)
    with_exclusive_scope do
      where(:published => true)
      .where(:recommended => 1)
      .limit(limit)
      .order("views DESC")
    end
  end
  
  def self.search(query)
    ids = ArticleObserver.tank_index
      .search(query)["results"].map {|r| r["docid"].to_i }
    Article.published.where("id IN (?)", ids)
  end
  
  def related(limit=10)
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

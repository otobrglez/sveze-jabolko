class Article < ActiveRecord::Base
  belongs_to :category
  
  has_and_belongs_to_many :authors, :class_name => "User", :association_foreign_key => "author_id"
  
  validates_presence_of :title
  validates_presence_of :category
  validates_presence_of :intro, :body
  validates_presence_of :author
  validates_presence_of :image
  
  validates_format_of :image,
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  has_and_belongs_to_many :sources
  
  default_scope order("created_at DESC")
  scope :published, where(:published => true)
  
  # Plugins
  acts_as_taggable_on :tags     # acts_as_taggable_on
  paginates_per         5       # kaminari
  
  after_initialize :set_no_image
  
  def author=(value)
    self.authors = []
    self.authors << value
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
    #return Redcarpet.new(self.body).to_html
  end
  
  def intro_html
    return nil if self.intro == nil
    return RedCloth.new(self.intro).to_html
    #return Redcarpet.new(self.intro).to_html
  end
  
  private
    def set_no_image
      self.image||="http://sveze-jabolko-common.s3.amazonaws.com/images/nomainimage.jpg"
    end

end

class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :author, :class_name => "User"
  
  validates_presence_of :title
  validates_presence_of :category
  validates_presence_of :intro, :body
  validates_presence_of :author
  
  has_and_belongs_to_many :sources
  
  # default_scope :order => "created_at DESC"
  
  def to_s
    "#{self.title}"
  end
  
  def to_param
    return self.slug if self.slug != nil || self.slug == ""
    "#{self.id}-#{self.title}".parameterize
  end
  
  def published?
    return self.published
  end
  
end

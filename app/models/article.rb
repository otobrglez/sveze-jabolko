class Article < ActiveRecord::Base
  belongs_to :category
  
  validates_presence_of :title
  validates_presence_of :category
  validates_presence_of :intro, :body
  
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

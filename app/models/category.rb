class Category < ActiveRecord::Base
  has_many :articles
  
  validates_presence_of :title
  
  def to_s
    "#{self.title}"
  end
  
  def to_param
    return self.slug if self.slug != nil && self.slug != ""
    "#{self.id}-#{self.title}".parameterize
  end
  
end

class Source < ActiveRecord::Base
  
  validates_presence_of :title
  validates_presence_of :url
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  has_and_belongs_to_many :articles
  
end

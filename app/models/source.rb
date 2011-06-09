#require 'active_model'
class Source < ActiveRecord::Base
  #include ActiveModel::Validations
  
  belongs_to :article
  
  validates_presence_of :title
  validates_presence_of :url
  validates_format_of :url,
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  #attr_accessor :title
  #attr_accessor :url
  
  def to_s
    "#{self.title}"
  end
  
end

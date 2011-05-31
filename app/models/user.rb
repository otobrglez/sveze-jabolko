class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_format_of :home_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix
  
  has_many :articles
  
  def is_admin?
    return self.is_admin
  end
  
  def is_author?
    return self.is_author
  end
  
  def is_developer?
    return self.is_developer
  end
  
  def to_param
    "#{self.id}-#{self.name}".parameterize
  end
  
  def to_s
    "#{self.name}"
  end
  
end
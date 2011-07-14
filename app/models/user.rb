# include ActionView::Helpers

class User < ActiveRecord::Base
  
  include AuthorsHelper
  
  include Gravtastic
  gravtastic :size => 120
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me,
    :name, :home_url, :twitter_name, :facebook_name, :github_name, :linkedin_name,
    :about, :is_admin, :is_author, :is_developer
  
  #Deprecated : :skype_name, 
  
  validates_presence_of :name
  validates_uniqueness_of :name
  
  validates_presence_of :about,
    :if => Proc.new { |user| user.is_author?  && user.about == ""}
  
  validates_format_of :home_url,
    :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix,
    :if => Proc.new { |user| user.home_url != "" && user.home_url != nil }

  has_and_belongs_to_many :articles, :class_name => "Article",
    :foreign_key => "author_id"
    
  scope :admins, where(:is_admin => 1).order("name ASC")
  scope :authors, where(:is_author => 1).order("name ASC")
  scope :developers, where(:is_developer => 1).order("name ASC")
  
  scope :authors_with_numbers,
    select("
      users.*, (
        SELECT
          COUNT(*)
        FROM
          articles_users
        LEFT JOIN
          articles
        ON
          articles.id = articles_users.article_id
        WHERE
          articles.published = 1 AND
          articles.hidden = 0 AND
          articles_users.author_id = users.id
      ) as p_count
    ")
    .where("users.is_author = 1")
    .order("p_count DESC")
    .where("
      (SELECT
        COUNT(*)
      FROM
        articles_users
      LEFT JOIN
        articles
      ON
        articles.id = articles_users.article_id
      WHERE
        articles.published = 1 AND
        articles.hidden = 0 AND
        articles_users.author_id = users.id)
     > 1")
  
  def is_admin?
    return self.is_admin == 1
  end
  
  def is_author?
    return self.is_author == 1
  end
  
  def is_developer?
    return self.is_developer == 1
  end
  
  def to_param
    "#{self.id}-#{self.name}".parameterize
  end
  
  def about_html
    return nil if self.about == nil
    return RedCloth.new(self.about).to_html
  end
  
  def to_s() "#{self.name}"; end
  
  def author_links_html
    return author_links(self)
  end
  
end

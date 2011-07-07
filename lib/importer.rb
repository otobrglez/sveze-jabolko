class Importer
  attr_accessor :db
  
  def initialize(db="#{Rails.root}/db/base-5-7-2011.sqlite3")
    self.db = SQLite3::Database.new(db)
  end

=begin  
  def import_categories
    categories = i.db.execute("SELECT * FROM categories ORDER BY id ASC").map do |c|
      {title: c[1], slug:c[2], id:c[0]}
    end
  end
  
  def import_staff
    # users    
    users = i.db.execute("SELECT * FROM users ORDER BY id ASC").map do |c|
      {
        name:"#{c[1]} #{c[2]}",
        email:c[3],
        password:"xxxXXXxxx",
        about:"a",
        is_admin:1
      }
    end
    
    writers = i.db.execute("SELECT * FROM writers").map do |c|
      {
        name: "#{c[1]} #{c[2]}",
        password:"xxxXXXasdas",
        email:c[12],
        about:c[3],
        twitter_name: c[5],
        home_url:c[4],
        is_author:1
      }
    end
    
  end
=end
  
  def import_articles
  
  end
  
end
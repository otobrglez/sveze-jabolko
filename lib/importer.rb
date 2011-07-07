class Importer
  attr_accessor :db
  
  def initialize(db="#{Rails.root}/db/base-5-7-2011.sqlite3")
    self.db = SQLite3::Database.new(db)
  end
  
  def import_authors
  
  end
  
  def import_categories
  
  end
  
  def import_articles
  
  end
  
end
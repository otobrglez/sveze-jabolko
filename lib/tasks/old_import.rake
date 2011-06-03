namespace :old_import do

=begin  
  desc "Import all users from legacy database"
  task :users => :environment do
    users = open_and_parse("old_data/users.json")
    puts "Error parsing document" if users == nil
    
    users.each do |u|
      
    end
    
    
  end
=end
  
  desc "Import all articles from legacy database"
  task :articles => :environment do
    
    articles = open_and_parse("old_data/articles.json")
    
    puts "Error parsing document" if articles == nil
    
    Article.transaction do
      articles.each do |a|
        a = a["article"]

        puts "\n#{a["title"]}"
        
        new_article = Article.new(
          :title => a["title"],
          :body => a["body"],
          :intro => a["intro"],
          :created_at => a["created_at"],
          :updated_at => a["updated_at"],
          :image => a["image"],
          :author => author_to_user(a["author"])
        )
        if not new_article.valid?
          puts "Validation errors: \n"+ new_article.errors.map{|a,b| "\t#{a} : #{b}\n"}.join("")
        else
          new_article.save
          puts "Imported."
        end
      end
    end
    
  end
  
  def author_to_user(data)
  
  end

  #desc "Pick a random product as the prize"
  #task :prize => :environment do
  #  puts "Prize: #{pick(Product).name}"
  #end
  
  #desc "Import all old data"
  #task :all => [:users, :articles]
  
  #def pick(model_class)
  #  model_class.find(:first, :order => 'RAND()')
  #end
  
  # Open JSON file and parse it
  def open_and_parse(file)
    nil unless File.exist? file
    return JSON.parse(File.open(file,"r").read)
  end
  
end
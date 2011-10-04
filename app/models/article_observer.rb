class ArticleObserver < ActiveRecord::Observer


  def self.client
    IndexTank::Client.new(ENV['INDEXTANK_API_URL'] || INDEXTANK["indextank_api_url"])
  end

  def self.tank_index
    client = ArticleObserver.client
    index = client.indexes(INDEXTANK["index"])
  end

  def after_save(article)
    begin
      ArticleObserver.tank_index.document(article.id.to_s).delete()      
      
      if article.published?
        ArticleObserver.tank_index
          .document(article.id.to_s).add(article.tank_document)
      end
              
      #ArticleObserver.tank_index
      #  .document(article.id.to_s).update_variables(article.tank_document)    
    rescue
      print "Error: ",$!,"\n"
    end
  end

  def after_create(article)
    begin
      if article.published?
        ArticleObserver.tank_index
          .document(article.id.to_s).add(article.tank_document)
      end
    rescue
      print "Error: ",$!,"\n"
    end
  end

  def after_destroy(article)
    begin
      ArticleObserver.tank_index
        .bulk_delete([article.id.to_s])
    rescue
      print "Error: ",$!,"\n"
    end
  end

end

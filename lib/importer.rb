class Importer
  attr_accessor :db
  
  def initialize(db="#{Rails.root}/db/base-5-7-2011.sqlite3")
    self.db = SQLite3::Database.new(db)
  end

  def import_articles
    articles = @db.execute("
      SELECT
        a.*,
        s.name,
        s.url,
        (
          SELECT
            (w.firstname  || ' ' ||  w.lastname) as author_name
          FROM
            writers w,articles_writers aw
          WHERE
            aw.article_id = a.id AND
            aw.writer_id = w.id
          LIMIT 1
        ) as author_name,
        (
          SELECT
            GROUP_CONCAT(t.name)
          FROM
            taggings tg,
            tags t
          WHERE
            tg.article_id = a.id AND
            tg.tag_id = t.id
        ) as tag_list,
        (
          SELECT
            GROUP_CONCAT(c.permalink)
          FROM
            articles_categories ac,
            categories c
          WHERE
            ac.article_id = a.id AND
            ac.category_id = c.id
          LIMIT 1
        ) as categories
      FROM
        articles a
      LEFT JOIN
        sources s
      ON
        a.source_id = s.id
      ")
      
    articles.map do |a|
      out = {
        # id: a[0],
        title: a[1],
        slug: "#{a[0]}-#{a[2]}".strip,
        image: "#{a[3]}",
        intro: "#{a[4]}",
        body: "#{a[5]}",
        created_at: DateTime.parse("#{a[7]}"),
        updated_at: DateTime.parse("#{a[8]}"),
        views: "#{a[11]}".to_i,
        short_url: "#{a[13]}",
        published: ("#{a[6]}".strip == "t")?1:0, #.to_i,
        tag_list: "#{a[15]}",
        author: "#{a[14]}",
        category: "#{a[16]}",
      }
      
      out.merge!({:source => { title: "#{a[12]}", url: "#{a[13]}" }}) if "#{a[12]}".strip != ""
      out
    end
  end
  
  def self.build_article(pre_article)
    pre_article[:source] = Source.new pre_article[:source] if pre_article[:source] != nil
    pre_article[:author] = User.find_by_name(pre_article[:author])
    pre_article[:category] = Category.find_by_slug(pre_article[:category])
    article = Article.new pre_article
  end
  
end
xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Jabolko.org - Apple uporabniki slovenije"
    xml.description "Jabolko.org je neodvisni osrednji vir znanja Apple uporabnikov Slovenija. Blog s svežimi novicami in članki iz jabolčnega sveta."
    xml.link root_url
    xml.image do
      xml.image image_path("jabolko_facebook.png")
      xml.link root_url
    end

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description sanitize(article.intro_html)
        xml.pubDate article.publish_date.to_s(:rfc822)
        if article.short_url.to_s == ""
          xml.link article_url(article.category, article)
        else
          xml.link article.short_url
        end
        xml.guid article_url(article.category, article)
        xml.category article.category
      end
    end
  end
end
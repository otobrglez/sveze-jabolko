module AuthorsHelper
  
  def author_links(author=nil)
    return nil if author == nil
    
    out = []
    mapping = {
      writer_website_icon: "home_url",
      writer_twitter_icon: "twitter_name",
      writer_facebook_icon: "facebook_name",
     # writer_skype_icon: "skype_name",
      writer_github_icon: "github_name",
      writer_linkedin_icon: "linkedin_name"
    }
    
    mapping.each do |key,value|
      value = author.send(value.to_sym)
      if value != nil && value != ""
        if key == :writer_website_icon
          out<< "
            <div id=\"#{key}\">
              <a
                href=\"#{value}\"
                target=\"_blank\">#{author}</a>
            </div>"
        elsif key == :writer_twitter_icon
          out<< "
            <div id=\"#{key}\">
              <a
                href=\"http://twitter.com/#{value}\"
                target=\"_blank\">#{value}</a>
            </div>"
        elsif key == :writer_facebook_icon
          out<< "
            <div id=\"#{key}\">
              <a
                href=\"http://www.facebook.com/#{value}\"
                target=\"_blank\">#{author}</a>
            </div>"  
        elsif key == :writer_skype_icon
          #TODO: Sanitize fucks things up if you use "skype:"
          out<< ('
            <div id="'+(key.to_s())+'"><a
              href="skype:'+(value.to_s())+'?call"
            >'+(author.to_s())+'</a></div>')   
        elsif key == :writer_github_icon
          out<< "
            <div id=\"#{key}\">
              <a
                href=\"https://github.com/#{value}\"
                target=\"_blank\">#{value}</a>
            </div>"                
        elsif key == :writer_linkedin_icon
          out<< "
            <div id=\"#{key}\">
              <a
                href=\"http://www.linkedin.com/in/#{value}\"
                target=\"_blank\">#{value}</a>
            </div>"                
        end        
      end
    end
    
    ActionController::Base.helpers.sanitize(out.join('
      <div id="writer_links_seperator">&nbsp;</div>
    '),:attributes => %w(id class style href target))
  end
  
end
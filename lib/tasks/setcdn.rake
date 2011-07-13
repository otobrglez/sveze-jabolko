# heroku config:add application_js_CDN="http://www.railsapplication.com/style.js" application_css_CDN="http://www.railsapplication.com/style.css"

namespace :setcdn do  
  desc "Set path to production CSS and JS on heroku"
  task :set do
    
    app_js = Dir["#{Rails.root.to_s}/public/assets/application*.js"].map do |f|
      "http://sveze-jabolko-common.s3.amazonaws.com/assets/"+File.basename(f)
    end.first
    
    app_css = Dir["#{Rails.root.to_s}/public/assets/application*.css"].map do |f|
      "http://sveze-jabolko-common.s3.amazonaws.com/assets/"+File.basename(f)
    end.first
    
    exec "bundle exec heroku config:add application_js_CDN=#{app_js} application_css_CDN=#{app_css} "
    
  end
end
# heroku config:add application_js_CDN="http://www.railsapplication.com/style.js" application_css_CDN="http://www.railsapplication.com/style.css"

namespace :setcdn do
  
  desc "Compress with gzip"
  task :gzip do
    
    app_js = Dir["#{Rails.root.to_s}/public/assets/application*.js"].first
    app_css = Dir["#{Rails.root.to_s}/public/assets/application*.css"].first
    
    exec "gzip -c #{app_js} > #{app_js}.gz ; gzip -c #{app_css} > #{app_css}.gz ; echo \"Done compressing\" "
    
  end
  
  desc "Set path to production CSS and JS on heroku"
  task :set do
    
    
    
    app_js = Dir["#{Rails.root.to_s}/public/assets/application*.js"].map do |f|
      "http://sveze-jabolko-common.s3.amazonaws.com/assets/"+File.basename(f)
    end.first
    
    app_css = Dir["#{Rails.root.to_s}/public/assets/application*.css"].map do |f|
      "http://sveze-jabolko-common.s3.amazonaws.com/assets/"+File.basename(f)
    end.first
    
    puts "Reload heroku configs..."
    
    exec "bundle exec heroku config:add application_js_CDN=#{app_js} application_css_CDN=#{app_css} --app sveze-jabolko ; \
      bundle exec heroku config:add application_js_CDN=#{app_js} application_css_CDN=#{app_css} --app stage-jabolko"
    
    puts "Done."
  end
end
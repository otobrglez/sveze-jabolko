#require "rubygems"
#require 's3'

namespace :as3 do  
  desc "Uploads compiled assets (public/assets) to Amazone AS3"
  task :upload do
    
    AS3_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/as3.yml")[Rails.env]
    service = S3::Service.new(:access_key_id =>AS3_CONFIG["access_key_id"],
                              :secret_access_key =>AS3_CONFIG["secret_access_key"])
    
    bucket = service.buckets.find(AS3_CONFIG["bucket"])
    
    # Upload assets
    assets = bucket.objects.find("assets/")
    
    path = "#{Rails.root.to_s}/public"
    files = Dir["#{path}/assets/**/**"].map { |f| f[path.length+1,f.length-path.length] }
    
    files.each do |f|
      if File.file? "#{path}/#{f}" # Make folder
        
        # MIME type
        mimetype = `file -ib #{path}/#{f}`.gsub(/\n/,"")
        mimetype = mimetype[0,mimetype.index(';')]
        mimetype = "application/javascript" if "#{path}/#{f}" =~ /\.js/
        mimetype = "text/css" if "#{path}/#{f}" =~ /\.css/
        
        # Don't upload existing
        begin
          existing = bucket.objects.find(f)
          # puts "File: #{f} - Not updated!"       
        rescue => e
          new_object = bucket.objects.build(f)
          new_object.content = open("#{path}/#{f}")
          new_object.content_type = mimetype
          new_object.save      
          puts "File: #{f} - Upload complete."       
        end
      end
    end
    
   puts "Done."
  end
end
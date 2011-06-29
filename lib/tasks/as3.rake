
namespace :as3 do  
  desc "Uploads compiled assets (public/assets) to Amazone AS3"
  task :upload do
    #require "rubygems"
    #require 's3'
    
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
        puts "Saving #{f}"
        new_object = bucket.objects.build(f)
        new_object.content = open("#{path}/#{f}")
        new_object.save
        puts "- Done."       
      end
    end
    
    #debugger
    
    t = 1
    
    #AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com" # If using EU bucket
    #AssetID::Asset.asset_paths += ['favicon.png'] # Configure additional asset paths
    #AssetID::S3.upload
  end
end
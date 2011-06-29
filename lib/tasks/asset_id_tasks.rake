namespace :asset do
  namespace :id do
    
    desc "uploads the current assets to s3 with stamped ids"
    task :upload do
      #AWS::S3::DEFAULT_HOST.replace "s3-eu-west-1.amazonaws.com" # If using EU bucket
      #AssetID::Asset.asset_paths += ['favicon.png'] # Configure additional asset paths
      AssetID::S3.upload
    end
    
  end
end
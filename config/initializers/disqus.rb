# Load disqus credentials
DISQUS= YAML.load_file("#{Rails.root.to_s}/config/disqus.yml")[Rails.env]
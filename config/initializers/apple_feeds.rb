APPLE_FEEDS = YAML.load_file("#{Rails.root.to_s}/config/apple_feeds.yml")[Rails.env]
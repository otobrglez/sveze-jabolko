# Load bit.ly credentials
BITLY = YAML.load_file("#{Rails.root.to_s}/config/bitly.yml")[Rails.env]
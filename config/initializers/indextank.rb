# Load bit.ly credentials
INDEXTANK = YAML.load_file("#{Rails.root.to_s}/config/indextank.yml")[Rails.env]
AS3_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/as3.yml")[Rails.env]
DROPBOX_CONFIG = YAML.load_file("#{Rails.root.to_s}/config/dropbox.yml")[Rails.env]
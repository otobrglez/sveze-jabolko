source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'

# gem "rails", :git => "git://github.com/rails/rails.git"
# gem "sprockets", :git => "git://github.com/sstephenson/sprockets.git"

# gem 'rake', '~> 0.8.7'
gem 'sass'
gem 'haml'
#gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'kaminari'
gem 'inherited_resources'
gem 'simple_form'
gem 'gravatar_image_tag'
gem 'acts-as-taggable-on'
gem 'RedCloth' # , :git => 'git://github.com/jgarber/redcloth.git' # , :tag => 'v4.2.7'
gem 'gravtastic'
gem 'ruby-bitly'
gem 's3'
gem 'feedzirra', :git => 'git://github.com/pauldix/feedzirra.git', :tag => 'v0.0.24'
gem 'sqlite3'
gem 'fastercsv'
gem 'devise'


# gem 'newrelic_rpm'
# gem 'redcarpet', :git => 'git://github.com/tanoku/redcarpet.git'
#gem 'rest-client'
#gem 'restclient'
#gem 'ruby-bitly', :git => 'git://github.com/rafaeldx7/ruby-bitly.git' #, :require => 'ruby-bitly'
# gem 'asset_id'
# gem 's3'
# gem 'aws-s3'
# gem 'yui'

group :test, :development do
	gem 'yui-compressor'
  gem 'turn', :require => false
	gem 'sqlite3'
	gem 'unicorn'
	gem 'ruby-debug19', :require => 'ruby-debug'
	gem 'autotest'	
	gem 'autotest-growl'
	gem 'rcov' 
	
	gem 'rspec', '>= 2.6'
	gem 'rspec-rails', '>= 2.6'
	
	gem 'factory_girl', '>= 2.0.0.beta'
	gem 'factory_girl_rails', :git => 'git://github.com/thoughtbot/factory_girl_rails.git', :tag => 'v1.1.beta1'
	
	# gem 'machinist', '>= 2.0.0.beta2'
	
	gem 'rails3-generators'
	#gem 'rspec'
	#gem 'rspec-rails'
end

group :development do
	gem 'therubyracer', :require => 'v8'
end

group :production do
	gem 'pg'
	gem 'therubyracer-heroku', '~> 0.8.1.pre3'
end

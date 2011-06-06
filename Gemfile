source 'http://rubygems.org'

gem 'rails', '3.1.0.rc1'

# gem "rails", :git => "git://github.com/rails/rails.git"
# gem "sprockets", :git => "git://github.com/sstephenson/sprockets.git"

gem 'rake', '~> 0.8.7'
gem 'sass'
gem 'haml'
#gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'devise'
gem 'kaminari'
gem 'inherited_resources'
gem 'simple_form'
gem 'gravatar_image_tag'
gem 'acts-as-taggable-on'
gem 'redcarpet', :git => 'git://github.com/tanoku/redcarpet.git'
# gem 'newrelic_rpm'

group :test, :development do
  gem 'turn', :require => false
	gem 'sqlite3'
	gem 'unicorn'
	gem 'ruby-debug19', :require => 'ruby-debug'
	gem 'rspec'
	gem 'rspec-rails'
	gem 'autotest'	
	gem 'rcov'
end

group :development do
	gem 'therubyracer', :require => 'v8'
end

group :production do
	gem 'pg'
	gem 'therubyracer-heroku', '~> 0.8.1.pre3'
end

source 'http://rubygems.org'

gem 'rails', '3.1.0.rc1'

# gem "rails", :git => "git://github.com/rails/rails.git"
# gem "sprockets", :git => "git://github.com/sstephenson/sprockets.git"

gem 'sass'
gem 'haml'
#gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'devise'

group :test, :development do
  gem 'turn', :require => false
	gem 'sqlite3'
	gem 'unicorn'
	gem 'ruby-debug19', :require => 'ruby-debug'
	gem 'rspec'
	gem 'rspec-rails'
	gem 'autotest'	
end

group :development do
	gem 'therubyracer', :require => 'v8'
end

group :production do
	gem 'pg'
	gem "therubyracer-heroku", "~> 0.8.1.pre3"
end
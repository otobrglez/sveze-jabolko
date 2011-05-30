source 'http://rubygems.org'

gem 'rails', '3.1.0.rc1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


# Asset template engines
gem 'sass'
#gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'

# Use unicorn as the web server

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development do
  # Pretty printed test output
  gem 'turn', :require => false
	gem 'sqlite3'
	gem 'unicorn'
	gem 'ruby-debug19', :require => 'ruby-debug'
	gem 'rspec'
	gem 'rspec-rails'
	gem "autotest"
end

group :development do
	gem 'therubyracer', :require => 'v8'
end

group :production do
	gem 'pg'
	gem "therubyracer-heroku", "~> 0.8.1.pre3"
end
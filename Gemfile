source 'http://rubygems.org'

gem 'rails', '~> 3.2.1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :production do
  gem 'pg'
end

gem 'thin'
gem 'haml'
gem 'geokit'
gem 'gmaps4rails', '~> 1.4.5'
gem 'twilio-ruby'
gem 'dynamic_form'
gem 'ruby-gmail'
gem 'foreman'
gem 'daemons'
gem 'mms2r'
gem 'mime'
gem 'bcrypt-ruby'
gem 'paperclip', "~> 3.0"
gem 'ruby-gmail'
gem 'therubyracer' # this is required for the coffeescript compiler to work on linux

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'factory_girl_rails'
  gem 'capybara'
end

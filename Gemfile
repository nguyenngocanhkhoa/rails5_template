source 'https://rubygems.org'

ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'puma', '~> 3.0'
gem 'rails', '4.2.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'bootstrap-sass'
gem 'chronic'
gem 'devise'
gem 'draper'
gem 'figaro'
gem 'font-awesome-rails'

# pagination tool
gem 'kaminari'
# handle javascript datetime
gem 'momentjs-rails'
# app monitoring
gem 'newrelic_rpm'
# database gem
gem 'pg'
# rollbase
gem 'pundit'
# frontend javascript bugs tracker
gem 'rollbar'
# bakend exception listener
gem 'sentry-raven'
# generate bootstrap easily
gem 'simple_form'
gem 'simple_form-bootstrap'
# use slim rather than default erb
gem 'slim-rails'
# to generate static pages like About page, Policy page
gem 'high_voltage', '~> 3.0.0'

# nested layout, allow to smaller layout rather than only applicatin layout
gem 'nestive'

# image uploader, can use to upload file to local storage or AWS S3
gem 'carrierwave', '>= 1.0.0.beta', '< 2.0'
# handle image storing
gem 'cloudinary'

# randomly generate avatar
gem "avatarly"

# background job
# this gem uses concurrent-ruby to create in-memory delay jobs, thus it can be deployed to any environment
# for more functionalities, we should use Sidekiq instead
gem 'sucker_punch'

# use this gem if we use Mailchimp API
# gem 'gibbon'

# payment gateway
#gem 'stripe'

# show progressbar while navigate between pages
gem 'nprogress-rails'

# to generate fake data for demo
gem 'factory_girl_rails'
gem 'faker'

# display friendly error page
gem 'gaffe'

# contact form, I guess every product we do will have at least one
gem 'mail_form'

# thin controller in Rails, move logic to service class
# read more: http://neethack.com/2015/06/rails-abstraction-showcase/
gem 'light-service'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen'
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-puma'
  gem 'guard-spring'
  gem 'letter_opener'
  gem 'rack-mini-profiler', require: false
  gem 'rails_layout'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-rubocop'
end
group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'rspec-rails'
  gem 'rubocop'
end
group :production do
  gem 'rails_12factor'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-json', require: false
end

source 'https://rubygems.org'
ruby "2.5.3"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
#Adding jquery-rails manually as not by default
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # For previewing emails in development
  gem 'letter_opener_web', '~> 1.0'
  gem 'bullet'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'popper_js', '~> 1.11.1'
gem 'bootstrap', '4.0.0.alpha6'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end

gem 'devise'

gem 'simple_form'

gem 'carrierwave', '~> 1.0'

gem 'font-awesome-rails'

gem 'quilljs-rails'

gem 'owlcarousel2-rails'

gem 'instagram_api_client'

gem "figaro"

gem 'friendly_id', '~> 5.1.0' # Note: You MUST use 5.0.0 or greater for Rails 4.0+

gem 'mini_magick'

gem 'fog-aws'

gem 'cookies_eu'

gem 'acts-as-taggable-on', github: 'mbleigh/acts-as-taggable-on'

gem 'truncate_html'

gem 'bootstrap-multiselect-rails'

gem 'ranked-model'

gem 'meta-tags'

gem 'animate-rails'

gem 'stripe'

gem 'stripe_event'

gem 'easypost'

gem 'omniauth-stripe-connect'

gem 'sendgrid-ruby'

gem 'sidekiq', '5.2.7'

gem 'phonelib'

gem 'groupdate'

gem 'chartkick'

gem 'to_csv-rails'

gem 'gibbon'

gem 'sitemap_generator'

gem 'active_link_to'

gem 'will_paginate', '~> 3.1.0'

gem 'lazyload-rails'

gem 'nokogiri'

gem 'inky-rb', require: 'inky'

gem "sentry-ruby"

gem 'sentry-ruby'

gem 'premailer-rails'
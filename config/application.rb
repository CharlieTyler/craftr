require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Craftr
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # Add the fonts path
    config.assets.paths << "#{Rails.root}/app/assets/fonts"

    # Precompile additional assets
    config.assets.precompile += %w( .svg .eot .woff .ttf emails.css)

    # Custom error pages - good for SEO - see https://medium.com/la-revanche-des-sites/seo-ruby-on-rails-the-comprehensive-guide-2018-b4101cc51b78
    config.exceptions_app = self.routes

    # Add Sentry for errors
    Raven.configure do |config|
      config.dsn = ENV["SENTRY_DNS"]
      config.environments = %w[ production ]
    end
  end
end

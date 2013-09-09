require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module SalesforceRails
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

VARS=%w(TOKEN_ENCRYPTION_KEY CONSUMER_KEY CONSUMER_SECRET)
VARS.keep_if{|var| ENV[var].nil? || ENV[var].empty?}
fail "Environment Variables required: #{VARS.join(',')}" if(!VARS.empty?)
require "base64"
require "databasedotcom-oauth2"
config.middleware.use Databasedotcom::OAuth2::WebServerFlow,
  "token_encryption_key" => Base64.strict_decode64(ENV['TOKEN_ENCRYPTION_KEY']),
  "display" => "touch", # will force salesforce login to be optimized for touch
  "endpoints" => {"justiceserver.jsdev.cs9.force.com" => {"key" => ENV['CONSUMER_KEY'], 
                                             "secret" => ENV['CONSUMER_SECRET']}}


  end
end

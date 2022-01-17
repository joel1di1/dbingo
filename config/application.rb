# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dbingo
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Paris"
    # config.eager_load_paths << Rails.root.join("extras")

    config.session_store :cookie_store, key: 'ijhugvcsbxnvbui4yewtdcghewjekdhcgjbyvaqwertyujdckj'
    config.middleware.use ActionDispatch::Cookies # Required for all session management
    config.middleware.use ActionDispatch::Session::CookieStore, config.session_options

    config.active_record.schema_format = :sql

    config.generators do |g|
      g.template_engine :slim
    end

    config.generators.helper = false
  end
end

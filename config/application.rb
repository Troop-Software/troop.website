require_relative 'boot'

require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TroopWebsite
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.troop_website = Hashie::Mash.new(Rails.application.config_for(:my_troop))

    config.time_zone = 'Eastern Time (US & Canada)'
    config.serve_static_assets = true
    config.active_job.queue_adapter = :delayed_job

  end
end

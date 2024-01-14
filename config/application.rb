require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Petsy
  class Application < Rails::Application
    config.load_defaults 7.1
    config.site = {
      name: 'Petsy'
    }

    config.autoload_lib(ignore: %w[assets tasks])

    config.generators do |g|
      g.assets false
      g.helper false
      g.jbuilder false
    end
  end
end

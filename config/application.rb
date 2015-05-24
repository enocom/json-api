require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "sprockets/railtie"

Bundler.setup(:default, Rails.env)

require "pry-rails"
require "rack/cors"

require "documentation"
require "movie_manager"

module JsonRails
  class Application < Rails::Application
    config.i18n.enforce_available_locales = true

    config.middleware.use Rack::Cors do
      allow do
        origins "*"
        resource "*", :headers => :any, :methods => [:get, :post, :delete, :put, :options]
      end
    end
  end
end

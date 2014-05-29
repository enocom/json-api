require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.setup(:default, Rails.env)

# Asset pipeline specific gems
require "jquery-rails"
require "angularjs-rails-resource"
require "angularjs-rails"
require "sass-rails"

module JsonRails
  class Application < Rails::Application
    config.i18n.enforce_available_locales = true
  end
end

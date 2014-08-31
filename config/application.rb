require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"

Bundler.setup(:default, Rails.env)

# Require pry here to set its as the default for console
require "pry"

module JsonRails
  class Application < Rails::Application
    config.i18n.enforce_available_locales = true
    config.console = Pry
  end
end

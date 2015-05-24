require "capybara/rspec"
require "capybara/poltergeist"

Capybara.javascript_driver = :poltergeist
Capybara.ignore_hidden_elements = true

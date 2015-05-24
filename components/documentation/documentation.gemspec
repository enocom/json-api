$:.push(File.expand_path("../lib", __FILE__))

require "documentation/version"

Gem::Specification.new do |s|
  s.name = "documentation"
  s.version = Documentation::VERSION
  s.files = Dir["{app,config,lib}/**/*"]

  s.add_dependency "rails", "4.1.5"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"
  s.add_development_dependency "poltergeist"
  s.add_development_dependency "pg"
end


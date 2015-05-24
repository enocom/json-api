$:.push(File.expand_path("../lib", __FILE__))

require "movie_manager/version"

Gem::Specification.new do |s|
  s.name = "movie_manager"
  s.version = MovieManager::VERSION
  s.files = Dir["{app,config,db,lib}/**/*"]

  s.add_dependency "oj"
  s.add_dependency "rails", "4.1.5"
  s.add_dependency "thin"

  s.add_development_dependency "pg"
  s.add_development_dependency "pry-rails"
  s.add_development_dependency "rspec-rails"
end

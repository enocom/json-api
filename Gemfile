source "https://rubygems.org"
ruby "2.1.2"

gem "pg"
gem "pry"
gem "rails", "4.1.5"
gem "thin"

group :development, :test do
  gem "rspec-rails"
end

group :test do
  gem "capybara"
  gem "database_cleaner"
  gem "poltergeist"
end

group :production do
  gem "rails_12factor" # for Heroku logging
end

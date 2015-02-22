require "sequel"
require "pg"
require "yaml"

db_url = if Rails.env.production?
           ENV["DATABASE_URL"]
         else
           # Development and Test
           db_config = YAML.load_file("config/database.yml")
           db_name = db_config[Rails.env]["database"]

           "postgres://localhost:5432/#{db_name}"
         end

DB = Sequel.connect(db_url)

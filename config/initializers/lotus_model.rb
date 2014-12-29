require "lotus/model"

def database_uri(config)
  ENV["DATABASE_URL"] || "postgres://localhost/#{config['database']}"
end

Lotus::Model.configure do
  adapter(type: :sql,
          uri: database_uri(Rails.configuration.database_configuration[Rails.env]))

  mapping do
    collection :movies do
      entity      Movie
      repository  MovieRepository

      attribute :id,       Integer
      attribute :director, String
      attribute :title,    String
    end
  end
end

Lotus::Model.load!

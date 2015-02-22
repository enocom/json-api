require_relative "../../config/database_connection"
require_relative "../../app/entities/movie"

class TestObjectFactory
  MOVIES = DB[:movies]

  def self.create_movie(attrs = {})
    whitelisted_attrs = {
      title: attrs[:title] || "The Shining",
      director: attrs[:director] || "Stanley Kubrick",
    }

    movie_id = MOVIES.insert(
      whitelisted_attrs.merge({
        created_at: attrs[:created_at] || Time.now.utc,
        updated_at: attrs[:updated_at] || Time.now.utc
      })
    )

    movie = Movie.new(whitelisted_attrs)
    movie.instance_variable_set(:@id, movie_id)
    movie
  end
end

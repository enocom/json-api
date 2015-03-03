require_relative "../../config/database_connection"
require_relative "../entities/movie"

class MovieRepository
  MOVIES_TABLE = DB[:movies]

  def self.all
    MOVIES_TABLE.all.map do |data|
      build_movie(data)
    end
  end

  def self.find(movie_id)
    movie_data = MOVIES_TABLE[id: movie_id]

    if movie_data
      build_movie(movie_data)
    else
      nil
    end
  end

  def self.persist(movie)
    movie_data = {
      title: movie.title,
      director: movie.director,
      created_at: Time.now.utc,
      updated_at: Time.now.utc
    }

    movie_id = MOVIES_TABLE.insert(movie_data)

    build_movie(movie_data.merge(id: movie_id))
  end

  def self.update(movie, attrs)
    whitelisted_attrs = attrs.inject({}) do |memo, (key, value)|
      if [:title, :director].include?(key.to_sym) && value != nil
        memo.merge(key.to_sym => value)
      else
        memo
      end
    end

    MOVIES_TABLE.where(id: movie.id).update(whitelisted_attrs)
    build_movie(movie.to_h.merge(whitelisted_attrs))
  end

  def self.delete(movie)
    deleted_records = MOVIES_TABLE.where(id: movie.id).delete

    deleted_records == 1
  end

  private

  def self.build_movie(data)
    movie = Movie.new(title: data[:title], director: data[:director])
    movie.instance_variable_set(:@id, data[:id])
    movie
  end
end

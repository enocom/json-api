module MovieManager
  class MovieRepo
    class PersistFailedError < StandardError
    end

    def self.all
      Movie.all.map { |m| build_movie(m) }
    end

    def self.find(movie_id)
      movie = Movie.find(movie_id)

      build_movie(movie)
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def self.persist(movie_attrs)
      m = Movie.create!(movie_attrs)

      build_movie(m)
    rescue
      raise PersistFailedError
    end

    def self.update(movie, attrs)
      m = Movie.find(movie.id)
      m.update_attributes(attrs)
      build_movie(m)
    end

    def self.delete(movie)
      delete_count = Movie.delete(movie.id)
      delete_count == 1
    end

    private

    def self.build_movie(m)
      MovieManager::Movie.new(id = m.id, title = m.title, director = m.director)
    end

    class Movie < ActiveRecord::Base
    end
  end
end

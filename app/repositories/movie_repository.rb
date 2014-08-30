require_relative "../models/movie"
require_relative "../entities/movie_entity"

class MovieRepository
  class MissingArgumentError < StandardError; end
  class RecordNotFoundError < StandardError; end

  def create(attributes)
    if attributes[:title].nil? || attributes[:title].empty? ||
      attributes[:director].nil? || attributes[:director].empty?
      raise MissingArgumentError, "Missing title or director param"
    end

    created_movie = Movie.create(attributes)

    create_entity(created_movie)
  end

  def update(id, attributes)
    updated_movie = Movie.update(id, attributes)

    create_entity(updated_movie)
  rescue ActiveRecord::RecordNotFound
    raise MovieRepository::RecordNotFoundError, "The record with id #{id} could not be found"
  end

  def find_by_id(id)
    found_movie = Movie.find(id)

    create_entity(found_movie)
  rescue ActiveRecord::RecordNotFound
    raise RecordNotFoundError, "The record with id #{id} could not be found"
  end

  def destroy(movie_id)
    destroyed_movie = Movie.destroy(movie_id)

    create_entity(destroyed_movie)
  rescue ActiveRecord::RecordNotFound
    raise RecordNotFoundError, "The record with id #{movie_id} could not be found"
  end

  def all
    Movie.all.map do |m|
      create_entity(m)
    end
  end

  private

  def create_entity(movie)
    MovieEntity.new(
      :id       => movie.id,
      :title    => movie.title,
      :director => movie.director
    )
  end

end

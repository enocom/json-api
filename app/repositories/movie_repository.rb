require_relative "../models/movie"
require_relative "../entities/movie_entity"

class MovieRepository
  class MissingArgumentError < StandardError; end
  class RecordNotFoundError < StandardError; end

  def create(attributes)
    created_movie = Movie.create!(attributes)
    create_entity(created_movie)
  rescue ActiveRecord::RecordInvalid
    raise MissingArgumentError, "Missing title or director param"
  end

  def update(id, attributes)
    movie = Movie.find(id)
    movie.update!(attributes)
    create_entity(movie)
  rescue ActiveRecord::RecordNotFound
    raise_record_not_found_error(id)
  rescue ActiveRecord::RecordInvalid
    raise MissingArgumentError, "Missing title or director param"
  end

  def find_by_id(id)
    found_movie = Movie.find(id)
    create_entity(found_movie)
  rescue ActiveRecord::RecordNotFound
    raise_record_not_found_error(id)
  end

  def destroy(id)
    destroyed_movie = Movie.destroy(id)
    create_entity(destroyed_movie)
  rescue ActiveRecord::RecordNotFound
    raise_record_not_found_error(id)
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

  def validate_attributes(attributes)
    if attributes[:title].nil? || attributes[:title].empty? ||
      attributes[:director].nil? || attributes[:director].empty?
      raise MissingArgumentError, "Missing title or director param"
    end
  end

  def raise_record_not_found_error(id)
    raise RecordNotFoundError, "The record with id #{id} could not be found"
  end

end

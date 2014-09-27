require_relative "../daos/movie_dao"
require_relative "../entities/movie_entity"

class MovieRepository
  class MissingArgumentError < StandardError; end
  class RecordNotFoundError < StandardError; end

  def create(attributes)
    created_movie = MovieDao.create!(attributes)
    create_entity(created_movie)
  rescue ActiveRecord::RecordInvalid
    raise_record_invalid
  end

  def update(id, attributes)
    movie = MovieDao.find(id)
    movie.update!(attributes)
    create_entity(movie)
  rescue ActiveRecord::RecordNotFound
    raise_record_not_found_error(id)
  rescue ActiveRecord::RecordInvalid
    raise_record_invalid
  end

  def find_by_id(id)
    found_movie = MovieDao.find(id)
    create_entity(found_movie)
  rescue ActiveRecord::RecordNotFound
    raise_record_not_found_error(id)
  end

  def destroy(id)
    destroyed_movie = MovieDao.destroy(id)
    create_entity(destroyed_movie)
  rescue ActiveRecord::RecordNotFound
    raise_record_not_found_error(id)
  end

  def all
    MovieDao.all.map do |m|
      create_entity(m)
    end
  end

  private

  def create_entity(movie)
    MovieEntity.new(
      :id        => movie.id,
      :title     => movie.title,
      :director  => movie.director
    )
  end

  def raise_record_not_found_error(id)
    raise RecordNotFoundError, "The record with id #{id} could not be found"
  end

  def raise_record_invalid
    raise MissingArgumentError, "Missing title or director param"
  end

end

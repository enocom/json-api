require_relative "../daos/movie_dao"
require_relative "../entities/movie_entity"

class MovieRepository

  def add(entity)
    record = MovieDao.new(entity.attributes)
    record.save

    MovieFactory.create(record)
  end

  def update(entity)
    record = MovieDao.find(entity.id)
    record.update(entity.attributes)

    MovieFactory.create(record)
  end

  def find_by_id(id)
    found_movie = MovieDao.find(id)
    create_entity(found_movie)
  end

  def destroy(id)
    destroyed_movie = MovieDao.destroy(id)
    create_entity(destroyed_movie)
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

end

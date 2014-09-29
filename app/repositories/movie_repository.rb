require_relative "../daos/movie_dao"
require_relative "../entities/movie_entity"

class MovieRepository
  def initialize(factory = MovieFactory)
    @factory = factory
  end

  def add(entity)
    record = MovieDao.new(entity.attributes)
    record.save

    factory.create(record)
  end

  def update(entity)
    record = MovieDao.find(entity.id)
    record.update(entity.attributes)

    factory.create(record)
  end

  def find_by_id(id)
    found_movie = MovieDao.find(id)
    factory.create(found_movie)
  end

  def destroy(id)
    destroyed_movie = MovieDao.destroy(id)
    factory.create(destroyed_movie)
  end

  def all
    MovieDao.all.map do |m|
      factory.create(m)
    end
  end

  private

  attr_reader :factory

end

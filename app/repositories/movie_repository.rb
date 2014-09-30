require_relative "../daos/movie_dao"
require_relative "../entities/movie_entity"

class MovieRepository
  def initialize(factory = MovieFactory)
    @factory = factory
  end

  def add(entity)
    record = MovieDao.new(entity.attributes)

    if record.save
      factory.create(record)
    else
      nil
    end
  end

  def update(entity)
    record = MovieDao.where(id: entity.id).first

    if record && record.update(entity.attributes)
      factory.create(record)
    else
      nil
    end
  end

  def find_by_id(id)
    found_movie = MovieDao.where(id: id).first

    if found_movie
      factory.create(found_movie)
    else
      nil
    end
  end

  def destroy(id)
    destroyed_record_count = MovieDao.delete(id)

    if destroyed_record_count.zero?
      false
    else
      true
    end
  end

  def all
    MovieDao.all.map do |m|
      factory.create(m)
    end
  end

  private

  attr_reader :factory

end

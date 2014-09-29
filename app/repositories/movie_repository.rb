require_relative "../daos/movie_dao"
require_relative "../entities/movie_entity"

class MovieRepository
  class RecordNotFound < StandardError; end

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
    record.update!(entity.attributes)
    factory.create(record)

  rescue ActiveRecord::RecordNotFound
    raise_record_not_found(entity.id)
  end

  def find_by_id(id)
    found_movie = MovieDao.find(id)
    factory.create(found_movie)
  rescue ActiveRecord::RecordNotFound
    raise_record_not_found(id)
  end

  def destroy(id)
    destroyed_movie = MovieDao.destroy(id)
    factory.create(destroyed_movie)
  rescue ActiveRecord::RecordNotFound
    raise_record_not_found(id)
  end

  def all
    MovieDao.all.map do |m|
      factory.create(m)
    end
  end

  private

  attr_reader :factory

  def raise_record_not_found(record_id)
    raise RecordNotFound, "The record with 'id'=#{record_id} was not found."
  end

end

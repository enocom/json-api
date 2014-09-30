require_relative "../daos/movie_dao"
require_relative "../entities/movie_entity"
require_relative "../shared/store_result"
require_relative "../shared/error_factory"

class MovieRepository
  def initialize(factory = MovieFactory)
    @factory = factory
  end

  def add(entity)
    record = MovieDao.new(entity.attributes)

    if record.save
      StoreResult.new(
        entity: factory.create(record),
        success: true,
        errors: nil
      )
    else
      StoreResult.new(
        entity: nil,
        success: false,
        errors: ErrorFactory.create(record.errors)
      )
    end
  end

  def update(entity)
    record = MovieDao.where(id: entity.id).first

    if record && record.update_attributes(entity.attributes)
      StoreResult.new(
        entity: factory.create(record),
        success: true,
        errors: nil
      )
    else
      errors = if record
                 ErrorFactory.create(record.errors)
               else
                 {base: "A record with 'id'=#{entity.id} was not found."}
               end
      StoreResult.new(
        entity: nil,
        success: false,
        errors: errors
      )
    end
  end

  def find_by_id(id)
    found_movie = MovieDao.where(id: id).first

    if found_movie
      StoreResult.new(
        entity: factory.create(found_movie),
        success: true,
        errors: nil
      )
    else
      StoreResult.new(
        entity: nil,
        success: false,
        errors: {base: "A record with 'id'=#{id} was not found."}
      )
    end
  end

  def destroy(id)
    destroyed_record_count = MovieDao.delete(id)

    if destroyed_record_count.zero?
      StoreResult.new(
        entity: nil,
        success: false,
        errors: {base: "A record with 'id'=#{id} was not found."}
      )
    else
      StoreResult.new(
        entity: nil,
        success: true,
        errors: nil
      )
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

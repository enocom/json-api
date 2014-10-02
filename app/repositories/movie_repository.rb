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
      return_successful_result(record)
    else
      return_failed_result_with_errors(record.errors)
    end
  end

  def update(entity)
    record = MovieDao.where(id: entity.id).first

    if record && record.update_attributes(entity.attributes)
      return_successful_result(record)
    else
      if record
        return_failed_result_with_errors(record.errors)
      else
        return_failed_result(entity.id)
      end
    end
  end

  def find_by_id(id)
    found_movie = MovieDao.where(id: id).first

    if found_movie
      return_successful_result(found_movie)
    else
      return_failed_result(id)
    end
  end

  def destroy(id)
    destroyed_record_count = MovieDao.delete(id)

    if destroyed_record_count.zero?
      return_failed_result(id)
    else
      return_successful_result
    end
  end

  def all
    MovieDao.all.map do |m|
      factory.create(m)
    end
  end

  private

  attr_reader :factory

  def return_successful_result(record = nil)
    entity = record ? factory.create(record) : nil

    StoreResult.new(
      entity: entity,
      success: true,
      errors: nil
    )
  end

  def return_failed_result(id)
    StoreResult.new(
      entity: nil,
      success: false,
      errors: {base: "A record with 'id'=#{id} was not found."}
    )
  end

  def return_failed_result_with_errors(errors)
    StoreResult.new(
      entity: nil,
      success: false,
      errors: ErrorFactory.create(errors)
    )
  end

end

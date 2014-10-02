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
      return successful_result(record)
    end

    failed_result_with_errors(record.errors)
  end

  def update(entity)
    record = MovieDao.where(id: entity.id).first

    if record && record.update_attributes(entity.attributes)
      return successful_result(record)
    end

    if record
      return failed_result_with_errors(record.errors)
    end

    failed_result(entity.id)
  end

  def find_by_id(id)
    found_movie = MovieDao.where(id: id).first

    if found_movie
      return successful_result(found_movie)
    end

    failed_result(id)
  end

  def destroy(id)
    destroyed_record_count = MovieDao.delete(id)

    if destroyed_record_count.zero?
      return failed_result(id)
    end

    successful_result
  end

  def all
    MovieDao.all.map do |m|
      factory.create(m)
    end
  end

  private

  attr_reader :factory

  def successful_result(record = nil)
    entity = record ? factory.create(record) : nil

    StoreResult.new(
      entity: entity,
      success: true,
      errors: nil
    )
  end

  def failed_result(id)
    StoreResult.new(
      entity: nil,
      success: false,
      errors: {base: "A record with 'id'=#{id} was not found."}
    )
  end

  def failed_result_with_errors(errors)
    StoreResult.new(
      entity: nil,
      success: false,
      errors: ErrorFactory.create(errors)
    )
  end

end

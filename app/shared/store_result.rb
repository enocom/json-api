class StoreResult

  attr_reader :entity, :errors

  def initialize(entity:, success:, errors:)
    @entity = entity
    @success = success
    @errors = errors
  end

  def success?
    success
  end

  private

  attr_reader :success

end

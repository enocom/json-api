class ErrorFactory
  class << self
    def create(errors)
      errors.map do |field, message|
        { field: field.to_s, message: message }
      end
    end
  end
end


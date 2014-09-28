require_relative "../entities/movie_entity"

class MovieFactory
  class << self
    def create(attributes)
      MovieEntity.new(attributes)
    end
  end
end

require_relative "../entities/movie_entity"

class MovieFactory
  class << self
    def create(record)
      MovieEntity.new(record)
    end
  end
end

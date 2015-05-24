module MovieManager
  class MovieSerializer
    def initialize(movie)
      @movie = movie
    end

    def as_json(options = {})
      {
          "id" => movie.id,
          "title" => movie.title,
          "director" => movie.director
      }
    end

    private

    attr_reader :movie
  end
end


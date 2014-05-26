class FakeMovieRepository
  module TestSupport
    def destroy_all
      @storage = []
    end
  end

  include TestSupport

  def initialize
    @storage = []
    @fake_id = 0
  end

  def create(attributes)
    @fake_id += 1
    attributes.merge!(:id => @fake_id)

    new_movie = MovieEntity.new(attributes)
    @storage << new_movie
    new_movie
  end

  def find_by_id(id)
    @storage.find { |movie| movie.id == id.to_i }
  end

  def update(id, attributes)
    movie = @storage.find { |movie| movie.id == id.to_i }

    movie.title = attributes["title"]
    movie.director = attributes["director"]

    movie
  end

  def destroy(id)
    @storage.reject! { |movie| movie.id == id.to_i }
  end

  def all
    @storage
  end

end

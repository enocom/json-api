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
    old_movie_index = @storage.index { |movie| movie.id == id.to_i }
    old_movie_attributes = @storage[old_movie_index].attributes

    new_movie = MovieEntity.new(
      old_movie_attributes.merge(attributes).symbolize_keys
    )

    @storage[old_movie_index] = new_movie

    new_movie
  end

  def destroy(id)
    @storage.reject! { |movie| movie.id == id.to_i }
  end

  def all
    @storage
  end

end

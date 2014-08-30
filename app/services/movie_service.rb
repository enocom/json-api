require_relative "../repositories/movie_repository"

class MovieService

  class MovieCreationError < StandardError; end
  class MovieLookupError < StandardError; end

  def initialize(repo = MovieRepository.new)
    @movie_repository = repo
  end

  def all
    movie_repository.all
  end

  def find(movie_id)
    movie_repository.find_by_id(movie_id)
  rescue MovieRepository::RecordNotFoundError => e
    raise MovieLookupError, e
  end

  def create(params)
    movie_repository.create(params)
  rescue MovieRepository::MissingArgumentError => e
    raise MovieCreationError, "Movie creation failed: Missing title or director param"
  end

  def update(movie_id, params)
    movie_repository.update(movie_id, params)
  rescue MovieRepository::RecordNotFoundError => e
    raise MovieLookupError, e
  end

  def destroy(movie_id)
    movie_repository.destroy(movie_id)
  end

  private

  attr_reader :movie_repository

end

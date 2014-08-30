require_relative "../repositories/movie_repository"

class MovieService

  class MovieCreationError < StandardError; end

  def initialize(repo = MovieRepository.new)
    @movie_repository = repo
  end

  def all
    movie_repository.all
  end

  def find(movie_id)
    movie_repository.find_by_id(movie_id)
  end

  def create(params)
    movie_repository.create(params)
  rescue MovieRepository::MissingArgumentError => e
    raise MovieCreationError, "Movie creation failed: Missing title or director param"
  end

  private

  attr_reader :movie_repository

end

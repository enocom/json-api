require_relative "../repositories/movie_repository"

class MovieService

  class MovieCreationError < StandardError; end

  def initialize(repo = MovieRepository.new)
    @movie_repository = repo
  end

  def create(params)
    movie_repository.create(params)
  rescue MovieRepository::MissingArgumentError => e
    raise MovieCreationError, "Movie creation failed: Missing title or director param"
  end

  private

  attr_reader :movie_repository

end

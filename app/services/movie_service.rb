require_relative "../repositories/movie_repository"

class MovieService

  class MovieCreationError < StandardError; end
  class MovieLookupError < StandardError; end

  def initialize(repo = MovieRepository.new, notifier = Notifier.new)
    @movie_repository = repo
    @notifier = notifier
  end

  def all
    movie_repository.all
  end

  def find(movie_id)
    movie_repository.find_by_id(movie_id)
  rescue MovieRepository::RecordNotFoundError => e
    raise_lookup_error(e)
  end

  def create(params)
    movie_entity = movie_repository.create(params)
    notifier.send_notification(movie_entity)
    movie_entity
  rescue MovieRepository::MissingArgumentError => e
    raise_creation_error
  end

  def update(movie_id, params)
    movie_repository.update(movie_id, params)
  rescue MovieRepository::RecordNotFoundError => e
    raise_lookup_error(e)
  end

  def destroy(movie_id)
    movie_repository.destroy(movie_id)
  rescue MovieRepository::RecordNotFoundError => e
    raise_lookup_error(e)
  end

  private

  attr_reader :movie_repository, :notifier

  def raise_lookup_error(e)
    raise MovieLookupError, e
  end

  def raise_creation_error
    raise MovieCreationError, "Movie creation failed: Missing title or director param"
  end

end

require_relative "../repositories/movie_repository"
require_relative "../factories/movie_factory"
require_relative "../shared/null_listener"

class MovieService

  def initialize(listener: NullListener.new, repo: MovieRepository.new, factory: MovieFactory)
    @movie_repository = repo
    @factory = factory
    @listener = listener
  end

  def all
    movie_repository.all
  end

  def find(movie_id)
    result = movie_repository.find_by_id(movie_id)

    if result.success?
      listener.show_success(result.entity)
    else
      listener.show_failure(result.error)
    end
  end

  def create(attributes)
    new_entity = factory.create(attributes)
    result = movie_repository.add(new_entity)

    if result.success?
      listener.create_success(result.entity)
    else
      listener.create_failure(result.error)
    end
  end

  def update(movie_id, attributes)
    entity_to_update = factory.create(attributes.merge(:id => movie_id))
    result = movie_repository.update(entity_to_update)

    if result.success?
      listener.update_success(result.entity)
    else
      listener.update_failure(result.error)
    end
  end

  def destroy(movie_id)
    result = movie_repository.destroy(movie_id)

    if result.success?
      listener.destroy_success
    else
      listener.destroy_failure(result.error)
    end
  end

  private

  attr_reader :movie_repository, :factory, :listener

end

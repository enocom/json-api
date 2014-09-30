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

    notify_listener(:show, result)
  end

  def create(attributes)
    new_entity = factory.create(attributes)
    result = movie_repository.add(new_entity)

    notify_listener(:create, result)
  end

  def update(movie_id, attributes)
    entity_to_update = factory.create(attributes.merge(:id => movie_id))
    result = movie_repository.update(entity_to_update)

    notify_listener(:update, result)
  end

  def destroy(movie_id)
    result = movie_repository.destroy(movie_id)

    notify_listener(:destroy, result)
  end

  private

  attr_reader :movie_repository, :factory, :listener

  def notify_listener(notification, result)
    if result.success?
      listener.send("#{notification}_success", result.entity)
    else
      listener.send("#{notification}_failure", result.error)
    end
  end

end

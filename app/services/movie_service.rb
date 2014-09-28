require_relative "../repositories/movie_repository"
require_relative "../factories/movie_factory"

class MovieService

  def initialize(repo = MovieRepository.new, factory = MovieFactory)
    @movie_repository = repo
    @factory = factory
  end

  def all
    movie_repository.all
  end

  def find(movie_id)
    movie_repository.find_by_id(movie_id)
  end

  def create(attributes)
    new_entity = factory.create(attributes)
    movie_entity = movie_repository.add(new_entity)
    movie_entity
  end

  def update(movie_id, attributes)
    entity_to_update = factory.create(attributes.merge(:id => movie_id))
    movie_repository.update(entity_to_update)
  end

  def destroy(movie_id)
    movie_repository.destroy(movie_id)
  end

  private

  attr_reader :movie_repository, :factory

end

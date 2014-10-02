UpdateMovie = ->(id:, attributes:, repo: MovieRepository.new, listener: NullListener.new) do
  entity_to_update = MovieFactory.create(attributes.merge(id: id))
  result = repo.update(entity_to_update)

  if result.success?
    listener.update_success(result.entity)
  else
    listener.update_failure(result.errors)
  end
end

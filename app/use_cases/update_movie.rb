UpdateMovie = ->(id:, attributes:, repo: MovieRepository.new) do
  entity_to_update = MovieFactory.create(attributes.merge(id: id))

  repo.update(entity_to_update)
end

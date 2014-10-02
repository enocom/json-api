CreateMovie = ->(attributes:, repo: MovieRepository.new, listener: NullListener.new) do
  new_entity = MovieFactory.create(attributes)
  result = repo.add(new_entity)

  if result.success?
    listener.create_success(result.entity)
  else
    listener.create_failure(result.error)
  end
end


CreateMovie = ->(attributes:, repo: MovieRepository.new, listener: NullListener.new) do
  new_entity = MovieFactory.create(attributes)
  repo.add(new_entity)
end


ShowMovie = ->(id:, repo: MovieRepository.new, listener: NullListener.new) do
  result = repo.find_by_id(id)

  if result.success?
    listener.show_success(result.entity)
  else
    listener.show_failure(result.errors)
  end
end

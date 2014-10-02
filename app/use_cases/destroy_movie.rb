DestroyMovie = ->(id:, repo: MovieRepository.new, listener: NullListener.new) do
  result = repo.destroy(id)

  if result.success?
    listener.destroy_success(result.entity)
  else
    listener.destroy_failure(result.error)
  end
end

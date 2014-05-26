require_relative "../fake_repositories/movie_repository"
Rails.application.config.movie_repository = FakeMovieRepository.new

module MovieManager
  class MoviesController < ActionController::Base
    protect_from_forgery with: :null_session

    def index
      all_movies = MovieRepo.all.map do |movie|
        MovieSerializer.new(movie).as_json
      end

      render json: all_movies
    end

    def show
      movie = MovieRepo.find(params[:id])

      if movie.present?
        render json: MovieSerializer.new(movie).as_json
      else
        render json: { errors: ["Movie not found"] }, status: :not_found
      end
    end

    def update
      movie = MovieRepo.find(params[:id])
      updated_movie = MovieRepo.update(movie, movie_params)

      render json: MovieSerializer.new(updated_movie).as_json
    end

    def create
      persisted_movie = MovieRepo.persist(
        title: movie_params[:title],
        director: movie_params[:director]
      )

      render json: MovieSerializer.new(persisted_movie).as_json,
        location: movie_path(persisted_movie.id),
        status: :created
    end

    def destroy
      movie = MovieRepo.find(params[:id])

      MovieRepo.delete(movie)

      head :no_content
    end

    private

    def movie_params
      params.permit(:title, :director)
    end

  end
end

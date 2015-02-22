module Api
  class MoviesController < ApplicationController

    def index
      render json: MovieRepository.all
    end

    def show
      movie = MovieRepository.find(params[:id])

      if movie
        render json: movie
      else
        render json: { errors: ["Movie not found"] }, status: :not_found
      end
    end

    def update
      movie = MovieRepository.find(params[:id])
      updated_movie = MovieRepository.update(movie, movie_params)

      render json: updated_movie
    end

    def create
      movie = Movie.new(title: movie_params[:title],
                        director: movie_params[:director])

      persisted_movie = MovieRepository.persist(movie)

      render json: movie, location: api_movie_path(persisted_movie.id),
        status: :created
    end

    def destroy
      movie = MovieRepository.find(params[:id])

      MovieRepository.delete(movie)

      head :no_content
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :director)
    end

  end
end

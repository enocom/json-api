module Api
  class MoviesController < ApplicationController

    def index
      render json: MovieRepository.all
    end

    def show
      m = MovieRepository.find(params[:id])

      if m
        render json: m
      else
        render json: { errors: ["Movie not found"] }, status: :not_found
      end
    end

    def update
      movie = Movie.new(movie_params.merge(id: params[:id]))

      MovieRepository.update(movie)

      render json: movie
    end

    def create
      movie = Movie.new(title: movie_params[:title], director: movie_params[:director])

      MovieRepository.persist(movie)

      render json: movie, location: api_movie_path(movie.id),
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

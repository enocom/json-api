module Api
  class MoviesController < ApplicationController

    def index
      render json: MovieService.new.all
    end

    def show
      render json: MovieService.new.find(params[:id])
    end

    def update
      render json: MovieService.new.update(params[:id], movie_params)
    end

    def create
      created_movie = MovieService.new.create(movie_params)
      render json: created_movie, location: api_movie_path(created_movie.id),
        status: :created
    end

    def destroy
      MovieService.new.destroy(params[:id])
      head :no_content
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :director)
    end

  end
end

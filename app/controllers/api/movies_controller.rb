module Api
  class MoviesController < ApplicationController

    def index
      render json: MovieService.new.all
    end

    def show
      render json: MovieService.new.find(params[:id])
    rescue MovieService::MovieLookupError => e
      render_error(e)
    end

    def update
      render json: MovieService.new.update(params[:id], movie_params)
    rescue MovieService::MovieLookupError => e
      render_error(e)
    end

    def create
      created_movie = MovieService.new.create(movie_params)
      render json: created_movie, location: api_movie_path(created_movie.id),
        status: :created
    rescue MovieService::MovieCreationError => e
      render_error(e)
    end

    def destroy
      MovieService.new.destroy(params[:id])
      head :no_content
    rescue MovieService::MovieLookupError => e
      render_error(e)
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :director)
    end

    def render_error(e)
      error_response = { "error" => e.to_s }.to_json
      render json: error_response, status: 400
    end
  end
end

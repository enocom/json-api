module Api
  class MoviesController < ApplicationController
    respond_to :json

    def index
      respond_with MovieService.new.all
    end

    def show
      respond_with MovieService.new.find(params[:id])
    rescue MovieService::MovieLookupError => e
      error_response = { "error" => e.to_s }.to_json
      render json: error_response, status: 400
    end

    def update
      respond_with MovieService.new.update(params[:id], movie_params)
    rescue MovieService::MovieLookupError => e
      error_response = { "error" => e.to_s }.to_json
      render json: error_response, status: 400
    end

    def create
      created_movie = MovieService.new.create(movie_params)
      respond_with created_movie, location: api_movie_path(created_movie.id)
    rescue MovieService::MovieCreationError => e
      error_response = { "error" => e.to_s }.to_json
      render json: error_response, status: 400
    end

    def destroy
      MovieService.new.destroy(params[:id])
      head :no_content
    rescue MovieService::MovieLookupError => e
      error_response = { "error" => e.to_s }.to_json
      render json: error_response, status: 400
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :director)
    end
  end
end

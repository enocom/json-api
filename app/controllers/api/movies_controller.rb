module Api
  class MoviesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    respond_to :json

    def index
      respond_with movie_repository.all
    end

    def show
      respond_with movie_repository.find_by_id(params[:id])
    end

    def update
      respond_with movie_repository.update(params[:id], movie_params)
    end

    def create
      # TODO: Respond with the location of the resource
      respond_with movie_repository.create(movie_params), location: nil
    end

    def destroy
      respond_with movie_repository.destroy(params[:id])
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :director)
    end

    def movie_repository
      Rails.application.config.movie_repository
    end
  end
end

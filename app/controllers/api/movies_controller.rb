module Api
  class MoviesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    respond_to :json

    def index
      respond_with Movie.all
    end

    def show
      respond_with Movie.find(params[:id])
    end

    def update
      respond_with Movie.update(params[:id], movie_params)
    end

    def create
      respond_with Movie.create(movie_params)
    end

    def destroy
      respond_with Movie.destroy(params[:id])
    end

    private

    def movie_params
      params.require(:movie).permit(:title)
    end
  end
end

module Api
  class MoviesController < ApplicationController

    def index
      render json: movie_service.all
    end

    def show
      movie_service.find(params[:id])
    end

    def show_success(record)
      render json: record
    end

    def show_failure(error)
      render json: error, status: 404
    end

    def update
      movie_service.update(params[:id], movie_params)
    end

    def update_success(record)
      render json: record
    end

    def update_failure(error)
      # pending
    end

    def create
      movie_service.create(movie_params)
    end

    def create_success(record)
      render json: record, location: api_movie_path(record.id),
        status: :created
    end

    def create_failure(error)
      # pending
    end

    def destroy
      movie_service.destroy(params[:id])
    end

    def destroy_success(_)
      head :no_content
    end

    def destroy_failure(error)
      # pending
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :director)
    end

    def movie_service
      MovieService.new(listener: self)
    end

  end
end

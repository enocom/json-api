module Api
  class MoviesController < ApplicationController
    def index
      render json: ListMovies.call
    end

    def show
      ShowMovie.call(id: params[:id], listener: self)
    end

    def show_success(record)
      render json: record
    end

    def show_failure(error)
      render json: error, status: 404
    end

    def update
      UpdateMovie.call(id: params[:id], attributes: movie_params, listener: self)
    end

    def update_success(record)
      render json: record
    end

    def update_failure(error)
      # pending
    end

    def create
      CreateMovie.call(attributes: movie_params, listener: self)
    end

    def create_success(record)
      render json: record, location: api_movie_path(record.id),
        status: :created
    end

    def create_failure(error)
      # pending
    end

    def destroy
      DestroyMovie.call(id: params[:id], listener: self)
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

  end
end

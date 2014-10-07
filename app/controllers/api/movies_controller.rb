module Api
  class MoviesController < ApplicationController
    def index
      render json: ListMovies.call
    end

    def show
      result = MovieRepository.new.find_by_id(params[:id])

      if result.success?
        render json: result.entity
      else
        render json: { errors: result.errors }, status: :not_found
      end
    end

    def update
      UpdateMovie.call(id: params[:id], attributes: movie_params, listener: self)
    end

    def update_success(record)
      render json: record
    end

    def update_failure(errors)
      render json: { errors: errors }, status: :unprocessable_entity
    end

    def create
      CreateMovie.call(attributes: movie_params, listener: self)
    end

    def create_success(record)
      render json: record, location: api_movie_path(record.id),
        status: :created
    end

    def create_failure(errors)
      render json: { errors: errors }, status: :unprocessable_entity
    end

    def destroy
      DestroyMovie.call(id: params[:id], listener: self)
    end

    def destroy_success(_)
      head :no_content
    end

    def destroy_failure(errors)
      render json: { errors: errors }, status: :not_found
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :director)
    end

  end
end

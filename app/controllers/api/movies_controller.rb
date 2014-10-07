module Api
  class MoviesController < ApplicationController
    def index
      render json: MovieRepository.new.all
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
      result = UpdateMovie.call(id: params[:id], attributes: movie_params)

      if result.success?
        render json: result.entity
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    def create
      result = CreateMovie.call(attributes: movie_params, listener: self)

      if result.success?
        render json: result.entity, location: api_movie_path(result.entity.id),
          status: :created
      else
        render json: { errors: result.errors }, status: :unprocessable_entity
      end
    end

    def destroy
      result = MovieRepository.new.destroy(params[:id])

      if result.success?
        head :no_content
      else
        render json: { errors: result.errors }, status: :not_found
      end
    end

    private

    def movie_params
      params.require(:movie).permit(:title, :director)
    end

  end
end

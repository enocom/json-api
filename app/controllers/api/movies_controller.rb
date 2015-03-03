module Api
  class MoviesController < ApplicationController

    def index
      all_movies = MovieRepository.all.map do |movie|
        MovieSerializer.new(movie).as_json
      end

      render json: all_movies
    end

    def show
      movie = MovieRepository.find(params[:id])

      if movie
        render json: MovieSerializer.new(movie).as_json
      else
        render json: { errors: ["Movie not found"] }, status: :not_found
      end
    end

    def update
      movie = MovieRepository.find(params[:id])
      updated_movie = MovieRepository.update(movie, movie_params)

      render json: MovieSerializer.new(updated_movie).as_json
    end

    def create
      movie = Movie.new(title: movie_params[:title],
                        director: movie_params[:director])

      persisted_movie = MovieRepository.persist(movie)

      render json: MovieSerializer.new(persisted_movie).as_json,
        location: api_movie_path(persisted_movie.id),
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

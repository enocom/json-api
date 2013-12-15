class MoviesController < ApplicationController
  respond_to :json

  def index
    respond_with Movie.all
  end

  def show
    movie = Movie.find(params[:id])
    respond_with movie
  end

  def update
    movie = Movie.find(params[:id])
    movie.update_attributes(movie_params)
    head :no_content
  end

  def create
    Movie.create(movie_params)
    head :no_content
  end

  private

  def movie_params
    params.require(:movie).permit(:title)
  end
end

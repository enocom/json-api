class AddDirectorToMovies < ActiveRecord::Migration
  def change
    add_column :movie_manager_movies, :director, :string
  end
end

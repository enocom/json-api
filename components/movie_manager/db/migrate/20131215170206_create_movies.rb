class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movie_manager_movies do |t|
      t.string :title, null: false, unique: true
    end
  end
end

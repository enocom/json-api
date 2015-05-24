class AddTimestampsToMovies < ActiveRecord::Migration
  def change
    change_table :movie_manager_movies do |t|
      t.timestamps
    end
  end
end

class RemoveFanEmailFromMovies < ActiveRecord::Migration
  def change
    remove_column :movies, :fan_email
  end
end

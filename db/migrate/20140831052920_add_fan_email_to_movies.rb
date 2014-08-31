class AddFanEmailToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :fan_email, :string
  end
end

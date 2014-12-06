class AddTimestampsToMovies < ActiveRecord::Migration
  def change
    change_table :movies do |t|
      t.timestamps
    end
  end
end

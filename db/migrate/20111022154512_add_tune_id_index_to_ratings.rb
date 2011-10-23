class AddTuneIdIndexToRatings < ActiveRecord::Migration
  def change
    add_index :ratings, :tune_id
  end
end

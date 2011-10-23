class AddTuneIdToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :tune_id, :integer
  end
end

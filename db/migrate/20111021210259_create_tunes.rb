class CreateTunes < ActiveRecord::Migration
  def change
    create_table :tunes do |t|
      t.string :url
      t.string :title
      t.string :artist_name
      t.integer :duration

      t.timestamps
    end
  end
end

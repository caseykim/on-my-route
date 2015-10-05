class CreateLinesStations < ActiveRecord::Migration
  def change
    create_table :lines_stations do |t|
      t.belongs_to :line, null: false
      t.belongs_to :station, null: false
      t.integer :station_sequence, null: false
    end
    add_index :lines_stations, [:line_id, :station_id], unique: true
  end
end

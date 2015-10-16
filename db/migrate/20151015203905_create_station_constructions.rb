class CreateStationConstructions < ActiveRecord::Migration
  def change
    create_table :station_constructions do |t|
      t.belongs_to :station, null: false
      t.belongs_to :construction, null: false
      t.index [:station_id, :construction_id], unique: true
    end
  end
end

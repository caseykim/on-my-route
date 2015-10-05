class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name, null: false
    end
    add_index :stations, :name, unique: true
  end
end

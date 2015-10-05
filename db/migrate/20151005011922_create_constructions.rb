class CreateConstructions < ActiveRecord::Migration
  def change
    create_table :constructions do |t|
      t.belongs_to :line, null: false
      t.belongs_to :start_station, null: false
      t.belongs_to :end_station, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :start_time, null: false
      t.string :end_time
      t.string :description

      t.timestamps null: false
    end
    add_index :constructions, :line_id
  end
end

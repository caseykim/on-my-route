class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name, null: false
      t.string :color
    end
    add_index :lines, :name, unique: true
  end
end

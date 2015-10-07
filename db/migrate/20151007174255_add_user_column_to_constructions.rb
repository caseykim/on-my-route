class AddUserColumnToConstructions < ActiveRecord::Migration
  def change
    add_column :constructions, :user_id, :integer
  end
end

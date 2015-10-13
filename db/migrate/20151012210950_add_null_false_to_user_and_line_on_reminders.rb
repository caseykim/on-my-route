class AddNullFalseToUserAndLineOnReminders < ActiveRecord::Migration
  def up
    change_column :reminders, :user_id, :integer, null: false
    change_column :reminders, :line_id, :integer, null: false
    add_index :reminders, [:user_id, :line_id], unique: true
  end

  def down
    change_column :reminders, :user_id, :integer
    change_column :reminders, :line_id, :integer
    remove_index :reminders, [:user_id, :line_id]
  end
end

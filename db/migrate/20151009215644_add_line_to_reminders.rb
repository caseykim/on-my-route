class AddLineToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :line_id, :integer
  end
end

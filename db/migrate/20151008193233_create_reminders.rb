class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end

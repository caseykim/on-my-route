class AddDefaultValueToImage < ActiveRecord::Migration
  def up
    change_column :users, :image, :string, default: '/thomastrain.jpg'
  end
  def down
    change_column :users, :image, :string
  end
end

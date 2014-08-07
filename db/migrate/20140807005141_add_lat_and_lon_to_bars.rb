class AddLatAndLonToBars < ActiveRecord::Migration
  def change
    add_column :bars, :lat, :decimal, precision: 11, scale: 8, required: true
    add_column :bars, :lon, :decimal, precision: 11, scale: 8, required: true
  end
end

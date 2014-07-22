class AddIndexOnPlaceIdToBars < ActiveRecord::Migration
  def up
    add_index 'bars', 'place_id', unique: true
  end

  def down
    remove_index 'bars', column: 'place_id'
  end
end

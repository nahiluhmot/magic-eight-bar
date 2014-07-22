class CreateBars < ActiveRecord::Migration
  def change
    create_table :bars do |t|
      t.string :name, limit: 120, null: false
      t.string :place_id, limit: 40, unique: true, null: false
      t.string :address, limit: 120, null: false

      t.timestamps
    end
  end
end

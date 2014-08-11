class AddAdditionalFieldsToBar < ActiveRecord::Migration
  def up
    add_column :bars, :website, :string
  end

  def down
    remove_column :bars, :website
  end
end

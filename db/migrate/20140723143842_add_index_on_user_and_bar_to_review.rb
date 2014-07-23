class AddIndexOnUserAndBarToReview < ActiveRecord::Migration
  def change
    add_index :reviews, [:user_id, :bar_id], unique: true
  end
end

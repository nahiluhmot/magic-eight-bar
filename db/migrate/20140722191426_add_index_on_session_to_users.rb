class AddIndexOnSessionToUsers < ActiveRecord::Migration
  def up
    add_index 'users', 'session', unique: true
  end

  def down
    remove_index 'users', column: 'session'
  end
end

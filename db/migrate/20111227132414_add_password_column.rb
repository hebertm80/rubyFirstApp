class AddPasswordColumn < ActiveRecord::Migration
  def up
    add_column :users, :password, :string
  end

  def down
    add_column :users ,:password
  end
end

class AddDetailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :place, :string
    add_column :users, :profile, :string
  end
end

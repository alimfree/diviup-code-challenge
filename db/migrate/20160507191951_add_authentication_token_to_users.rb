class AddAuthenticationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :access_token, :string, default: ""
	add_index :users, :access_token, unique: true
  end
end

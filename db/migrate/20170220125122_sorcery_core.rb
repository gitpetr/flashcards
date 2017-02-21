class SorceryCore < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :password, :crypted_password
    add_column :users, :salt, :string
    change_column :users, :email, :string, :null => false
    add_index :users, :email, unique: true
  end
end

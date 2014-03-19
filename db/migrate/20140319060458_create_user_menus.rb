# -*- encoding : utf-8 -*-
class CreateUserMenus < ActiveRecord::Migration
  def change
    create_table :user_menus do |t|
    	t.references :user, :null => false
      t.references :menu, :null => false

      t.timestamps
    end
    add_index :user_menus, [:user_id, :menu_id]
  end
end

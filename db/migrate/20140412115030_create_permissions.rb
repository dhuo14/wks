# -*- encoding : utf-8 -*-
class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
			t.string :action      , :comment => "权限", :null => false
			t.string :subject     , :comment => "对象", :null => false
			t.string :description , :comment => "描述", :null => false
      t.timestamps
    end
    add_index :permissions, [:action,:subject]
  end
end
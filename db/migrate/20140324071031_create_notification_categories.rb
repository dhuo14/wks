# -*- encoding : utf-8 -*-
class CreateNotificationCategories < ActiveRecord::Migration
  def change
    create_table :notification_categories do |t|
	  t.string :name                   , :comment => "名称", :null => false
	  t.string :ancestry               , :comment => "祖先节点"
	  t.integer :ancestry_depth        , :comment => "层级"
    t.string :icon                   , :comment => "图标"
    t.string :icon_color             , :comment => "图标颜色"
    t.integer :status                , :comment => "状态", :limit => 2, :default => 0 ,:null => false
	  t.integer :sort                  , :comment => "排序"

    t.timestamps
    end
    add_index :notification_categories, :name,                :unique => true
  end
end

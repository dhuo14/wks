# -*- encoding : utf-8 -*-
class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
	  t.string :name                   , :comment => "名称", :null => false
	  t.string :ancestry               , :comment => "祖先节点"
	  t.integer :ancestry_depth        , :comment => "层级"
    t.string :icon                   , :comment => "图标"
    t.integer :status                , :comment => "状态", :limit => 2, :default => 0 ,:null => false
	  t.integer :sort                  , :comment => "排序"

    t.timestamps
    end
    add_index :article_categories, :name,                :unique => true
  end
end

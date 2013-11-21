# -*- encoding : utf-8 -*-
class CreateCategory < ActiveRecord::Migration
  def change
    create_table :category do |t|
    	t.string :name                   , :comment => "单位名称"
		t.string :ancestry               , :comment => "祖先节点"
		t.integer :ancestry_depth        , :comment => "层级"
		t.integer :status                , :comment => "状态", :limit => 2, :default => 0 ,:null => false
    end
  end
end
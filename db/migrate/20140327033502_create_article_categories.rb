# -*- encoding : utf-8 -*-
class CreateArticleCategories < ActiveRecord::Migration
  def change
    create_table :article_categories do |t|
    	t.integer :article_id 
    	t.integer :category_id 
    end
    add_index :article_categories, [:article_id, :category_id]
  end
end

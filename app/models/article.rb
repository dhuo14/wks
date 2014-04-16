# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
	belongs_to :author, class_name: "User", foreign_key: "user_id"
	has_one :content, class_name: "ArticleContent", :dependent => :destroy
	# has_many :uploads, class_name: "ArcitleUpload"
	has_and_belongs_to_many :article_categories
	accepts_nested_attributes_for :article_categories, :content
 #  accepts_nested_attributes_for :uploads

end

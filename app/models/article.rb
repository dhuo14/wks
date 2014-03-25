# -*- encoding : utf-8 -*-
class Article < ActiveRecord::Base
	belongs_to :author, class_name: "User", foreign_key: "user_id"
	belongs_to :category_category #, class_name: "NotificationCategory", foreign_key: "notification_category_id"
end

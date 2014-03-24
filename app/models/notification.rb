# -*- encoding : utf-8 -*-
class Notification < ActiveRecord::Base
	belongs_to :sender, class_name: "User", foreign_key: "sender_id"
	belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"
	belongs_to :category, class_name: "NotificationCategory", foreign_key: "notification_category_id"
end

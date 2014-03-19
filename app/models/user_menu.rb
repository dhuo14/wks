# -*- encoding : utf-8 -*-
class UserMenu < ActiveRecord::Base
	belongs_to :user
	belongs_to :menu 
end

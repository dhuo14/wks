# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base

  belongs_to :department

  # 是否超级管理员,超级管理员不留操作痕迹
  def is_webmaster?
  	self.login == "admin"
  end
end

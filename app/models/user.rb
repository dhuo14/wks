# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  belongs_to :department
  has_many :user_menus, dependent: :destroy
  has_many :menus, :through => :user_menus, :source => :menu

  # 是否超级管理员,超级管理员不留操作痕迹
  def is_webmaster?
  	self.login == "admin"
  end

   # 密码加密
  def encode_password
    self.password += "_我是加密的" unless self.password.blank?
  end

  # 密码解密
  def decode_password
    return self.password.gsub("_我是加密的","")
  end

end

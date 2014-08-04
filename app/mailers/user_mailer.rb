# -*- encoding : utf-8 -*-
class UserMailer < ActionMailer::Base
  default from: "zcladmin@163.com"
  # self.async = true

  def registration_confirmation(user)
		mail :to => "dhuo14@163.com", :subject => "测试的激活邮件"
	end

end

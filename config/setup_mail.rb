# -*- encoding : utf-8 -*-

ActionMailer::Base.default_charset = "utf-8"   #  设置发送邮件的内容的编码类型
ActionMailer::Base.default_content_type = "text/html"   # 发送邮件的默认内容类型
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
:address => "smtp.163.com",
:port => 25,
:domain => "163.com",
:user_name => "zcladmin@163.com",
:password => "zcl100044",
#是否允许SMTP客户机使用用户ID AND PASSWORD或其他认证技术向服务器正确标识自己的身份,plain使用文本方式的用户名和认证id和口令 
:authentication => :login, 
#是否使用ttl/lls加密，当为'true'时，必须使用官网提供的ttl端口号，gmail为587
# :enable_starttls_auto => false 
}
ActionMailer::Base.raise_delivery_errors = true
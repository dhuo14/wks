class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # 开发给view层用的方法
  helper_method :current_user, :signed_in?

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token:remember_token)
  end

  def signed_in?
    !current_user.nil?
  end



  protected

  #着重提示，等用户手动关闭
  def flash_get(message,status="error")
    unless message.class == Array
      message = [message]
    end
    flash[status] = message
  end

  #普通提示，自动关闭
  def tips_get(message)
    flash[:tips] = message
  end

  # 发送邮件
  def _send_email(email,title,content)
    # 这里是发送邮件的代码，暂缺
  end

  #  写入日志 确保表里面有logs和status字段才能用这个函数
  def _write_logs(record,content,remark='',user=current_user)
    unless user.is_webmaster?  # 特殊情况下超级管理员后台修改不记录
      unless record.logs.nil?
        new_doc = Nokogiri::XML(record.logs)
      else
        new_doc = Nokogiri::XML::Document.new()
        new_doc.encoding = "UTF-8"
        new_doc << "<root>"
      end
      node = new_doc.root.add_child("<node>").first
      node["操作时间"] = Time.new.to_s
      node["操作人ID"] = user.id.to_s
      node["操作人姓名"] = user.name.to_s
      node["操作人单位"] = user.department.nil? ? "暂无" : user.department.name.to_s
      node["操作内容"] = content
      node["当前状态"] = (!record.attribute_names.include?("status") || record.status.nil?) ? "-" : record.status
      node["备注"] = remark
      node["IP地址"] = "#{request.remote_ip}|#{IPParse.parse(request.remote_ip).gsub("Unknown", "未知")}"
      record.update_columns("logs" => new_doc.to_s)
    end
  end


end

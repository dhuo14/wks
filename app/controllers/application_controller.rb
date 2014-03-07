class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception



  protected

  #弹框提示
  def flash_notice(notice=nil)
    flash["notice"] = notice
  end

  # 当前用户
  def current_user
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  # 身份验证
  def authenticate 
    deny_access unless signed_in? 
  end

  # 是否登录?
  def signed_in?
  	!current_user.nil? 
  end

  def deny_access  
    redirect_to signin_path, :notice => "请您先登录！" 
  end 

  #  写入日志 确保表里面有logs和status字段才能用这个函数
  def _write_logs(record,content,remark='')
    unless current_user.is_webmaster?  # 特殊情况下超级管理员后台修改不记录
      unless record.logs.nil?
        new_doc = Nokogiri::XML(record.logs)
      else
        new_doc = Nokogiri::XML::Document.new()
        new_doc.encoding = "UTF-8"
        new_doc << "<root>"
      end
      node = new_doc.root.add_child("<node>").first
      node["操作时间"] = Time.new.to_s
      node["操作人ID"] = current_user.id.to_s
      node["操作人姓名"] = current_user.name.to_s
      node["操作人单位"] = current_user.department.name.to_s
      node["操作内容"] = content
      node["当前状态"] = (!record.attribute_names.include?("status") || record.status.nil?) ? "-" : record.status
      node["备注"] = remark
      node["IP地址"] = "#{request.remote_ip}|#{IPParse.parse(request.remote_ip).gsub("Unknown", "未知")}"
      record.update_columns("logs" => new_doc.to_s)
    end
  end
end

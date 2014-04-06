class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  # 开发给view层用的方法
  helper_method :current_user, :signed_in?, :redirect_back_or, :status_cn, :cando_list

  # 当前用户
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token:remember_token)
  end
 
  # 是否登录?
  def signed_in?
    !current_user.nil?
  end
  
  # 后退页面
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  # 状态汉化 ,badge 是否带颜色标签
  def status_cn(obj,badge=true)
    table_name = obj.class.to_s.tableize
    arr = Dictionary.status[table_name]
    str = arr.nil? ? "" : arr.find{|n|n[1] == obj.status}[0]
    return badge ? "<span class='label label-#{status_color(obj.status % 6)}'>#{str}</span>".html_safe : str.html_safe
    # return arr.nil? ? "" : Hash[*arr.flatten][obj.status]
  end

  protected

    # 设置后退页面
    def store_location
      session[:return_to] = request.fullpath if request.get?
    end

    # 需要登录
    def request_authenticate!
      unless signed_in?
        flash_get '请先登录!'
        redirect_to sign_in_users_path
      end
    end

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
    def send_email(email,title,content)
      # 这里是发送邮件的代码，暂缺
    end

    #  写入日志 确保表里面有logs和status字段才能用这个函数
    def write_logs(record,content,remark='',user=current_user)
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

    # 可以操作列表
    def cando_list(obj)
      arr = [] 
      arr << ['icon-zoom-in','详细', edit_kobe_article_path(obj)] 
      arr << ['icon-wrench','修改', edit_kobe_article_path(obj)]
      arr << ['icon-edit','补录', edit_kobe_article_path(obj)]
      arr << ['icon-trash','删除', edit_kobe_article_path(obj)]
      arr << ['icon-print','打印', edit_kobe_article_path(obj)] 
      arr << ['icon-check','确认', edit_kobe_article_path(obj)]
      arr << ['icon-key','权限', edit_kobe_article_path(obj)] 
      arr << ['icon-star-empty','评论', edit_kobe_article_path(obj)] 
      arr << ['icon-share','转发', edit_kobe_article_path(obj)] 
      arr << ['icon-legal','审核', edit_kobe_article_path(obj)] 
    end

  private

    # 状态对应的标签颜色
    def status_color(n)
      Dictionary.status_color[n]
    end


end

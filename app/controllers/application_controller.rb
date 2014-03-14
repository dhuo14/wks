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

  # 是否登录?
  def signed_in?
    !current_user.nil? 
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

  # 生成ztree需要的json，obj_calss
  def _ztree_json(obj_class,id,options={})
    unless id.blank?
      node = obj_class.find_by_id(id)
      if node && node.has_children? 
        node = node.children.order("ancestry,sort")
      else
        node = []
      end
    else 
      node = obj_class.order("ancestry,sort")
    end
    if node.blank?
      return render :json => "[]" 
    end
    json = node.map{|m|"{id:#{m.id}, pId:#{_get_pid(m)}, name:'#{m.id}_#{m.name}'}"}
    return render :json => "[#{json.join(", ")}]" 
  end

  # 为zTree获取父节点id，node必须为ancestry
  def _get_pid(node)
    return node.parent_id.nil? ? 0 : node.parent_id
  end

  # zTree移动节点后更新排序字段  a,b为ancestry类型
  def _update_sort(source_node,target_node,move_type)
    source_node.sort = source_node.id unless source_node.sort 
    target_node.sort = target_node.id unless target_node.sort 
    case move_type
    when "prev"
    when "inner"
    when "next"
    end
  end

  def _ztree_move_node
    return if params[:targetId].blank? || params[:sourceId].blank? || params[:moveType].blank? || params[:isCopy].blank?
    source_node = Menu.find_by_id(params[:sourceId])
    target_node = Menu.find_by_id(params[:targetId])
    if params[:moveType] == "inner" 
      reset_parent(source_node,target_node)
    else
      if source_node.parent != target_node.parent
        if target_node.root?
          
        else
          reset_parent(source_node,target_node.parent)
        end
      end
      siblings_move(source_node,target_node,params[:moveType])
    end

    result = ""

    return unless source_node && target_node
    case params[:moveType]
    when "prev"
      result = "prev" 
      if source_node.parent_id == target_node.parent_id
        source_node.sort 
        source_node.save
        result << " same_parent"
      else
        result << " deffirent_parent"
      end


    when "inner"
    when "next"
    end

    render :text => result + "targetId=#{params[:targetId]},sourceId=#{params[:sourceId]},moveType=#{params[:moveType]},isCopy=#{params[:isCopy]}"
  end

  private 

  # 同级目录内移动
  def siblings_move(source_node,target_node,move_type)
      siblings = target_node.siblings.order("sort,id")
      tmp = i = 0
      siblings.each do |s|
        i = i + 1
        if s == target_node
          if move_type == "prev"
            tmp = i
            s.sort = i + 1
          elsif move_type == "next"
            s.sort = i
            tmp = i + 1
          end
          i = i + 1  
        elsif s == source_node 
            i = i - 1  # 跳过源节点
            next
        else
          s.sort = i
        end
        s.save
      end
      source_node.sort = tmp
      source_node.save
  end
  
  # 重新指定父节点
  def reset_parent(source_node,target_node)
    source_node.parent = target_node
    source_node.sort = target_node.children.count + 1
    source_node.save
  end


end

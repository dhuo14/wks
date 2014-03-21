# -*- encoding : utf-8 -*-
class KobeController < ApplicationController

	before_filter :request_authenticate!

	def index
	end

	def test
		Setting.audit_money = {"汽车采购" => 180000, "办公小额" => 3000}
		@tmp = "
		<p>读取字典数据（静态配置信息）：#{Dictionary.company_name}</p>
		<br/>
		<p>读取设置数据（动态配置信息）：#{Setting.audit_money["汽车采购"].to_s}</p>
		<br/>
		<p>默认时间格式：#{Time.new.to_s}</p>
		<br/>
		<p>中文时间格式：#{Time.new.to_s(:cn_time)}</p>"
		@city = Area.find(1)
	end

	def ui
	end



  
  # 以下是公用方法
  protected

 


  # 生成ztree需要的json，obj_calss
  def _ztree_json(obj_class,id,options={})
    unless id.blank?
      node = obj_class.find_by(id: id)
      if node && node.has_children? 
        node = node.children
      else
        node = []
      end
    else 
      node = obj_class.all
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

  # zTree移动节点
  def _ztree_move_node(source_id,target_id,move_type,is_copy=false)
    return if source_id.blank? || target_id.blank? || move_type.blank?
    source_node = Menu.find_by(id: source_id)
    target_node = Menu.find_by(id: target_id)
    return unless source_node && target_node
    if move_type == "inner" 
      reset_parent(source_node,target_node)
    else
      if source_node.parent != target_node.parent
        if target_node.root?
          source_node.parent = nil
          siblings_move(source_node,target_node,move_type)
        else
          reset_parent(source_node,target_node.parent)
        end
      end
      siblings_move(source_node,target_node,move_type)
    end
    render :text => "targetId=#{target_id},sourceId=#{source_id},moveType=#{move_type},isCopy=#{is_copy}"
  end

  # 以下是私有方法
  private 

  # 同级目录内移动
  def siblings_move(source_node,target_node,move_type)
      siblings = target_node.siblings
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

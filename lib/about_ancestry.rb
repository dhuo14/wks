# -*- encoding : utf-8 -*-
module AboutAncestry

	def self.included(base)
    base.extend(ClassMethods)
  end

  # 拓展类方法
  module ClassMethods
	  def get_json(name)
	    if name.blank?
	      nodes = self.all
	    else
	      sql = "SELECT DISTINCT a.id,a.name,a.ancestry FROM #{self.to_s.tableize} a INNER JOIN  #{self.to_s.tableize} b ON (FIND_IN_SET(a.id,REPLACE(b.ancestry,'/',',')) > 0 OR a.id=b.id OR (LOCATE(CONCAT(b.ancestry,'/',b.id),a.ancestry)>0)) WHERE b.name LIKE ? ORDER BY a.ancestry"
	      nodes = self.find_by_sql([sql,"%#{name}%"])
	    end
	    json = nodes.map{|n|"{id:#{n.id}, pId:#{n.pid}, name:'#{n.name}'}"}
	    return "[#{json.join(", ")}]" 
	  end
  end

	# 获取父节点名称
	def parent_name
  	self.parent.nil? ? '' : self.parent.name
  end

  # 获取父节点ID ,这里是zTree的PID，与parent_id不同 ，根节点的parent_id是nil，而pid为0
  def pid
    # self.parent_id.nil? ? 0 : self.parent_id
    self.ancestry.nil? ? 0 : self.ancestry.split('/').last
  end

end
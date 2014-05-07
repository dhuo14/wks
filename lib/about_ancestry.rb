# -*- encoding : utf-8 -*-
module AboutAncestry

	# 获取父节点名称
	def parent_name
  	self.parent.nil? ? '' : self.parent.name
  end

  # 获取父节点ID ,减少数据库检索
  def parent_id
    # self.parent_id.nil? ? 0 : self.parent_id
    self.ancestry.nil? ? 0 : self.ancestry.split('/').last
  end
end
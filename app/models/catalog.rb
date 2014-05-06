# -*- encoding : utf-8 -*-
class Catalog < ActiveRecord::Base
	# 树形结构
  has_ancestry :cache_depth => true
  default_scope -> {order(:ancestry, :sort, :id)}

  def get_arr
  	return menus_ul(Menu.to_depth(0))
  end

  # 在layout中展开菜单menu
  def menus_ul(mymenus = [])
  	arr = []
    mymenus.each{|m| arr << menus_li(m) }
    return arr
  end

  def menus_li(menu)
  	arr = [menu.name]
    unless menu.has_children?
    	arr << menu.id
    else
      arr << menus_ul(menu.children)
    end
    return arr
  end

end

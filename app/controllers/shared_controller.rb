# -*- encoding : utf-8 -*-
class SharedController < JamesController
  # 下拉框选择时查询行业分类
  def department
    query_ancestry_tree(department, {:ancestry=>false})
  end

  # 下拉框选择时查询地区
  def area
    query_ancestry_tree(Area)
  end

  private




    # def query_ancestry_tree(md, option={})
    #   if option[:ancestry] == false
    #     if params[:query].present?
    #       @search = md.select('id,0 as parent_id,name').where(["name like ?", "%#{params[:query]}%"])
    #     else
    #       @search = md.select('id,0 as parent_id,name')
    #     end
    #   else
    #     if params[:query].present?
    #       tmp = md.select("CONCAT_WS(',',REPLACE(ancestry,'/',','),id) AS full_id").where(["name like ?", "%#{params[:query]}%"])
    #       tmp_id = tmp.map(&:full_id).join(",").split(",").uniq
    #       @search = md.select('id,ancestry,name').where(["id in (?)", tmp_id])
    #     else
    #       @search = md.all
    #     end
    #   end

    #   tmp = @search.map{|ca|"{id:'#{ca.id}',pId:'#{ca.parent_id}',name:'#{ca.name}', title:'xxx'}"}
    #   render :text => "[#{tmp.join(",")}]"
    # end

end

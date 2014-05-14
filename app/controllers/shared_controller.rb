# -*- encoding : utf-8 -*-
class SharedController < JamesController
  # 下拉框选择时查询行业分类
  def department
    return render :json => Department.get_json(params[:name])
  end

  # 下拉框选择时查询地区
  def area
    return render :json => Area.get_json(params[:name])
  end

  private

end

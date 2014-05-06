# -*- encoding : utf-8 -*-
class Kobe::CategorysController < KobeController

  def category_json
    tree_select_json(Category,params[:name])
  end

end
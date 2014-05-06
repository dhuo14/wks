# -*- encoding : utf-8 -*-
class Kobe::CategorysController < KobeController

  def article_category_json
    tree_select_json(Category,params[:name])
  end

  def product_category_json
    tree_select_json(Category,params[:name])
  end

end
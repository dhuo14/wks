# -*- encoding : utf-8 -*-
class Kobe::ArticlesController < KobeController

  def index
  	@article = Article.new
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    article = Article.create(my_params)
    if article
      tips_get("文章添加成功。")
      redirect_to edit_kobe_article(article)
    else
      flash_get(menu.errors.full_messages)
      render 'index'
    end
  end

  private  

    # 只允许传递过来的参数
    def my_params  
      params.require(:article).permit(:title, :new_days, :top_type, :access_permission, 'category_ids[]')  
    end
end

# -*- encoding : utf-8 -*-
class Kobe::ArticlesController < KobeController
  before_filter :get_article, :only => [ :edit, :update, :destroy ]

  def index
    unless current_user.boss?
      @article = initialize_grid(Article.includes(:author).where(:author => current_user).references(:author))
    else
      @article = initialize_grid(Article.includes(:author).references(:author))
    end
  end

  def show
  end

  def new
    @article = Article.new
    @article.build_content  # @article.categories.build
  end

  def edit
  end

  def create
    article = Article.new(my_params)
    article.author = current_user
    if article.save
      tips_get("文章添加成功。")
      redirect_to kobe_articles_path(article)
    else
      flash_get(menu.errors.full_messages)
      render 'new'
    end
  end

  def update
    if @article.update(my_params)
      tips_get("操作成功。")
      redirect_to kobe_articles_path
    else
      flash_get(@article.errors.full_messages)
      render 'edit'
    end
  end

  private  


    def get_article
      @article = Article.find(params[:id]) unless params[:id].blank?
    end

    # 只允许传递过来的参数
    def my_params  
      params.require(:article).permit(:title, :new_days, :top_type, :access_permission, :category_ids => [], content_attributes: :content)  
    end
end

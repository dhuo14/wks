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
end

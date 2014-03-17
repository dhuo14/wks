# -*- encoding : utf-8 -*-
class Kobe::MenusController < KobeController
	# layout "application"
  layout "test"  
  skip_before_filter :verify_authenticity_token, :only => :move 
  # protect_from_forgery :except => :index

	def index
		@menu = Menu.new
    @icon = Icon.leaves.map(&:name)
	end

  def new
  	@menu = Menu.new
  end

  def edit
  	@menu = Menu.find(params[:format]) unless params[:format].blank?
  end

  def create
    @menu = Menu.new(menu_params) 
    flash_notice("操作成功。") if @menu.save
    redirect_to kobe_menus_path
  end

  def update
  end

  def move
    _ztree_move_node(params[:sourceId],params[:targetId],params[:moveType],params[:isCopy])
  end

  def ztree
    _ztree_json(Menu,params[:format])
  end

  private  

  # 只允许传递过来的参数
  def menu_params  
    params.require(:menu).permit(:name, :url, :icon, :sort, :status)  
  end

end

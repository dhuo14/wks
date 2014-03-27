# -*- encoding : utf-8 -*-
class Kobe::MenusController < KobeController

  skip_before_filter :verify_authenticity_token, :only => [ :move,:destroy ]
  # protect_from_forgery :except => :index
  before_filter :get_menu, :only => [ :edit, :update, :destroy ]
  before_filter :get_icon, :only => [ :new, :index, :edit ]

  def get_menu
    @menu = Menu.find(params[:id]) unless params[:id].blank?
  end

  def get_icon
    @icon = Icon.leaves.map(&:name)
  end

	def index
		@menu = Menu.new
	end

  def new
  	@menu = Menu.new
  end

  def edit
  	if @menu
      json = { name: @menu.name, parent_id: @menu.parent_id, parent_name: ( @menu.parent.nil? ? '' : @menu.parent.name ), icon: @menu.icon, route_path: @menu.route_path, status: @menu.status, sort: @menu.sort}
      render :json => json
    else
      render :text => "操作失败！"
    end

  end

  def create
    menu = Menu.new(menu_params)
    if menu.save
      tips_get("操作成功。")
      redirect_to kobe_menus_path
    else
      flash_get(menu.errors.full_messages)
      render 'index'
    end
  end

  def update
    if @menu.update(menu_params)
      tips_get("操作成功。")
      redirect_to kobe_menus_path
    else
      flash_get(@menu.errors.full_messages)
      render 'index'
    end
  end

  def destroy
    if @menu.destroy
      render :text => "删除成功！"
    else
      render :text => "操作失败！"
    end
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
    params.require(:menu).permit(:name, :url, :icon, :sort, :status, :parent_id)  
  end

end

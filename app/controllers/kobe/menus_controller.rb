# -*- encoding : utf-8 -*-
class Kobe::MenusController < KobeController
	# layout "application"
  layout "test"  
  skip_before_filter :verify_authenticity_token, :only => :move 
  # protect_from_forgery :except => :index

	def index
		@menu = Menu.order("ancestry,sort")
	end

  def new
  	@menu = Menu.new
  end

  def edit
  	@menu = Menu.find(params[:format]) unless params[:format].blank?
  end

  def create
  end

  def update
  end

  def move
    _ztree_move_node
  end

  def ztree
    _ztree_json(Menu,params[:format])
  end

end

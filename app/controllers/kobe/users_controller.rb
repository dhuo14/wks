# -*- encoding : utf-8 -*-
class Kobe::UsersController < KobeController
  def edit
  end

  def profile
  	@user = User.find(params[:format])
  end
end

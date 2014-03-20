# -*- encoding : utf-8 -*-
class Kobe::UsersController < KobeController
  before_filter :get_user ,:only => [:profile,:update]

  def edit
  end

  def profile
  	
  end

  def update
  	if @user.update(update_params)
	    tips_get("保存成功") 
	    redirect_to profile_kobe_users_path(@user)
  	else
      flash_get(@user.errors.full_messages)
  		render 'profile'
  	end
  end

  private  

  # 修改用户时只允许传递过来的参数
  def update_params  
    params.require(:user).permit(:email, :password, :name, :gender, :identity_num)  
  end

  def get_user
  	# @user = User.find(params[:format])
    @user = current_user
  end
  
end

# -*- encoding : utf-8 -*-
class Kobe::UsersController < KobeController
  before_filter :get_user ,:only => [:profile,:update]

  def edit
  end

  def profile
  	
  end

  def update
  	if @user.update(update_params)
	    # @user.encode_password unless params[:user][:password].blank?
	    flash_notice("保存成功") 
	    redirect_to profile_kobe_users_path(@user)
	else
		flash_notice("保存成功")
		redirect_to kobe_index_path(@user)
	end
  end

  private  

  # 修改用户时只允许传递过来的参数
  def update_params  
    params.require(:user).permit(:email, :password, :name, :gender, :identity_num)  
  end

  def get_user
  	@user = User.find(params[:format])
  end
  
end

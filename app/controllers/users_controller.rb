class UsersController < ApplicationController

  def sign_in
  end

  def sign_up
  end

  def forgot_password
  end

  def create
    # params.permit!
  	@user = User.new(setup_params)
    @user.encode_password 
    flash_notice("注册成功，请完善您的个人资料。") if @user.save
    redirect_to profile_kobe_users_path(@user)
  end

  def destroy
  end

  def update
  end

  def edit
  end


  private  

  # 注册时只允许传递过来的参数
  def setup_params  
    params.require(:user).permit(:email, :password)  
  end

end

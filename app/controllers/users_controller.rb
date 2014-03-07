# -*- encoding : utf-8 -*-
class UsersController < ApplicationController

  def sign_in
    @user = User.find(params[:format]) unless params[:format].blank?
    @user ||= User.new
  end

  def sign_up
  end

  def forgot_password
  end

  def login
    unless user_params.blank?
      user = User.find_by "email = ?", user_params[:email]
      if user && user.decode_password == user_params[:password]
        session[:user_id] = user.id
        if user.name.blank?
          flash_notice("请先完善您的个人信息。")
          redirect_to profile_kobe_users_path(user)
        else
          redirect_to kobe_index_path(user)
        end
      else
        flash_notice("账号或者密码不正确，请重新输入。")
        redirect_to sign_in_users_path(@user)
      end
    end 
  end

  def create
    # params.permit!
  	@user = User.new(user_params)
    @user.encode_password 
    flash_notice("注册成功，请完善您的个人资料。") if @user.save
    _write_logs(@user,'注册',remark='账号创建成功',@user)
    _send_email(@user.email,"#{Dictionary.web_site_name}激活邮件",'恭喜您注册成，请点击下列链接激活账号。XXXXXXXXXXX')
    redirect_to sign_in_users_path(@user)
  end

  def destroy
  end

  def update
  end

  def edit
  end


  private  

  # 注册时只允许传递过来的参数
  def user_params  
    params.require(:user).permit(:email, :password)  
  end

end

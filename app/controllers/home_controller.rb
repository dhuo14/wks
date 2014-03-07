# -*- encoding : utf-8 -*-
class HomeController < JamesController
    layout false

	def index
		@user = User.find(14)
		redirect_to profile_kobe_users_path(@user)
	end

end

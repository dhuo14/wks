# -*- encoding : utf-8 -*-
class HomeController < JamesController
  layout false

	def index
		redirect_to profile_kobe_users_path(current_user)
	end

end

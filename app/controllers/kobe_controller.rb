# -*- encoding : utf-8 -*-
class KobeController < ApplicationController

	def index
	end

	def test
		Setting.audit_money = {"汽车采购" => 180000, "办公小额" => 3000}
		@tmp = "
		<p>读取字典数据（静态配置信息）：#{Dictionary.company_name}</p>
		<br/>
		<p>读取设置数据（动态配置信息）：#{Setting.audit_money["汽车采购"].to_s}</p>
		<br/>
		<p>默认时间格式：#{Time.new.to_s}</p>
		<br/>
		<p>中文时间格式：#{Time.new.to_s(:cn_time)}</p>"
		@city = Area.find(1)
	end

	def ui
	end

end

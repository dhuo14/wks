# -*- encoding : utf-8 -*-
class HomeController < JamesController
	 # layout false
	layout "kobe"

	def index
		@xml = %Q{
	      <?xml version='1.0' encoding='UTF-8'?>
	      <root>
	        <node name='标题' column='title' required='true'/>
	        <node name='文章类别' column='catalog'/>
	        <node name='置顶' column='top_type' input='true' hint='红色置顶、普通置顶或不置顶' />
	        <node name='置顶有效期' column='dateos' data_type='日期' required='true' hint='有效期过后自动取消置顶功能' />
	        <node name='关键字' disabled='true'/>
	        <node name='标签' column='keywords'/>
	        <node name='几天内显示新' column='newdays' data_type='数字' required='true'/>
	        <node name='发布人' column='user_name' data_type='字符' required='true' placeholder='发布人姓名'/>
	        <node name='内容' column='content' data_type='大文本' required='true'/>
	      </root>
	    }
	    @area = Area.new

	    # _create_xml_form(@xml,@area) 
	end

end

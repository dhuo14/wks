class BoxSelectInput < SimpleForm::Inputs::Base

	def input
		my_input_html_options = { class: 'form-control', 'data-rule-required' => options[:required], readonly: true }
		my_input_html_options["placeholder"] = options[:placeholder] if options[:placeholder]
		tag = "<div class='input-group'>".html_safe
		tag << @builder.send(:text_field, attribute_name, my_input_html_options)
		tag << "<span class='input-group-btn'><button class='btn' type='button' data-toggle='modal' href='#modal-#{input_class}'><i class='icon-building'></i></button></span>".html_safe
		tag << "</div>".html_safe

		# bootbox选择框
		box_param = options[:box_param]
		if box_param && !box_param["array"].nil?
			box_param["type"] ||= 'radio'
			box_param["grid"] ||= 4
			arr = box_param["array"]
			str = "<div class='modal fade' id='modal-#{input_class}' tabindex='-1'><div class='modal-dialog' style='width:780px;'><div class='modal-content'><div class='modal-header'><button aria-hidden='true' class='close' data-dismiss='modal' type='button'>×</button><h4 class='modal-title' id='myModalLabel'>请选择：</h4></div><div class='modal-body'><div class='box-content box-padding'><div class='row'>"
			box_param["grid"].times do |i|
				tmp = arr.length / (box_param["grid"] - i)
				pl = arr.length % (box_param["grid"] - i) == 0 ? tmp : tmp + 1
				str << "<div class='col-sm-3'><ul class='list-unstyled box-select' style='margin-bottom:0;'>"
				arr.slice!(0...pl).each do |ar|
					str << "<li>"
					case box_param["type"]
					when "icon"
          str << "<input id='box_hidden_#{input_class}' type='hidden' value='#{ar}' name='box_hidden_#{input_class}'>&nbsp; <i class='#{ar}'></i>#{ar}"
	        when "radio"
	          str << "<input id='box_radio_#{input_class}_#{ar}' type='radio' value='#{ar}' name='box_radio_#{input_class}'>&nbsp; #{ar}"
	        when "checkbox"
	          str << "<input id='box_checkbox_#{input_class}' type='checkbox' value='#{ar}' name='box_checkbox_#{input_class}'>&nbsp; #{ar}"
	        end
	        str << "</li>"
	      end
	      str << "</ul></div>"
	    end
	    str << "</div></div></div><div class='modal-footer'><button class='btn btn-default' data-dismiss='modal' type='button'>Close</button><button class='btn btn-primary' type='button'>Save changes</button></div></div></div></div>"
	    tag << str.html_safe
	  end

  	return tag.html_safe
	end

end

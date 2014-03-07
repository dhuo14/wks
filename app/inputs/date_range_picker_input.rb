class DateRangePickerInput < SimpleForm::Inputs::DateTimeInput

	def input
		my_input_html_options = { class: 'form-control daterange'}
		tag = "<div class='input-group'>".html_safe
		tag << @builder.send(:text_field, attribute_name, my_input_html_options)
		tag << "<span class='input-group-addon' id='daterange2'><i class='icon-calendar'></i></span>".html_safe
		tag << "</div>".html_safe
		return tag.html_safe
	end

end

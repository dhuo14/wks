class DateTimePickerInput < SimpleForm::Inputs::DateTimeInput

	def input
		tag = "<div class='datetimepicker-input input-group' id='datetimepicker'>".html_safe
		tag << @builder.send(:text_field, attribute_name, input_html_options)
		tag << "<span class='input-group-addon'><span data-icon-element=''></span></span>".html_safe
		tag << "</div>".html_safe
		return tag.html_safe
	end

end

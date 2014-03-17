class TimePickerInput < SimpleForm::Inputs::DateTimeInput

	def input
		my_input_html_options = { class: 'form-control', 'data-format' => 'HH:mm', 'data-rule-required' => options[:required] }
		tag = "<div class='timepicker-input input-group' id='timepicker'>".html_safe
		tag << @builder.send(:text_field, attribute_name, my_input_html_options)
		tag << "<span class='input-group-addon'><span></span></span>".html_safe
		tag << "</div>".html_safe
		return tag.html_safe
	end

end

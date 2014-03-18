class DateTimePickerInput < SimpleForm::Inputs::DateTimeInput

	def input
		my_input_html_options = { class: 'form-control', 'data-format' => 'YYYY-MM-DD HH:mm', 'data-rule-required' => options[:required] }
		my_input_html_options["placeholder"] = options[:placeholder] if options[:placeholder]
		tag = "<div class='datetimepicker-input input-group' id='datetimepicker'>".html_safe
		tag << @builder.send(:text_field, attribute_name, my_input_html_options)
		tag << "<span class='input-group-addon'><span data-icon-element=''></span></span>".html_safe
		tag << "</div>".html_safe
		return tag.html_safe
	end

end

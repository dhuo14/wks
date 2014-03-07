class DatePickerInput < SimpleForm::Inputs::DateTimeInput

	def input
		my_input_html_options = { class: 'form-control', 'data-format' => 'YYYY-MM-DD' }
		tag = "<div class='datepicker-input input-group' id='datepicker'>".html_safe
		tag << @builder.send(:text_field, attribute_name, my_input_html_options)
		tag << "<span class='input-group-addon'><span data-date-icon='icon-calendar' data-time-icon='icon-time'></span>
						</span>".html_safe
		tag << "</div>".html_safe
		return tag.html_safe
	end

end

class AutosizeTextInput < SimpleForm::Inputs::TextInput

	def input
		my_input_html_options = { class: 'form-control autosize', rows: '2' }
		return @builder.text_area(attribute_name, my_input_html_options)
	end

end

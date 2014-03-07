class MaxlengthTextInput < SimpleForm::Inputs::TextInput

	def input
		my_input_html_options = { class: 'form-control char-max-length', rows: '2', 'style' => 'margin-bottom: 0;', 
			maxlength: options[:maxlength] }
		return @builder.text_area(attribute_name, my_input_html_options)
	end

end

class AutosizeCounterTextInput < SimpleForm::Inputs::TextInput

	def input
		my_input_html_options = { class: 'form-control autosize char-counter', 'style' => 'margin-bottom:10px;', rows: '2', 
					'data-char-allowed' => options[:allow_length], 'data-char-warning' => options[:warning_length] }
		return @builder.text_area(attribute_name, my_input_html_options)
	end

end

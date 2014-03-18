class AutosizeCounterTextInput < SimpleForm::Inputs::TextInput

	def input
		my_input_html_options = { class: 'form-control autosize char-counter', 'style' => 'margin-bottom:10px;', rows: '2', 'data-char-allowed' => options[:allow_length], 'data-char-warning' => options[:warning_length], 'data-rule-maxlength' => options[:allow_length], 'data-rule-required' => options[:required] }
		my_input_html_options["placeholder"] = options[:placeholder] if options[:placeholder]
		if options[:required_type]
			options[:required_type].each do |k,v|
				my_input_html_options["data-rule-#{k}"] = v
			end
		end
		return @builder.text_area(attribute_name, my_input_html_options)
	end

end

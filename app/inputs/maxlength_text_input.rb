class MaxlengthTextInput < SimpleForm::Inputs::TextInput

	def input
		my_input_html_options = { class: 'form-control char-max-length', rows: '2', 'style' => 'margin-bottom: 0;',	maxlength: options[:maxlength], 'data-rule-required' => options[:required] }
		my_input_html_options["placeholder"] = options[:placeholder] if options[:placeholder]
		if options[:required_type]
			options[:required_type].each do |k,v|
				my_input_html_options["data-rule-#{k}"] = v
			end
		end
		return @builder.text_area(attribute_name, my_input_html_options)
	end

end

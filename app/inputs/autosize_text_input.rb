class AutosizeTextInput < SimpleForm::Inputs::TextInput

	def input
		my_input_html_options = { class: 'form-control autosize', rows: '2', 'data-rule-required' => options[:required] }
		if options[:required_type]
			options[:required_type].each do |k,v|
				my_input_html_options["data-rule-#{k}"] = v
			end
		end
		return @builder.text_area(attribute_name, my_input_html_options)
	end

end

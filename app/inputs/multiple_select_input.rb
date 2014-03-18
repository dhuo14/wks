class MultipleSelectInput < SimpleForm::Inputs::GroupedCollectionSelectInput

	def input
		label_method, value_method = detect_collection_methods
		my_input_html_options = { class: 'form-control select2', multiple: '', 'data-rule-required' => options[:required] }
		my_input_html_options["placeholder"] = options[:placeholder] if options[:placeholder]
		if options[:required_type]
			options[:required_type].each do |k,v|
				my_input_html_options["data-rule-#{k}"] = v
			end
		end
		return @builder.grouped_collection_select(
			attribute_name, grouped_collection, group_method, group_label_method, 
			value_method, label_method, input_options, my_input_html_options)
	end

end
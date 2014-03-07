class SingleSelectInput < SimpleForm::Inputs::GroupedCollectionSelectInput

	def input
		label_method, value_method = detect_collection_methods
		my_input_html_options = { class: 'select2 form-control' }
		return @builder.grouped_collection_select(
			attribute_name, grouped_collection, group_method, group_label_method, 
			value_method, label_method, input_options, my_input_html_options)
	end

end
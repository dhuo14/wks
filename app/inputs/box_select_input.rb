class BoxSelectInput < SimpleForm::Inputs::Base

	def input
		my_input_html_options = { class: 'form-control', 'data-rule-required' => options[:required] }
		tag = "<div class='input-group'>".html_safe
		tag << @builder.send(:text_field, attribute_name, my_input_html_options)
		tag << "<span class='input-group-btn'><button class='btn' type='button' data-toggle='modal' href='#modal-#{input_class}'><i class='icon-building'></i></button></span>".html_safe
		tag << "</div>".html_safe
		return tag.html_safe
	end

end

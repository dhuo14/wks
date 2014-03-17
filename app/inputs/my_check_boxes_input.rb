class MyCheckBoxesInput < SimpleForm::Inputs::CollectionCheckBoxesInput
  def input
    label_method, value_method = detect_collection_methods
    my_input_options = { 
      :item_wrapper_tag => 'label',
      :item_wrapper_class => 'checkbox-inline'
     }
    my_input_html_options = { class: nil, 'data-rule-required' => options[:required] }
    return @builder.send(
      "collection_check_boxes",
      attribute_name,
      collection,
      value_method,
      label_method,
      my_input_options,
      my_input_html_options,
      &collection_block_for_nested_boolean_style
    )
  end 

  protected

  def build_nested_boolean_style_item_tag(collection_builder)
    # tag = String.new
    # tag << collection_builder.label
    # tag << '<div class="ui radio checkbox">'.html_safe
    # tag << collection_builder.radio_button
    # tag << '</div>'.html_safe
    collection_builder.check_box + collection_builder.text
    # return tag.html_safe
  end 

end
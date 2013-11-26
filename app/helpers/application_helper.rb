# -*- encoding : utf-8 -*-
module ApplicationHelper

  # 下拉选择框
  def drop_select(to_id, rs,  url, options = {})
    options.merge!({:class => 'drop_select', :readonly => "readonly", :dropdata => url})
    options[:droplimit] ||= "0"
    options[:droptree] ||= "true"
    input_id = to_id.gsub('[', "_").gsub(']', '_')
    if rs.blank?
      name_value = id_value = ""
    elsif rs.class == Array
      name_value = rs.map(&:name).join(",")
      id_value = rs.map(&:id).join(",")
    else
      name_value = rs.name
      id_value = rs.id
    end
    (text_field_tag("art_#{to_id}", name_value, options.merge({:id => "art_#{input_id}"})) + hidden_field_tag(to_id, id_value, :droptree_id => "art_#{input_id}" )).html_safe
  end
  
end

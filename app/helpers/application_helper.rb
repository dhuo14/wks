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


  # 生成XML表单函数
  # /*options参数说明
  #   form_id 表单ID
  #   button_id 按钮ID,与自定义的validate_js配合使用
  #   validate_js 表单自定义验证JS
  #   action 提交的路径
  #   title  表单标题
  #   grid 每一行显示几个输入框
  #   only_show 在shouw/audit等只需要显示内容的页面设为true，则自动去除form,input,button等标签 
  # */
  def _create_xml_form(xml,obj,options={})
    form_id = options.has_key?("form_id") ? options["form_id"] : "myform" 
    button_id = options.has_key?("button_id") ? options["button_id"] : "mybutton"
    action = options.has_key?("action") ? options["action"] : "" 
    title = options.has_key?("title") ? options["title"] : "" 
    grid = options.has_key?("grid") ? options["grid"] : 2  # 每一行显示几个输入框
    only_show = options.has_key?("only_show") ? options["only_show"] : false # 在shouw/audit等页面设为true，则input变为pre 
    str = "<div class='row'><div class='col-sm-12'><div class='box'><div class='box-header'><div class='title'>#{title}</div><div class='actions'><a class='btn box-collapse btn-xs btn-link' href=''><i></i></a></div></div><div class='box-content'>"
    str << "<form class='form form-horizontal validate-form' id='#{form_id}' action='#{action}' style='margin-bottom: 0;'>" unless only_show
    doc = Nokogiri::XML(xml)
    doc.xpath('//node').each_slice(grid) do |node|
      str << "<div class='row'>"
      node.each{|n|str << _create_text_field(obj.class.to_s,"hell0",n.attributes,only_show,grid)}
      str << "</div>"
    end
    str << "<div class='form-actions' style='margin-bottom:0'><div class='row'><div class='col-sm-9 col-sm-offset-3'><button id='#{button_id}'class='btn btn-primary' type='submit'><i class='icon-save'></i> 保 存 </button></div></div></div></form>" unless only_show     
    str << "</div></div></div></div>"
    str << options["validate_js"] if options.has_key?("validate_js") 
    return raw str.html_safe
  end
  
  # 生成输入框函数
  # /*options参数说明
  #   name  标签名称
  #   column 字段名称，有column时数据会存入相应的字段，没有时会以XML的形式存入detail字段中
  #   data_type 数据类型，字符、数字、日期、时间、日期时间、IP、URL、EMAIL等。配合验证JS使用
  #   minlength 允许输入最少的字符数
  #   maxlngth 允许输入最多的字符数，默认是127
  #   hint 提示信息，点击?会弹出提示框，一般比较复杂的事项、流程提醒等
  #   placeholder 输入框内提示信息
  #   required 是否必填，为true 会有小红星*
  #   disabled 是否不可操作
  #   readonly 是否只读
  # # */
  def _create_text_field(obj_class, value, options={}, only_show=false,grid=2)
    return "" unless options.has_key?("name")
    name = options["name"]  
    column = options.has_key?("column") ? options["column"] : name 
    data_type = options.has_key?("data_type") ? options["data_type"].to_s : "字符"
    options["maxlength"] = '127' unless options.has_key?("maxlength")
    hint = options.has_key?("hint") ? "<span class='icon-question-sign has-popover' data-title='提示' data-placement='right' data-content='#{options["hint"]}'></span>" : ""
    opt = []
    input_str = ""
    case data_type
    when "大文本"
      input_str = "<textarea class='autosize form-control' id='#{obj_class}_#{column}' name='#{obj_class}[#{column}]' placeholder='#{options["placeholder"]}' rows='2'>#{value}</textarea>"
    when "富文本"
      input_str = "<textarea class='autosize form-control' id='#{obj_class}_#{column}' name='#{obj_class}[#{column}]' placeholder='#{options["placeholder"]}' rows='2'>#{value}</textarea>"
    when "数字"
      opt <<  "data-rule-digits='true'"
    when "日期"
      opt <<  "data-rule-dateiso='true'"
    when "IP"
      opt <<  "data-rule-ipv4='true'"
    when "email"
      opt <<  "data-rule-email='true'"
    when "URL"
      opt <<  "data-rule-url='true'"
    end

    opt << "disabled='disabled'" if options.has_key?("disabled") && options["disabled"].to_s == "true"
    opt << "readonly='readonly'" if options.has_key?("readonly") && options["readonly"].to_s == "true"
    opt << "placeholder='#{options["placeholder"]}'" if options.has_key?("placeholder")
    opt << "data-rule-minlength='#{options["minlength"]}'" if options.has_key?("minlength")
    opt << "data-rule-maxlength='#{options["maxlength"]}'" if options.has_key?("maxlength")
    if options.has_key?("required") && options["required"].to_s == 'true'
      opt << "data-rule-required='true'"
      red_start = "<span class='text-red'>*</span>" 
    else
      red_start = ""
    end
    input_str = only_show ? "<pre>#{value}</pre>" : "<input type='text' class='form-control' id='#{obj_class}_#{column}' name='#{obj_class}[#{column}]' value='#{value}' #{opt.join(" ")}>"
    str = "<div class='form-group col-md-#{12/grid}'><div class='control-label col-sm-4'><label for='#{column}'>#{red_start} #{name} #{hint}</label></div><div class='col-sm-8 controls'>#{input_str}</div></div>"
    # return raw str.html_safe
  end

end

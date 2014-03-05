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

  # 获取某实例的字段值
  def _get_column_value(obj,node,details_column='details')
    if node.attributes.has_key?("column") && obj.class.attribute_method?(node["column"])
      return obj[node["column"]]
    else
      if obj.class.attribute_method?(details_column) && obj[details_column]
        doc = Nokogiri::XML(obj[details_column])
        tmp = doc.xpath("/root/node[@name='#{node["name"]}']").first
        return tmp.blank? ? "" : tmp["value"]
      else
        return ""
      end
    end
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
    table_name = obj.class.table_name
    form_id = options.has_key?("form_id") ? options["form_id"] : "myform" 
    button_id = options.has_key?("button_id") ? options["button_id"] : "mybutton"
    action = options.has_key?("action") ? options["action"] : "" 
    title = options.has_key?("title") ? options["title"] : "" 
    grid = options.has_key?("grid") ? options["grid"] : 1 
    only_show = options.has_key?("only_show") ? options["only_show"] : false 
    str = "<div class='row'><div class='col-sm-12'><div class='box'><div class='box-header'><div class='title'>#{title}</div><div class='actions'><a class='btn box-collapse btn-xs btn-link' href=''><i></i></a></div></div><div class='box-content'>"
    str << "<form class='form form-horizontal validate-form' id='#{form_id}' action='#{action}' style='margin-bottom: 0;'>" unless only_show
    doc = Nokogiri::XML(xml)
    # 先生成输入框--针对没有data_type属性或者data_type属性不包括'大文本'、'富文本'的
    doc.xpath("/root/node[not(@data_type)] | /root/node[@data_type!='大文本'][@data_type!='富文本']").each_slice(grid) do |node|
      str << "<div class='row'>"
      node.each{|n|str << _create_text_field(table_name,_get_column_value(obj,n),n.attributes,only_show,grid)}
      str << "</div>"
    end
    # 再生产文本框和富文本框--针对大文本或者富文本
    doc.xpath("/root/node[contains(@data_type,'文本')]").each_slice(1) do |node|
      str << "<div class='row'>"
      node.each{|n|str << _create_text_field(table_name,_get_column_value(obj,n),n.attributes,only_show,1,grid)}
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
  #   data_type 数据类型，字符、数字、日期、时间、日期时间、IP、URL、EMAIL、布尔、普通单选、普通多选、树形单选、树形多选等。配合验证JS使用
  #   minlength 允许输入最少的字符数
  #   maxlngth 允许输入最多的字符数，默认是127
  #   hint 提示信息，点击?会弹出提示框，一般比较复杂的事项、流程提醒等
  #   placeholder 输入框内提示信息
  #   required 是否必填，为true 会有小红星*
  #   display 显示方式 disabled 不可操作 readonly 是否只读 skip 跳过不出现 hidden 隐藏
  #   text_grid 本参数仅仅针对大文本和富文本类型有效，目的是对齐原来字符类型的文本框
  #   
  # # */
  def _create_text_field(table_name, value, options={}, only_show=false,grid=1,text_grid=1)
    # 没有name和display=skip的直接跳过
    return "" unless options.has_key?("name") && !(options.has_key?("display") && options["display"].to_s == "skip")
    name = options["name"]  
    column = options.has_key?("column") ? options["column"] : name 
    if only_show 
      input_str = "<pre>#{value}</pre>"  # 仅仅显示的话不生成输入框
    else 
      input_str = ""
      # 隐藏标签，一般是通过JS来赋值
      if options.has_key?("display") && options["display"].to_s == "hidden"
        return "<input type='hidden' id='#{table_name}_#{column}' name='#{table_name}[#{column}]' value='#{value}' />"
      end
      # 没有标注数据类型的默认为字符
      data_type = options.has_key?("data_type") ? options["data_type"].to_s : "字符"
      unless options.has_key?("maxlength")
        options["maxlength"] = ["大文本","富文本"].include?(data_type) ? '8000' : '127' 
      end
      hint = options.has_key?("hint") ? "<span class='icon-question-sign has-popover' data-title='提示' data-placement='right' data-content='#{options["hint"]}'></span>" : ""
      opt = []
      opt << "disabled='disabled'" if options.has_key?("display") && options["display"].to_s == "disabled"
      opt << "readonly='readonly'" if options.has_key?("display") && options["display"].to_s == "readonly"
      opt << "placeholder='#{options["placeholder"]}'" if options.has_key?("placeholder")
      opt << "data-rule-minlength='#{options["minlength"]}'" if options.has_key?("minlength")
      opt << "data-rule-maxlength='#{options["maxlength"]}'" if options.has_key?("maxlength")
      if options.has_key?("required") && options["required"].to_s == 'true'
        opt << "data-rule-required='true'"
        red_start = "<span class='text-red'>*</span>" 
      else
        red_start = ""
      end
      case data_type
      when "大文本"
        input_str = "<textarea class='autosize form-control' id='#{table_name}_#{column}' name='#{table_name}[#{column}]' rows='2' #{opt.join(" ")}>#{value}</textarea>"
      when "富文本"
        input_str = "<textarea class='autosize form-control' rows='4'>#{value}</textarea>"
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
      input_str = "<input type='text' class='form-control' id='#{table_name}_#{column}' name='#{table_name}[#{column}]' value='#{value}' #{opt.join(" ")}>" if input_str.blank?
    end
    grid_col = ["大文本","富文本"].include?(data_type) ? 4/text_grid : 4
    str = "<div class='form-group col-md-#{12/grid}'><div class='control-label col-sm-#{grid_col}'><label for='#{column}'>#{red_start} #{name} #{hint}</label></div><div class='col-sm-#{12-grid_col} controls'>#{input_str}</div></div>"
  end

end

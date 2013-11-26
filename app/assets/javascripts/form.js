//= require jquery.validationEngine
//= require jquery.validationEngine-zh_CN
//= require My97DatePicker/WdatePicker
//= require drop_select

$(function() {
  // 判断空 $.isBlank($(this).val())
  $.isBlank = function(obj) {
    return(!obj || $.trim(obj) === "");
  };

  // 日期时间控件
  $('.my97_time').click(function() {
    WdatePicker({dateFmt:'yyyyMMdd'});
  });

  $('.my97_full_time').click(function() {
    WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});
  });

  // 下拉选择框
  $(".drop_select").on("click", function() {
    drop_select(this, $(this));
  });
})
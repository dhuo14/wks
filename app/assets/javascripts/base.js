//= require jquery
//= require jquery_ujs

/*替换全部字符*/
String.prototype.replaceAll = function(reallyDo, replaceWith, ignoreCase) {
  if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
    return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
  } else {
    return this.replace(reallyDo, replaceWith);
  }
};

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
  $(".drop_select").live("click", function() {
    drop_select(this, $(this));
  });
})

// 自动适应高度textarea
function textarea_auto_height(textarea){
  textarea.style.height = "1px";
  textarea.style.height = (25+textarea.scrollHeight)+"px";
};
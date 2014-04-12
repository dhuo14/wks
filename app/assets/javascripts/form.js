// 删除确认框
function doDelete(){
  // 默认参数写法
  var formId = arguments[0] ? arguments[0] : "batchFrom";
  if($("input[type='checkbox'][name='grid[]']:checked").length == 0){
    bootbox.alert("请至少选择一条记录！");
  }else{
    bootbox.confirm("删除后不可恢复，您确定要删除吗？", function(result){
      if (result)
        $("#"+formId).submit();
    }); 
  }
}
// 搜索表单提交
function searchFormDone(){
  $("#keywords").val($("#keys").val());
  $("#searchForm").submit();
}

$(function() {

  
	// 全选
	$("#selectAll").click(function(){
    if(this.checked){
        $("input[type='checkbox'][name='grid[]']").each(function(){this.checked=true;});
    }else{
        $("input[type='checkbox'][name='grid[]']").each(function(){this.checked=false;});
    }
	});

  // 高级搜索  
   $("#accurate-search").click(function(){
      $("#search_panel").slideToggle("fast");
      $(this).children("i").toggleClass("icon-caret-down"); 
      $(this).children("i").toggleClass("icon-caret-up"); 
    });

  // bootbox选择器--点击后的选择事件
  $("ul.box-select li").on("click",function(){
    var ipt = $(this).children("input");
    var id = $(this).parents(".modal").first().attr("id").replace("modal-",""); 
    if(ipt.attr("type") == "radio" || ipt.attr("type") == "hidden"){
      $("#"+id).val(ipt.val());
      $(this).parents(".modal").modal('hide');
    } 
    else{
      var arr = new Array();
      $("input[name='" + ipt.attr("name") + "']:checked").each(function(){
        arr.push($(this).val());
      })
      $("#"+id).val(arr.join(','));
    }
  });



  $.validator.addMethod("buga", (function(value) {
    return value === "buga";
  }), "Please enter \"buga\"!");
  
  $.validator.methods.equal = function(value, element, param) {
    return value === param;
  };




  $("input.nakedpassword").nakedPassword({
    path: "assets/images/plugins/naked_password/"
  });
  
  var select2icon;
  select2icon = function(e) {
    return "<i class='" + e.text + "'></i> ." + e.text;
  };
  $("#select2-icon").select2({
    formatResult: select2icon,
    formatSelection: select2icon,
    escapeMarkup: function(e) {
      return e;
    }
  });
  $("#select2-tags").select2({
    tags: ["today", "tomorrow", "toyota"],
    tokenSeparators: [",", " "],
    placeholder: "Type your tag here... "
  });
  
  $("#daterange2").daterangepicker({
    format: "YYYY-MM-DD"
  }, function(start, end) {
    return $("#daterange2").parent().find("input").first().val(start.format("YYYY-MM-DD") + " 至 " + end.format("YYYY-MM-DD"));
  });
  
  $(".mention").mention({
    users: [
      {
        name: "Lindsay Made",
        username: "LindsayM",
        image: "http://placekitten.com/25/25"
      }, {
        name: "Rob Dyrdek",
        username: "robdyrdek",
        image: "http://placekitten.com/25/24"
      }, {
        name: "Rick Bahner",
        username: "RickyBahner",
        image: "http://placekitten.com/25/23"
      }, {
        name: "Jacob Kelley",
        username: "jakiestfu",
        image: "http://placekitten.com/25/22"
      }, {
        name: "John Doe",
        username: "HackMurphy",
        image: "http://placekitten.com/25/21"
      }, {
        name: "Charlie Edmiston",
        username: "charlie",
        image: "http://placekitten.com/25/20"
      }, {
        name: "Andrea Montoya",
        username: "andream",
        image: "http://placekitten.com/24/20"
      }, {
        name: "Jenna Talbert",
        username: "calisunshine",
        image: "http://placekitten.com/23/20"
      }, {
        name: "Street League",
        username: "streetleague",
        image: "http://placekitten.com/22/20"
      }, {
        name: "Loud Mouth Burrito",
        username: "Loudmouthfoods",
        image: "http://placekitten.com/21/20"
      }
    ]
  });




  /*
  // 判断空 $.isBlank($(this).val())
  $.isBlank = function(obj) {
    return(!obj || $.trim(obj) === "");
  };

  // 下拉选择框
  $(".drop_select").on("click", function() {
    drop_select(this, $(this));
  });

  // 日期时间控件
  $('.my97_time').click(function() {
    WdatePicker({dateFmt:'yyyyMMdd'});
  });

  $('.my97_full_time').click(function() {
    WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});
  });
*/

})
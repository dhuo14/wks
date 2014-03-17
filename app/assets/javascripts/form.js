//= require plugins/fileinput/bootstrap-fileinput
//= require plugins/select2/select2
//= require plugins/bootstrap_colorpicker/bootstrap-colorpicker.min
//= require plugins/bootstrap_daterangepicker/bootstrap-daterangepicker
//= require plugins/bootstrap_datetimepicker/bootstrap-datetimepicker
//= require plugins/input_mask/bootstrap-inputmask.min
//= require plugins/bootstrap_maxlength/bootstrap-maxlength.min
//= require plugins/charCount/charCount
//= require plugins/autosize/jquery.autosize-min
//= require plugins/bootstrap_switch/bootstrapSwitch.min
//= require plugins/naked_password/naked_password-0.2.4.min
//= require plugins/mention/mention.min
//= require plugins/typeahead/typeahead
//= require plugins/common/moment.min
//= require plugins/common/wysihtml5.min
//= require plugins/common/bootstrap-wysihtml5
//= require plugins/pwstrength/pwstrength
//= require plugins/validate/jquery.validate.min
//= require plugins/validate/additional-methods


$(function() {

// $("#get_value").on("click",function(){
//       var a1 = $("#get_01").val();
//       var a2 = $("#get_02").val();
//       var a3 = $("#get_02").attr("checked") == true ? "1" : "0";
//       var a4="";  
//       $("[name='get_031']:checked").each(function(){  
//         a4+=$(this).val()+",";   
//       })  


//       alert(a1+ "__________"+a2+ "#############"+a4);
//     });
//   });



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
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

// tree_select 相关函数begin

function tree_select(id,obj_class,checked_max,keyword){
  $.fn.zTree.init($('#ztree_' + id), ztree_setting(obj_class, checked_max, keyword));
  $('#ok_' + id).on('click',function(){
    ztree_ok_click(id,checked_max);
  });

  // 树形选择器点击确定按钮
  function ztree_ok_click(id,checked_max){
    var treeObj = $.fn.zTree.getZTreeObj('ztree_' + id);
    var nodes = treeObj.getCheckedNodes(true);
    var node_id = [];
    var node_name = [];
    var check_count = 0;
    var too_much = false;

    $.each(nodes, function(n, node) {
      if (!node.isParent) {
        check_count += 1;
        if (check_count > checked_max && checked_max > 0) {
          too_much = true;
        }
        else {
          node_id.push(node.id);
          node_name.push(node.name);
        }
      }
      if (too_much == true) {
        $('#tips_' + id).html("最多只能选" + checked_max + "项");
        treeObj.checkNode(node, false, false);
      }
    });
    $('#box_' + id).val(node_name.join(","));
    $('#' + id).val(node_id.join(","));
    $('#cancel_' + id).click();
  } 

  function ztree_setting(obj_class,checked_max,keyword) {
    var check_type = checked_max == 1 ? "radio" : "checkbox";
    var setting = {
        check: {
          enable: true,
          chkStyle: check_type,
          autoCheckTrigger: true,
          chkboxType: { "Y": "ps", "N": "ps" },
          radioType: "all"
        },
        data: {
          simpleData: {
              enable: true
          }
        },
        async: {
          type:'get',
          async:false,
          enable: true,
          url:'/kobe/obj_class_json',
          autoParam:["id", "name=n", "level=lv"],
          otherParam:{'obj_class' : obj_class, 'name' : keyword}
        },
        callback: {
          // onAsyncSuccess: zTreeOnAsyncSuccess,
          // onCollapse: zTreeOnExpand,
          // onExpand: zTreeOnExpand,
          // onCheck: zTreeOnCheck,
          // onClick: zTreeOnClick
        }
    };
    return setting;
  }

  // 输入关键字后搜索
  function query_data() {
    var keyword = $("#" + id + "_keyword").val();
    // $.fn.zTree.destroy();
    $.fn.zTree.init($('#ztree_' + id), ztree_setting(obj_class, checked_max, keyword));
  }
  // 树加载完成绑定函数
  function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
    var checked_id = "" ;
    var treeObj = $.fn.zTree.getZTreeObj(treeId);
    var nodes = treeObj.transformToArray(treeObj.getNodes());
    if ($("input[type='hidden'][droptree_id='" + this_dom.attr("id") + "']").length > 0) {
      checked_id = $("input[type='hidden'][droptree_id='" + this_dom.attr("id") + "']").val();
    }
    var array_id = checked_id.split(",");
    if (query == true) {
       treeObj.expandAll(true);   // 查询时展开全部节点
    }
    for (var i = 0; i < nodes.length; i++) {
      //            if (nodes[i].level < 1) {        // 展开两层
      //                treeObj.expandNode(nodes[i], true, false, true);
      //            }
      if (nodes[i].isParent && checked_max == 1) {     // 如果是单选不允许选择父节点
          nodes[i].nocheck = true;
          treeObj.updateNode(nodes[i]);
      }
      if ($.inArray(nodes[i].id, array_id) >= 0) {  // 勾上默认值
          treeObj.checkNode(nodes[i], true, true);
      }
    }
  }

  // 节点展开绑定函数
  function zTreeOnExpand(event, treeId, treeNode) {
    overflow_y(tree_div_content);
  }

  function zTreeOnCheck(event, treeId, treeNode) {
    after_check(treeId);
    if (checked_max == 1 && treeNode.checked) {
      var dialog = art.dialog.get('float_' + this_dom.attr("id"));
      dialog.hide();
      this_dom.focus();
    }
  }

  // 点击选择框绑定函数
  function zTreeOnClick(event, treeId, treeNode) {
    drop_checkall(this_dom, false);
    this_dom.val(treeNode.name);
    $("input[type='hidden'][droptree_id='" + this_dom.attr("id") + "']").val(treeNode.id);
    dialog.hide();
    this_dom.focus();
  }
}
// tree_select 相关函数end



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

  // 树形选择
  $(".tree_select").each(function(){
    var id = $(this).attr("id");
    var obj_class = $(this).attr("obj_class");
    var checked_max = $(this).attr("checked_max");
    var keyword = $(this).attr("keyword");
    tree_select(id,obj_class,checked_max,keyword);
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
//将字符串转换成对象，避免使用eval
function parseObj(strData) {
   return (new Function("return " + strData))();
}
// 超高时出现滚动条
function overflow_y(tree_div) {
  if ($('#' + tree_div).height() > 460) {
      $('#' + tree_div).width($('#' + tree_div).width() + 20);
      $('#' + tree_div).addClass("drop_ul_overflow_y");
  }
}
//弹框里面点击搜索
function drop_query(id) {
    var this_dom = $("#" + id);
    var this_input = this_dom[0];
    drop_select(this_input, this_dom, true);
    return false;
}
//点击弹框里面的“全选”和“清除按钮”
function drop_checkall(this_dom, ischeck) {
    this_dom.val('');
    //    var this_input = this_dom[0];
    $("#" + this_dom.attr("id") + "_id").val('');
    var treeObj = $.fn.zTree.getZTreeObj("drop_select_tree_" + this_dom.attr("id") + "_content");
    treeObj.checkAllNodes(ischeck);
}
//主函数
function drop_select(this_input, this_dom, query) {
    if (query == undefined) {
        query = false
    }
    var dropdata = this_dom.attr("dropdata") == undefined ? "" : this_dom.attr("dropdata");
    var droplimit = this_dom.attr("droplimit") == undefined ? 0 : this_dom.attr("droplimit");
    var droptree = this_dom.attr("droptree") == undefined ? 'false' : this_dom.attr("droptree");
    var dialog_title = droplimit > 0 ? "请选择[最多" + droplimit + "项]" : "请选择";
    var dropwidth = this_dom.attr("dropwidth") == undefined ? "145px" : this_dom.attr("dropwidth");
    var dialog_width = this_dom.width() + 145;
    var dialog = art.dialog.get('float_' + this_dom.attr("id"));
    var tree_div = "drop_select_tree_" + this_dom.attr("id");
    var tree_div_title = tree_div + "_title";
    var tree_div_content = tree_div + "_content";

    //关闭所有下拉选择窗口

    var list = art.dialog.list;
    for (var i in list) {
        if (list[i] != dialog) {
            list[i].close();
        }

    }

    if (query == true) {
        query_data();
    }
    else {
        if (dialog == undefined) {
            var btn = [
                {
                    name: '确定',
                    focus: true,
                    callback: function() {
                        this.hide();
                        this_dom.focus();
                        return false;
                    }
                }
            ];
            if (droplimit != 1) {
                btn = btn.concat({name: '全部选中',callback: function() {
                    drop_checkall(this_dom, true);
                    return false;
                }}, {name: '清除已选',callback: function() {
                    drop_checkall(this_dom, false);
                    return false;
                }});
            }
            var dialog = art.dialog({
                id: 'float_' + this_dom.attr("id"),
                title: dialog_title,
                width: dialog_width,
                button: btn
            });
            //     加载内容开始
            if ($("#" + tree_div).length == 0) {
                $("#drop_select_tree").append("<div id=\"" + tree_div + "\" class=\"float_content drop_ul_overflow\"></div>");
                $("#" + tree_div).append('<div id="' + tree_div_title + '"><div id="' + tree_div_title + '_tips" class="red"></div><form onSubmit="drop_query(\'' + this_dom.attr('id') + '\');return false;"><input id="drop_query_param" size="6" class="string optional"/>&nbsp;<input class="btn btn-info btn-small" type="submit" value="查 询" /></form></div>');
                $("#" + tree_div_title).append("<ul id=\"" + tree_div_content + "\"></ul>");
            }

            //加载树开始
            $("#" + tree_div_content).addClass("ztree");
            var setting = ztree_setting(droplimit);
            $.fn.zTree.init($("#" + tree_div_content), setting);
            //加载树结束

            dialog.content(document.getElementById(tree_div));
            //超宽或者超高的加入滚动条
            overflow_y(tree_div_content);
        }
        else {
            dialog.show();
        }
        dialog.follow(this_input);
    }

    function filter(treeId, parentNode, childNodes) {
        if (!childNodes) return null;
        for (var i = 0, l = childNodes.length; i < l; i++) {
            childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
        }
        return childNodes;
    }

    function zTreeOnExpand(event, treeId, treeNode) {
        overflow_y(tree_div_content);
    }

    function zTreeOnCheck(event, treeId, treeNode) {
        after_check(treeId);
        if (droplimit == 1 && treeNode.checked) {
            var dialog = art.dialog.get('float_' + this_dom.attr("id"));
            dialog.hide();
            this_dom.focus();
        }
    }

    function zTreeOnClick(event, treeId, treeNode) {
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        if (treeNode.isParent) {
              treeObj.expandNode(treeNode, true, false, true);
              return false;
         }
        drop_checkall(this_dom, false);
        this_dom.val(treeNode.name);
        $("input[type='hidden'][droptree_id='" + this_dom.attr("id") + "']").val(treeNode.id);
        dialog.hide();
        this_dom.focus();
    }

    function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
        var checked_id = "";
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
            if (nodes[i].isParent && droplimit == 1) {     // 如果是单选不允许选择父节点
                nodes[i].nocheck = true;
                treeObj.updateNode(nodes[i]);
            }
            if ($.inArray(nodes[i].id, array_id) >= 0) {  // 勾上默认值
                treeObj.checkNode(nodes[i], true, true);
            }
        }
    }

    function after_check(treeId) {
        var tip_div = $("#" + tree_div_title + "_tips");
        //        tip_div.html('');
        var treeObj = $.fn.zTree.getZTreeObj(treeId);
        var nodes = treeObj.getCheckedNodes(true);
        var node_id = [];
        var node_name = [];
        var check_count = 0;
        var too_much = false;

        $.each(nodes, function(n, node) {
            if (!node.isParent) {
                check_count += 1;
                if (check_count > droplimit && droplimit > 0) {
                    too_much = true;
                }
                else {
                    node_id.push(node.id);
                    node_name.push(node.name);
                }
            }
            if (too_much == true) {
                tip_div.html("最多只能选" + droplimit + "项");
                treeObj.checkNode(node, false, false);
            }
        });

        this_dom.val(node_name.join(","));
        $("input[type='hidden'][droptree_id='" + this_dom.attr("id") + "']").val(node_id.join(",")); 
    }

    //默认勾上已选项
    var vv = this_dom.val() == "" ? this_dom.attr("value") : this_dom.val();
    var dom_value = vv.split(",");
    $("#opts_float_" + this_dom.attr("id") + " input[type='checkbox'][name='drop_option[]']").each(function() {
        if ($.inArray($(this).val(), dom_value) >= 0) {
            $(this).attr("checked", 'true');
        }
    })

    // 输入关键字后搜索
    function query_data() {
        var queryparam = $("#drop_query_param").val();
        var setting = ztree_setting(droplimit, queryparam);
        $.fn.zTree.destroy();
        $.fn.zTree.init($("#" + tree_div_content), setting);
    }

    function ztree_setting(droplimit, queryparam) {
        var check_type = droplimit == 1 ? "radio" : "checkbox";
        var otherparam = (queryparam == undefined) ? {} : {'query' : queryparam};
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
                url:dropdata,
                autoParam:["id", "name=n", "level=lv"],
                otherParam:otherparam,
                dataFilter: filter
            },
            callback: {
                onAsyncSuccess: zTreeOnAsyncSuccess,
                onCollapse: zTreeOnExpand,
                onExpand: zTreeOnExpand,
                onCheck: zTreeOnCheck,
                onClick: zTreeOnClick
            }
        };
        return setting;
    }
}

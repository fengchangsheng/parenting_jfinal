<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>菜单列表</title>
<script type="text/javascript">
$(function () {
	listTree();
});

function listTree(){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/treeMenu/listAllTreeJSON",
		dataType:"json",
		data: {nodeGrade:"0",parentNode:"0"},
		async: false,
	    error: function(request) {
	        alert("菜单加载失败,请刷新页面!");
	    },
	    success: function(res) {
	    	treeJSON = res.data;
	    }
	});
    $('#mytree').tree({
        data: eval(treeJSON),
        onClick: function (node) {
            if(!node.url){
            	$('#mytree').tree('expandAll', node.target);
            }
        }
    });
    $("#mytree").bind('contextmenu',function(e){
		e.preventDefault();
		$('#menu').menu('show', {
			left: e.pageX,
			top: e.pageY
		});
	});
    $('#mytree').tree('expandAll');
}

function doAdd(){
	var node = $("#mytree").tree("getSelected");
	if(!node){
		showMsg("请先选择一条记录");
		return;
	}
	var num = Math.random()*100;
   	var url="${basePath}/treeMenu/toAdd/"+node.id+"-"+parseInt(num);
   	$("#showDIV").load(url,function(){
   		$.parser.parse("showDIV");
   	}); 
}

function doEdit(){
	var node = $("#mytree").tree("getSelected");
	if(!node){
		showMsg("请先选择一条记录");
		return;
	}
	var num = Math.random()*100;
   	var url="${basePath}/treeMenu/toEdit/"+node.id+"-"+parseInt(num);
   	$("#showDIV").load(url,function(){
   		$.parser.parse("showDIV");
   	}); 
}

function doDel(){
	var node = $("#mytree").tree("getSelected");
	if(!node){
		showMsg("请先选择一条记录");
		return;
	}
	$.messager.confirm('确认', "确定要删除选中的菜单?此操作不可撤销，请谨慎操作。", function (r) {
	     if (r) {
	    	 var num = Math.random()*100;
	    	 var url="${basePath}/treeMenu/delete/"+node.id+"-"+parseInt(num);
	    		$.ajax({
	    			cache: true,
	    			type: "POST",
	    			url:url,
	    			async: false,
	    		    error: function(request) {
	    		    	alert("系统错误,请刷新后重试");
	    		    },
	    		    success: function(data) {
	    		    	showMsgParent(data.msg);
	    		    	listTree();
	    		    }
	    		});
	     }
	 });
}
</script>
</head>
<body style="padding:0;"> 
<div id="menu" class="easyui-menu" style="width:150px;">
    <div id="m-refresh" onclick="doAdd()">新增</div>
    <div class="menu-sep"></div>
    <div id="m-refresh" onclick="doEdit()">修改</div>
    <div class="menu-sep"></div>
    <div id="m-closeall" onclick="doDel()">删除</div>
</div>
<div id="mainPanel" class="easyui-panel" style="padding:30 50 10 50;" border=false > 
	<table width="90%" height="100%">
		<tr>
			<td width="170px" height="100%" valign="top">  
				<div style="height:500px;overflow-y:auto" >
					<ul id="mytree" class="easyui-tree" data-options="animate:true" style="width:200px;"></ul>
				</div>
			</td>
			<td valign="top"> 
				<div id="showDIV" style="border:1px solid #ccc;height:450px;width:100%;margin-top:20px;margin-left:20px;padding:15px;"></div>
			</td>
		</tr>
	</table>
</div>
</body>
</html>
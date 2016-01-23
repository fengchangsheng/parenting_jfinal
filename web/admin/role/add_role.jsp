<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增角色</title>
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


function doSub(){
	getChecked();
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/role/add",
		data:$('#roleAdd').serialize(),
		async: false,
	    error: function(request) {
	    	//alert("系统错误,请刷新后重试");
	    	showMsgParent(request.msg);
	    },
	    success: function(data) {
	    	showMsgParent(data.msg);
	    	window.parent.$('#openWin').window('close');
	    	window.parent.$('#dataTable').datagrid('reload');
	    }
	});
	
}


function getChecked(){
		var nodes = $('#mytree').tree('getChecked', ['checked','indeterminate']);
		//var nodes = $('#mytree').tree('getChecked');
		var s = '';
		for(var i=0; i<nodes.length; i++){
			if (s != '') s += ',';
			s += nodes[i].id;
		}
		$("#right").val(s);
}
</script>
</head>
<body>
	<form id="roleAdd" action="" method="post">
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="角色信息" style="padding:30px;height:400px;" fit=true>
			<table width="90%">
				<tr>
					<td height="45px" width="150px">角色名:</td>
					<td><input name="role.f_name" id="roleName" data-options="required:true"/></td>
				</tr>
				<tr>
					<td>角色描述:</td>
					<td><textarea name="role.f_des" id="roleDes" rows="5" style="width:280px" data-options="required:true"></textarea></td>
				</tr>
				<tr>
					<td height="45px">状态:</td>
					<td>
						<input type="radio" value="1" checked="checked" name="role.f_status" data-options="required:true"/>启用
						<input type="radio" value="2" name="role.f_status" data-options="required:true"/>停用
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<button onclick="doSub()">提交</button>
						<button>重置</button>
					</td>
				</tr>
			</table>	
		</div>
		<div title="授予权限" style="padding:10px">
		<table> 
			
			<tr>
				<td width="50px" valign="top" style="padding-top:16px">
					<div style="height:450px;overflow-y:auto" >
						<ul id="mytree" class="easyui-tree" data-options="animate:true,checkbox:true" style="width:200px;"></ul>
					</div>
				</td>
			</tr>
		</table>
		<input type="hidden" name="rights" id="right">
		</div>
	</div>
	</form>
</body>
</html>
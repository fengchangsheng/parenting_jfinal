<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<script type="text/javascript">
function doSub(){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/treeMenu/add",
		data:$('#treeAdd').serialize(),
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
	    },
	    success: function(data) {
	    	showMsgParent(data.msg);
	    	window.parent.$('#openWin').window('close');
	    	window.parent.$('#dataTable').datagrid('reload');
	    	window.parent.$('#openWin').html("");
	    }
	});
}
</script>
<form id="treeAdd">
<input type="hidden" name="treeMenu.f_parent_node" value="${pid }">
<table width="100%" cellpadding="0" cellspacing="0"> 
	<tr> 
		<td height="45px" width="100px">菜单名称:</td>
		<td><input name="treeMenu.f_name" id="" data-options="required:true" style="width:280px"/></td>
	</tr>
	<tr>
		<td height="45px">同级排序:</td>
		<td>
			<input name="treeMenu.f_order" id="" data-options="required:true" style="width:280px"/>
		</td>
	</tr>
	<tr>
		<td>程序路径:</td>
		<td><textarea name="treeMenu.f_url" id="" rows="5" style="width:280px" data-options="required:true"></textarea></td>
	</tr>
	<tr>
		<td height="55px">节点状态:</td>
		<td>
			<input type="radio" value="1" checked="checked" name="treeMenu.f_status" data-options="required:true"/>启用
			<input type="radio" value="2" name="treeMenu.f_status" data-options="required:true"/>停用
		</td>
	</tr>
	<tr>
		<td height="55px">资源类型:</td>
		<td>
			<select name="treeMenu.f_type">
				<option value="1">菜单树显示</option>
				<option value="2">功能或页面</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2" height="55px">
			<button onclick="doSub()">提交</button>
			<button>重置</button>
		</td>
	</tr>
</table>
</form>
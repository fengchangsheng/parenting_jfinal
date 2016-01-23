<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<script type="text/javascript">
function doSub(){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/treeMenu/edit",
		data:$('#treeEdit').serialize(),
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
<form id="treeEdit">
<input type="hidden" name="treeMenu.f_id" value="${tm.f_id }" />
<table width="100%" cellpadding="0" cellspacing="0"> 
	<tr> 
		<td height="45px" width="100px">菜单名称:</td>
		<td><input name="treeMenu.f_name" id="" value="${tm.f_name }" data-options="required:true" style="width:280px"/></td>
	</tr>
	<tr>
		<td height="45px">同级排序:</td>
		<td>
			<input name="treeMenu.f_order" id="" value="${tm.f_order }" data-options="required:true" style="width:280px"/>
		</td>
	</tr>
	<tr>
		<td>程序路径:</td>
		<td><textarea name="treeMenu.f_url" id="" rows="5" style="width:280px" data-options="required:true" >${tm.f_url }</textarea></td>
	</tr>
	<tr>
		<td height="45px">是否目录:</td>
		<td>
			<input type="radio" value="Y" <c:if test='${tm.f_isforder eq "Y"}'>checked="checked"</c:if> name="treeMenu.f_isforder" data-options="required:true"/>是
			<input type="radio" value="N" <c:if test='${tm.f_isforder eq "N"}'>checked="checked"</c:if> name="treeMenu.f_isforder" data-options="required:true"/>不是
		</td>
	</tr>
	<tr>
		<td height="55px">节点状态:</td>
		<td>
			<input type="radio" value="1" <c:if test='${tm.f_status eq 1}'>checked="checked"</c:if> name="treeMenu.f_status" data-options="required:true"/>启用
			<input type="radio" value="2" <c:if test='${tm.f_status eq 2}'>checked="checked"</c:if> name="treeMenu.f_status" data-options="required:true"/>停用
		</td>
	</tr>
	<tr>
		<td height="55px">资源类型:</td>
		<td>
			<select name="treeMenu.f_type">
				<option value="1" <c:if test='${tm.f_type eq 1}'>selected="selected"</c:if> >菜单树显示</option>
				<option value="2" <c:if test='${tm.f_type eq 2}'>selected="selected"</c:if>>功能或页面</option>
			</select>
		</td>
	</tr>
	<tr>
		<td colspan="2"  >
			<button onclick="doSub()" style="margin-left: 100px">提交</button>
			<button style="margin-left: 30px">重置</button>
		</td>
	</tr>
</table>
</form>
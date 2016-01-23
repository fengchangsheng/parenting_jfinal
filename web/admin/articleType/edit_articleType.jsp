<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改类别</title>
<script type="text/javascript">

function doSub(){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/admin/articleType/ifm/edit",
		data:$('#articleTypeEdit').serialize(),
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
	    },
	    success: function(data) {
	    	showMsgParent(data);
	    	window.parent.$('#openWin').window('close');
	    	window.parent.$('#dataTable').datagrid('reload');
	    	window.parent.$('#openWin').html("");
	    }
	});
}

</script>
</head>
<body>
	<form id="articleTypeEdit" action="" method="post">
	<input type="hidden" name="id" value="${articleType.id }"/>
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="类别信息" style="padding:30px;height:400px;" fit=true>
			<table width="90%">
				<tr>
					<td height="45px" width="150px">类别名:</td>
					<td><input name="name" id="roleName" value="${articleType.name }" data-options="required:true"/></td>
				</tr>
				<tr>
					<td>类别代码:</td>
					<td><input name="code" data-options="required:true" value="${articleType.code }"/></td>
				</tr>
				<tr>
					<td>类别描述:</td>
					<td><textarea name="des" id="roleDes" rows="5" style="width:280px" data-options="required:true">${articleType.des }</textarea></td>
				</tr>
				<tr>
					<td height="45px">状态</td>
					<td>
						<input name="status" type="radio" value="1" <c:if test='${articleType.status eq 1}'>checked="checked"</c:if> /> 启用
						<input name="status" type="radio" value="0" <c:if test='${articleType.status eq 0}'>checked="checked"</c:if> /> 停用
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
	</div>
	</form>
</body>
</html>
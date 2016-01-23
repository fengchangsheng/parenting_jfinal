<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改后台用户</title>
<script type="text/javascript">

function doSub(){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/oper/edit",
		data:$('#operEdit').serialize(),
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
	    },
	    success: function(res) {
	    	showMsgParent(res.msg);
	    	window.parent.$('#openWin').window('close');
	    	window.parent.$('#dataTable').datagrid('reload');
	    	window.parent.$('#openWin').html("");
	    }
	});
}

</script>
</head>
<body>
	<form id="operEdit" action="" method="post">
	<input type="hidden" name="oper.f_id" value="${oper.f_id }"/>
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="用户信息" style="padding:30px;height:400px;" fit=true>
			<table width="90%">
				<tr>
					<td height="45px" width="150px">用户名:</td>
					<td><input name="oper.f_name" id="roleName" value="${oper.f_name }" data-options="required:true"/></td>
				</tr>
				<tr>
					<td>用户描述:</td>
					<td><textarea name="oper.f_des" id="roleDes" rows="5" style="width:280px" data-options="required:true">${oper.f_des }</textarea></td>
				</tr>
				<tr>
					<td height="45px">状态:</td>
					<td>
						<input type="radio" value="1" <c:if test='${oper.f_status eq 1}'>checked="checked"</c:if> name="oper.f_status" data-options="required:true"/>启用
						<input type="radio" value="2" <c:if test='${oper.f_status eq 2}'>checked="checked"</c:if> name="oper.f_status" data-options="required:true"/>停用
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
		<div title="角色设置" style="padding:30px">
		<table> 
			<tr>
			<c:forEach items="${roleList}" var="role" begin="0" varStatus="status"> 
				<c:set var="flag" value="1"></c:set>
				<c:forEach items="${userRoles}" var="userRole">
					<c:if test="${role.f_id eq userRole.role_id }">
						<c:set var="flag" value="2"></c:set>
					</c:if>
				</c:forEach>
				<c:if test="${status.index%4==0&&status.index!=0}">
					</tr><tr>
					<td><input name="roleId" type="checkbox" <c:if test='${flag eq 2 }'>checked="true"</c:if> value="${role.f_id }"/>${role.f_name }</td>
				</c:if> 
				<c:if test="${status.index%4!=0||status.index==0}">
					<td><input name="roleId" type="checkbox" <c:if test='${flag eq 2 }'>checked="true"</c:if> value="${role.f_id }"/>${role.f_name }</td>
				</c:if>				
			</c:forEach>
			</tr>
		</table>
		</div>
	</div>
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增用户</title>
<script type="text/javascript">

function doSub(){
	$.ajax({//这里还是ajax提交
		cache: true,
		type: "POST",
		url:"${basePath}/userCon/add",
		data:$('#userAdd').serialize(),
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
	    },
	    success: function(data) {
	    	showMsgParent(data.msg);
	    	window.parent.$('#openWin').window('close');
	    	window.parent.$('#dataTable').datagrid('reload');
	    }
	});
}

function checkRights(name){
	var flag=$("#flag_"+name).val();
	if(flag==1){
		$('input[name="rights_'+name+'"]').each(function() {
			$(this).prop("checked",true);
	    });
		$("#flag_"+name).val("2");
	}else{
		$('input[name="rights_'+name+'"]').each(function() {
			$(this).prop("checked",false);
    	});
		$("#flag_"+name).val("1");
	}
}

function submitImage(){
	$("#userAdd").form("submit",{
		success:function(data){
			$("#img").attr("src","${basePath }/imgUpload/userImg/"+data);
			$("#userImg").attr("value",data);
		}
	});
	//$("#hidden_frame" ).attr("style", "display:block");  
}
</script>
</head>
<body>
	<form id="userAdd" action="${basePath}/file/ajaxSub" method="post" enctype="multipart/form-data" target="hidden_frame" >
	<input type="hidden" name="user.f_img" id="userImg" />
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="用户信息" style="padding:20px;height:400px;" fit=true>
			<table width="90%">
				<tr>
					<td height="45px" width="150px">用户名:</td>
					<td><input name="user.f_name" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">用户昵称:</td>
					<td><input name="user.f_nickName" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td>用户描述:</td>
					<td><textarea name="user.f_des" rows="5" style="width:280px" data-options="required:true"></textarea></td>
				</tr>
				<tr>
					<td height="45px" width="150px">邮箱:</td>
					<td><input name="user.f_email" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">QQ号:</td>
					<td><input name="user.f_qq" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">年龄:</td>
					<td><input name="user.f_age" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">工作:</td>
					<td><input name="user.f_job" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">地址:</td>
					<td><input name="user.f_addr" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">手机号:</td>
					<td><input name="user.f_mobile" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">性别:</td>
					<td>
						<input type="radio" value="1" checked="checked" name="user.f_sex" data-options="required:true"/>男
						<input type="radio" value="2" name="user.f_sex" data-options="required:true"/>女
					</td>
				</tr>
				<tr>
					<td height="45px">状态:</td>
					<td>
						<input type="radio" value="1" checked="checked" name="user.f_status" data-options="required:true"/>启用
						<input type="radio" value="2" name="user.f_status" data-options="required:true"/>停用
					</td>
				</tr> 
				<tr>
					<td height="45px">用户头像</td>
					<td>
						<input type="file" name="file" id="photoSub" onchange="submitImage()"/>
						<img id="img"  style="height: 100px"/>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="45px">
						<button onclick="doSub()">提交</button>
						<button>重置</button>
					</td>
				</tr>
			</table>	
		</div>

		<div title="角色设置" style="padding:30px">
		<table> 
			<tr>
			<c:forEach items="${listRole }" var="role" begin="0" varStatus="status"> 
				<c:if test="${status.index%5==0&&status.index!=0}">
					</tr><tr>
					<td><input name="user.f_role" type="radio" value="${role.f_id }"/>${role.f_name }</td>
				</c:if> 
				<c:if test="${status.index%5!=0||status.index==0}">
					<td><input name="user.f_role" type="radio" value="${role.f_id }"/>${role.f_name }</td>
				</c:if>				
			</c:forEach>
			</tr>
		</table>
		</div>
	</div>
	<iframe name='hidden_frame' id="hidden_frame" style='display:none;'>
			</iframe>
	</form>
</body>
</html>
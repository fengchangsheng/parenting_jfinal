<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改前台用户</title>
<script src="${basePath}/resource/js/uploadPreview.js" type="text/javascript"></script>
<script src="${basePath}/resource/js/md5.js" type="text/javascript"></script>
<script type="text/javascript">

	 window.onload = function () { 
         new uploadPreview({ UpBtn: "up_img", DivShow: "imgdiv", ImgShow: "imgShow" });
     }

	function submitImageForm(){
		$("#userEdit").form("submit",{
			success:function(data){
				var data = eval('(' + data + ')');//需要解析
				showMsgParent(data.msg);
				window.parent.$('#openWin').window('close');
		    	window.parent.location.href='${basePath}/userCon/me';
			}
		});
	}
	
	function doRest(){
		document.getElementById("myForm").reset();
	}
</script>
</head>
<body>
	<form enctype="multipart/form-data" id="userEdit" action="${basePath}/userCon/editMy" method="post"  >
	<input type="hidden" name="user.f_id" value="${user.f_id }"/>
	<input type="hidden" name="user.f_img" id="userImg" value="${user.f_img }" />
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="基本信息" style="padding:10px;height:400px;" fit=true>
			<table width="90%">
				<tr>
					<td height="45px" width="150px">用户名:</td>
					<td><input name="user.f_name" value="${user.f_name }" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">用户昵称:</td>
					<td><input name="user.f_nickName" value="${user.f_nickName }" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td>个性签名:</td>
					<td><textarea name="user.f_des" rows="5" style="width:280px" data-options="required:true">${user.f_des }</textarea></td>
				</tr>
				<tr>
					<td height="45px" width="150px">邮箱:</td>
					<td><input name="user.f_email" value="${user.f_email }" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">QQ号:</td>
					<td><input name="user.f_qq" value="${user.f_qq }" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">年龄:</td>
					<td><input name="user.f_age" value="${user.f_age }" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">工作:</td>
					<td><input name="user.f_job" value="${user.f_job }" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">地址:</td>
					<td><input name="user.f_addr" value= "${user.f_addr }" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">手机号:</td>
					<td><input name="user.f_mobile" value="${user.f_mobile }" style="width:280px"  data-options="required:true"/></td>
				</tr>
				<tr>
					<td height="45px" width="150px">性别:</td>
					<td>
						<input type="radio" value="1" <c:if test='${user.f_sex eq 1}'>checked="checked"</c:if> name="user.f_sex" data-options="required:true"/>男
						<input type="radio" value="2" <c:if test='${user.f_sex eq 2}'>checked="checked"</c:if> name="user.f_sex" data-options="required:true"/>女
					</td>
				</tr>
				<tr >
					<td height="45px" rowspan="2">用户头像:</td>
					<td height="80px">
						 <img id="imgShow" style="height: 80px" src="${basePath }/imgUpload/userImg/${user.f_img }"/>
					</td>
				</tr>
				<tr >
					<td ><input type="file" id="up_img" name="file"/></td>
				</tr>
				<tr>
					<td colspan="2" height="45px">
						<button onclick="submitImageForm()" type="button">提交</button>
						<button>重置</button>
					</td>
				</tr>
			</table>	
		</div>
		<div title="修改密码" >
			<table style="margin-top: 20px">
				<tr>
					<td>初始密码</td>
					<td><input type="password" onblur="checkpass()" id="pw" /></td>
					<td><span id="p" style="color: red;"></span></td>
				</tr>
				<tr>
					<td>新密码</td>
					<td><input type="password" onblur="checkLength()" id="pw1"/></td>
					<td><span id="p1" style="color: red;"></span></td>
				</tr>
				<tr>
					<td>确认密码</td>
					<td><input type="password" onchange="checkEqual()" id="pw2"/></td>
					<td><span id="p2" style="color: red;"></span></td>
				</tr>
				<tr>
					<td></td>
					<td><input type="button" onclick="doSubmit()" value="提交修改"/></td>
					<td></td>
				</tr>
			</table>
		</div>
		
	</div>
	</form>
<script type="text/javascript">
function checkpass(){
	var md5 = new MD5();
	var pass = md5.MD5($("#pw").val()).toUpperCase();
	var userPass = "${user.f_passwd}";
	if(pass==userPass){
		$("#p").html("密码正确");

	}else{
		$("#p").html("密码错误");
	}
	
}

function checkLength(){
	var pass1 = $("#pw1").val();
	if(pass1.length<6){
		$("#p1").html("密码不能低于6位");
	}else{
		$("#p1").html("");
	}
}

function checkEqual(){
	var pass1 = $("#pw1").val();
	var pass2 = $("#pw2").val();
	if(pass1!=pass2){
		$("#p2").html("两次输入密码不一致");
    }else{
    	$("#p2").html("");
    }
}

function doSubmit(){
	var pass = $("#pw2").val();
	if($("#p").html()!="密码正确" || $("#p1").html()!= "" || $("#p2").html()!= ""|| $("#pw2").val()==""){
		return;
	}
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/userCon/changePass",
		data:{pw:pass},
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
	    },
	    success: function(data) {
	    	alert(data.msg);
	    	window.parent.$('#openWin').window('close');
	    	window.parent.location.href='${basePath}/login.jsp';
	    }
	});
}

</script>	
</body>
</html>
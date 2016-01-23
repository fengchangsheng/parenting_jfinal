<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改后台用户</title>
<style type="text/css">
.pass{
	display:none;
}

</style>
<script src="${basePath}/resource/js/md5.js" type="text/javascript"></script>
<script type="text/javascript">

function doSub(){
	if(!$(".pass").is(":hidden")){
		var pass = $("#pw2").val();
		if($("#p").html()!="密码正确" || $("#p1").html()!= "" || $("#p2").html()!= ""|| $("#pw2").val()==""){
			return;
		}
	}
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/oper/editPass",
		data:{
			name: $("#operName").val(),
			des: $("#operDes").val(),
			pass:pass
		},
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
	    },
	    success: function(res) {
	    	showMsgGrandParent(res.msg);
	    	if(res.status=="1"){
	    		top.window.location.href="${basePath}/"+res.url;
		    }else if(res.status=="2"){
		    	window.location.href="${basePath}/"+res.url;
		    }
	    }
	});
}

function showPass(){
	$(".pass").css('display', 'block');
	//alert($(".pass").is(":hidden"));
}

</script>
</head>
<body>
	<form id="operEdit" action="" method="post">
	<input type="hidden" name="oper.f_id" value="${oper.f_id }"/>
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="个人基本信息" style="padding:30px;height:400px;" fit=true>
			<table width="75%">
				<tr>
					<td height="45px" width="100px">用户名:</td>
					<td width="350px"><input name="oper.f_name" id="operName" value="${oper.f_name }" data-options="required:true"/></td>
					
					<td class="pass" width="50px">初始密码</td>
					<td class="pass" width="160px"><input type="password" onblur="checkpass()" id="pw" /></td>
					<td class="pass" width="150px"><span id="p" style="color: red;"></span></td>
				</tr>
				<tr>
					<td>用户描述:</td>
					<td><textarea name="oper.f_des" id="operDes" rows="5" style="width:280px" data-options="required:true">${oper.f_des }</textarea></td>
					
					<td class="pass" width="50px" >
						<table>
							<tr><td>新密码</td></tr>
							<tr><td>确认密码</td></tr>
						</table>
					</td>
					<td class="pass" width="160px">
						<table>
							<tr><td><input type="password" onblur="checkLength()" id="pw1"/></td></tr>
							<tr><td><input type="password" onchange="checkEqual()" id="pw2"/></td></tr>
						</table>
					</td>
					<td class="pass" width="150px">
						<table>
							<tr><td><span id="p1" style="color: red;"></span></td></tr>
							<tr><td><span id="p2" style="color: red;"></span></td></tr>
						</table>
					</td>
				</tr>
					
				<tr>
					<td><button>重置</button></td>
					<td><button onclick="doSub()">提交</button></td>
					<td><button onclick="showPass()" type="button" width="50px">修改密码</button></td>
				</tr>
			</table>	
		</div>
	 </div>
	</form>
<script type="text/javascript">
function checkpass(){
	var md5 = new MD5();
	var pass = md5.MD5($("#pw").val()).toUpperCase();
	var userPass = "${oper.f_passwd}";
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


</script>
</body>
</html>
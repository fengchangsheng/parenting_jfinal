<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改广告</title>
<script src="${basePath}/resource/js/uploadPreview.js" type="text/javascript"></script>
<script>
    window.onload = function () { 
         new uploadPreview({ UpBtn: "up_img", DivShow: "imgdiv", ImgShow: "imgShow" });
     }
     
	function submitImageForm(){
		$("#configEdit").form("submit",{
			success:function(data){
				var data = eval('(' + data + ')');//需要解析
				showMsgParent(data.msg);
		    	window.parent.$('#openWin').window('close');
		    	window.parent.$('#dataTable').datagrid('reload');
			}
		});
	}
</script>
</head>
<body>
	<form id="configEdit" enctype="multipart/form-data" action="${basePath}/ads/edit" method="post" >
	<input type="hidden" name="ads.id" value="${ads.id }"/>
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="广告信息" style="padding:10px;height:400px;" fit=true>
			<table width="90%">
				<tr>
					<td height="45px" width="150px">广告标题:</td>
					<td><input name="ads.des" data-options="required:true" value="${ads.des }" style="width: 300px"/></td>
				</tr>
				<tr>
					<td height="45px">跳转路径:</td>
					<td><input name="ads.url" data-options="required:true" value="${ads.url }" style="width: 300px"/></td>
				</tr>
				<tr>
					<td height="45px">简要描述:</td>
					<td><input name="ads.shortDes" data-options="required:true" value="${ads.shortDes }" style="width: 300px"/></td>
				</tr>
				<tr>
					<td height="45px">是否置顶:</td>
					<td>
						<input name="ads.isTop" type="radio" <c:if test='${ads.isTop eq 1}'>checked="checked"</c:if> value="1" data-options="required:true"/>启用
						<input name="ads.isTop" type="radio" <c:if test='${ads.isTop eq 2}'>checked="checked"</c:if> value="2" data-options="required:true"/>停用
					</td>
				</tr>
				<tr>
					<td height="45px">状态:</td>
					<td>
						<input name="ads.status" type="radio" <c:if test='${ads.status eq 1}'>checked="checked"</c:if> value="1" data-options="required:true"/>启用
						<input name="ads.status" type="radio" <c:if test='${ads.status eq 2}'>checked="checked"</c:if> value="2" data-options="required:true"/>停用
					</td>
				</tr>
				<tr>
					<td>广告文字:</td>
					<td><textarea name="ads.imgDetail" rows="10" style="width:280px" data-options="required:true">${ads.imgDetail }</textarea></td>
				</tr>
				<tr>
					<td height="40px" rowspan="2">广告图片:</td>
					<td style="padding-top:20px;">
						 <div id="imgdiv"><img id="imgShow" width="100" height="100" src="${basePath}/imgUpload/adsImg/${ads.imgPath}"/></div>
					</td>
				</tr>
				<tr>
					<td><input type="file" id="up_img" name="file"/></td>
				</tr>
				<tr>
					<td colspan="2" height="40px">
						<button onclick="submitImageForm()" type="button">提交</button>
						<button type="reset">重置</button>
					</td>
				</tr>
			</table>	
		</div>
	</div>
	</form>
</body>
</html>
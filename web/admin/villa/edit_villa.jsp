<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改美图</title>

</head>
<body>
	<form id="configEdit" enctype="multipart/form-data" action="${basePath}/admin/villa/ifm/edit" method="post" target="hidden_frame">
	<input type="hidden" name="id" value="${villa.id }"/>
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="美图信息" style="padding:10px;height:400px;" fit=true>
			<table width="90%">
				<tr>
					<td height="45px" width="150px">标题:</td>
					<td><input name="title" data-options="required:true" value="${villa.title }" style="width: 300px"/></td>
				</tr>
				<tr>
					<td height="45px">图片预览</td>
					<td height="80px">
						<img alt="" width="200ox" height="200px" src="${basePath }/${villa.path }">
					</td>
				</tr>
				<tr>
					<td height="45px">上传图片</td>
					<td><input type="file" name="file"/></td>
				</tr>
				<tr>
					<td colspan="2" height="40px">
						<button>提交</button>
						<button>重置</button>
					</td>
				</tr>
			</table>	
		</div>
	</div>
	<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
	</form>
</body>
</html>
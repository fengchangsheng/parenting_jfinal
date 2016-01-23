<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>修改参数</title>
<script type="text/javascript">

function doSub(){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/note/edit",
		data:$('#noticeEdit').serialize(),
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
</head>
<body>
	<form id="noticeEdit" action="" method="post">
	<input type="hidden" name="notice.id" value="${notice.id}"/>
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
		<div title="参数信息" style="padding:30px;height:400px;" fit=true>
			<table width="90%">
				<tr>
					<td height="45px" width="150px">标题名:</td>
					<td><input name="notice.title" value="${notice.title }" data-options="required:true"/></td>
				</tr>
				<tr>
					<td>公告内容:</td>
					<td><textarea name="notice.content" rows="5" style="width:280px" data-options="required:true">${notice.content }</textarea></td>
				</tr>
				<tr>
					<td colspan="2" height="40px">
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
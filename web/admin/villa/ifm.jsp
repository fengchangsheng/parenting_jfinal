<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	var msg="${msg}";
	showMsgGrandParent(msg);
	window.parent.parent.$('#openWin').window('close');
	window.parent.parent.$('#dataTable').datagrid('reload');
	window.parent.parent.$('#openWin').html("");
</script>
</head>
<body>
</body>
</html>
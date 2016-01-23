<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="${basePath }/include/css/gray/easyui.css">
<link rel="stylesheet" type="text/css" href="${basePath }/include/css/icon.css">  
<link rel="stylesheet" type="text/css" href="${basePath }/include/css/demo.css"> 
<script type="text/javascript" src="${basePath }/include/js/jquery.min.js"></script>
<script type="text/javascript" src="${basePath }/include/js/jquery.easyui.min.js"></script>
<script type="text/javascript">
function showMsgGrandParent(info){
	window.parent.parent.$.messager.show({
		title:'提示',
		msg:info,
		showType:'show'
	});
}

function showMsgParent(info){
	window.parent.$.messager.show({
		title:'提示',
		msg:info,
		showType:'show'
	});
}

function showMsg(info){
	$.messager.show({
		title:'提示',
		msg:info,
		showType:'show'
	});
}
</script>
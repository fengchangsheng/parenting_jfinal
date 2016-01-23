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
$(function(){
	$('#dataTable').datagrid({
		nowrap: true,
		autoRowHeight: false, 
		singleSelect:true,
		striped: true,
		collapsible:true,
		idField: "id", 
		url:'${basePath}/sug/listSugJSON',
		sortOrder: 'desc',
		remoteSort: false,
		frozenColumns:[[
            {field:'id',checkbox:true},
            {field:'name',title:'用户名',width:80}
		]],
		columns:[[
			{field:'age',title:'年龄',width:50},
			{field:'subject',title:'职位',width:50},
			{field:'message',title:'建议内容',width:620},
			{field:'pubTime',title:'创建时间',width:100,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnactive',
			text:'删除建议',
			iconCls:'icon-remove',
			handler:function(){
				var row = $('#dataTable').datagrid('getSelected');
				if(!row){
					showMsg("请先选择一个用户");
					return;
				}
				$.messager.confirm('确认', "确定要删除选中的用户?此操作不可撤销，请谨慎操作。", function (r) {
				     if (r) {
				    	 doDel(row.id);
				     }
				 });
			}
		}],
		onRowContextMenu: function (e, field) {
            e.preventDefault();
            $('#menu').menu('show', {
    			left: e.pageX,
    			top: e.pageY
    		});
        }
	});
	var p = $('#dataTable').datagrid('getPager');  
    $(p).pagination({  
        pageSize: 10,//每页显示的记录条数，默认为10  
        pageList: [5,10,15,20],//可以设置每页记录条数的列表  
        beforePageText: '第',//页数文本框前显示的汉字  
        afterPageText: '页    共 {pages} 页',  
        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',  
        /*onBeforeRefresh:function(){ 
            $(this).pagination('loading'); 
            alert('before refresh'); 
            $(this).pagination('loaded'); 
        }*/ 
    });
});

function doQuery(){
	var name=$("#name").val();
	var status=$("#status").val();
	$('#dataTable').datagrid('load',{
		name: name,
		status: status
	});
}

function doDel(id){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/sug/del",
		data:{id:id},
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
	    },
	    success: function(res) {
	    	showMsg(res.msg);
	    	$('#dataTable').datagrid('reload');
	    }
	});
}

</script> 
</head> 
<body>
<div id="openWin" class="easyui-window" title="后台用户管理" data-options="closed:true,modal:true," style="width:500px;height:500px;"></div>
<div id="menu" class="easyui-menu" style="width:150px;">
    <div id="m-refresh">新增</div>
    <div class="menu-sep"></div>
    <div id="m-refresh">修改</div>
    <div class="menu-sep"></div>
    <div id="m-closeall">停用角色</div>
    <div id="m-closeother">启用角色</div>
</div>
<div id="mainPanel" class="easyui-panel" style="padding:0 20 10 20;" border=false >
	<table class="easyui-datagrid" id="dataTable" data-options=""></table>
</div>
</body>
</html>
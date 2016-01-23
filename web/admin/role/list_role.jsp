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
		//title: '角色信息',
		autoRowHeight: false, 
		singleSelect:true,
		striped: true,
		collapsible:true,
		idField: "id", 
		url:'${basePath}/role/listRoleJSON',
		sortOrder: 'desc',
		remoteSort: false,
		frozenColumns:[[
            {field:'f_id',checkbox:true},
            {title:'角色名',field:'f_name',width:120}
		]],
		columns:[[
			{field:'f_des',title:'描述',width:320},
			{field:'f_create_time',title:'创建时间',width:200,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
			{field:'f_status',title:'状态',width:150,sortable:true,
				formatter: function(value,row,index){
					if(value=="1"){
						return "<font style='color:green'>启用</font>";
					}else if(value=="2"){
						return "<font style='color:red'>停用</font>";
					}
				}
			},
			{field:'isPur',title:'是否授权',width:150,sortable:true,
				formatter: function(value,row,index){
					if(value=="1"){
						return "<font style='color:green'>已授权</font>";
					}else if(value=="0"){
						return "<font style='color:red'>未授权</font>";
					}
				}
			}
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'添加角色',
			iconCls:'icon-add',
			handler:function(){
				$('#openWin').html("");
				$('#openWin').append("<iframe src='${basePath}/role/toAdd' width='100%' height='99%' frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='no' allowtransparency='yes'></iframe>");
				$('#openWin').window('open');  
			}
		},{
			id:'btnedit',
			text:'修改角色',
			iconCls:'icon-edit',
			handler:function(){
				var row = $('#dataTable').datagrid('getSelected');
				if(!row){
					showMsg("请先选择一个角色");
					return;
				}
				$('#openWin').html("");
				$('#openWin').append("<iframe src='${basePath}/role/toEdit/"+row.f_id+"' width='100%' height='99%' frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='no' allowtransparency='yes'></iframe>");
				$('#openWin').window('open');  
			}
		},{
			id:'btnactive',
			text:'删除角色',
			iconCls:'icon-remove',
			handler:function(){
				var row = $('#dataTable').datagrid('getSelected');
				if(!row){
					showMsg("请先选择一个角色");
					return;
				}
				$.messager.confirm('确认', "确定要删除选中的角色?此操作不可撤销，请谨慎操作。", function (r) {
				     if (r) {
				    	 doDel(row.f_id);
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
	if(name=="" && status==""){
		return;
	}
	$('#dataTable').datagrid('load',{
		name: name,
		status: status
	});
}

function doDel(id){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/role/delete",
		data:{id:id},
		async: false,
	    error: function(request) {
	    	showMsg(request.msg);
	    },
	    success: function(data) {
	    	showMsg(data.msg);
	    	$('#dataTable').datagrid('reload');
	    }
	});
}

</script> 
</head> 
<body>
<div id="openWin" class="easyui-window" title="角色管理" data-options="closed:true,modal:true," style="width:500px;height:500px;"></div>
<div id="menu" class="easyui-menu" style="width:150px;">
    <div id="m-refresh">新增</div>
    <div class="menu-sep"></div>
    <div id="m-refresh">修改</div>
    <div class="menu-sep"></div>
    <div id="m-closeall">停用角色</div>
    <div id="m-closeother">启用角色</div>
</div>
<div id="mainPanel" class="easyui-panel" style="padding:0 20 10 20;" border=false >
    <form id="ff" method="post">
	    <div id="tb" style="padding:3px">
			<span>角色名:</span>
			<input class="easyui-validatebox textbox" type="text" name="name" id="name" data-options="" />
			<span>状态:</span>
			<select name="status" id="status" style="width:80px">
				<option value="">--请选择--</option>
				<option value="1">启用</option>
				<option value="2">停用</option>
			</select>
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="doQuery()">查询</a>
		</div>
		<hr style="border:0;border-bottom: 1px solid #d3d3d3; width: 100%;"> 
    </form>  
	<table class="easyui-datagrid" id="dataTable" data-options=""></table>
</div>
</body>
</html>
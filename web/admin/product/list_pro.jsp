<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>NsParenting admin</title>
<script type="text/javascript">
$(function(){
	$('#dataTable').datagrid({
		nowrap: true,
		//title: '文章信息',
		autoRowHeight: false, 
		singleSelect:true,
		striped: true,
		collapsible:true,
		idField: "id", 
		url:'${basePath}/pro/listProJSON',
		sortOrder: 'desc',
		remoteSort: false,
		frozenColumns:[[
            {field:'id',checkbox:true},
            {title:'标题',field:'title',width:220}
		]],
		columns:[[
			{field:'price',title:'价格',width:160},
			{field:'pubTime',title:'发布时间',width:200,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},{field:'imgFromType',title:'图片来源',width:120,
				formatter: function(value,row,index){
					if(value=="1"){
						return "<font style='color:green'>引用网络</font>";
					}else if(value=="2"){
						return "<font style='color:red'>手动上传</font>";
					}
				}
			},
			{field:'tag',title:'标签',width:120,sortable:true},
			{field:'addrName',title:'商品来源',width:80}
		]],
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'添加商品',
			iconCls:'icon-add',
			handler:function(){
				$('#openWin').html("");
				$('#openWin').append("<iframe src='${basePath}/pro/toAdd' width='100%' height='99%' frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='no' allowtransparency='yes'></iframe>");
				$('#openWin').window('open');  
			}
		},{
			id:'btnedit',
			text:'修改商品',
			iconCls:'icon-edit',
			handler:function(){
				var row = $('#dataTable').datagrid('getSelected');
				if(!row){
					showMsg("请先选择一个文章");
					return;
				}
				$('#openWin').html("");
				$('#openWin').append("<iframe src='${basePath}/pro/toEdit?id="+row.id+"' width='100%' height='99%' frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='no' allowtransparency='yes'></iframe>");
				$('#openWin').window('open');  
			}
		},{
			id:'btnactive',
			text:'删除商品',
			iconCls:'icon-remove',
			handler:function(){
				var row = $('#dataTable').datagrid('getSelected');
				if(!row){
					showMsg("请先选择一个商品");
					return;
				}
				$.messager.confirm('确认', "确定要删除选中的商品信息?此操作不可撤销，请谨慎操作。", function (r) {
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
	$('#dataTable').datagrid('load',{
		name: name
	});
}

function doDel(id){
	$.ajax({
		cache: true,
		type: "POST",
		url:"${basePath}/pro/delete",
		data:{id:id},
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
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
<div id="openWin" class="easyui-window" title="商品管理" data-options="closed:true,modal:true,maximized:true" style="width:800px;height:500px;"></div>
<div id="menu" class="easyui-menu" style="width:150px;">
    <div id="m-refresh">新增</div>
    <div class="menu-sep"></div>
    <div id="m-refresh">修改</div>
    <div class="menu-sep"></div>
    <div id="m-closeall">下架商品</div>
    <div id="m-closeother">上架商品</div>
</div>
<div id="mainPanel" class="easyui-panel" style="padding:0 20 10 20;" border=false >
    <form id="ff" method="post">
	    <div id="tb" style="padding:3px">
			<span>商品名:</span>
			<input class="easyui-validatebox textbox" type="text" name="name" id="name" data-options="" />
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="doQuery()">查询</a>
		</div>
		<hr style="border:0;border-bottom: 1px solid #d3d3d3; width: 100%;"> 
    </form>  
	<table class="easyui-datagrid" id="dataTable" data-options="method:'post'"></table>
</div>
</body>
</html>
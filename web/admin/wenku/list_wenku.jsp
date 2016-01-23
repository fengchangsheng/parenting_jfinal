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
		//title: '文库信息',
		autoRowHeight: false, 
		singleSelect:true,
		striped: true,
		collapsible:true,
		idField: "id", 
		url:'${basePath}/admin/wenku/ifm/listWenKuJSON',
		sortOrder: 'desc',
		remoteSort: false,
		frozenColumns:[[
            {field:'id',checkbox:true},
            {title:'文库标题',field:'title',width:120}
		]],
		columns:[[
			{field:'author',title:'作者',width:120},
			{field:'createTime',title:'创建时间',width:150,sortable:true,
				sorter:function(a,b){
					return (a>b?1:-1);
				}
			},
			{field:'status',title:'状态',width:120,sortable:true,
				formatter: function(value,row,index){
					if(value=="1"){
						return "<font style='color:green'>启用</font>";
					}else if(value=="2"){
						return "<font style='color:red'>停用</font>";
					}
				}
			},
			{field:'isTop',title:'置顶',width:120,sortable:true,
				formatter: function(value,row,index){
					if(value=="1"){
						return "<font style='color:green'>置顶</font>";
					}
				}
			}
		]], 
		pagination:true,
		rownumbers:true,
		toolbar:[{
			id:'btnadd',
			text:'添加文库',
			iconCls:'icon-add',
			handler:function(){
				$('#openWin').html("");
				$('#openWin').append("<iframe src='${basePath}/admin/wenku/ifm/toAdd' width='100%' height='99%' frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='no' allowtransparency='yes'></iframe>");
				$('#openWin').window('open');  
			}
		},{
			id:'btnedit',
			text:'修改文库',
			iconCls:'icon-edit',
			handler:function(){
				var row = $('#dataTable').datagrid('getSelected');
				if(!row){
					showMsg("请先选择一个文库");
					return;
				}
				$('#openWin').html("");
				$('#openWin').append("<iframe src='${basePath}/admin/wenku/ifm/toEdit?id="+row.id+"' width='100%' height='99%' frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='no' allowtransparency='yes'></iframe>");
				$('#openWin').window('open');  
			}
		},{
			id:'btnactive',
			text:'删除文库',
			iconCls:'icon-remove',
			handler:function(){
				var row = $('#dataTable').datagrid('getSelected');
				if(!row){
					showMsg("请先选择一个文库");
					return;
				}
				$.messager.confirm('确认', "确定要删除选中的文库?此操作不可撤销，请谨慎操作。", function (r) {
				     if (r) {
				    	 doDel(row.id);
				     }
				 });
			}
		}]
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
		url:"${basePath}/admin/wenku/ifm/del",
		data:{id:id},
		async: false,
	    error: function(request) {
	    	alert("系统错误,请刷新后重试");
	    },
	    success: function(data) {
	    	showMsg(data);
	    	$('#dataTable').datagrid('reload');
	    }
	});
}

</script> 
</head> 
<body>
<div id="openWin" class="easyui-window" title="文库管理" data-options="closed:true,modal:true," style="width:500px;height:500px;"></div>
<div id="mainPanel" class="easyui-panel" style="padding:0 20 10 20;" border=false >
    <form id="ff" method="post">
	    <div id="tb" style="padding:3px">
			<span>文库内容:</span> 
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
	<table class="easyui-datagrid" id="dataTable" data-options="method:'post'"></table>
</div>
</body>
</html>
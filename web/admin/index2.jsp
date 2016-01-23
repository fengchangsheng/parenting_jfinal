<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>网站管理</title> 
<style type="text/css">
	.brand {
		display: block;
		font-size: 30px;
		font-weight: 200;
		color: black;
		margin-top:5px;
		margin-left:30px;
		text-shadow: 0 1px 0 #080808;
		font-family: verdana,helvetica,arial,sans-serif;
	}
	.brand a{
		display: block;
		font-size: 15px;
		font-weight: 200;
		color: gray;
		margin-top:20px; 
		margin-left:20px;
		text-shadow: 0 1px 0 #080808;
		font-family: verdana,helvetica,arial,sans-serif;
	}  
	.brand a:link,.brand a:visited,.brand a:hover{
		text-decoration:none; 
	}
</style> 
<script type="text/javascript">
	$(function () {
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/treeMenu/treeJSON",
			dataType:"text",
			data: {nodeGrade:"0",parentNode:"0"},
			async: false,
		    success: function(data) {
		    	treeJSON=data;
		    },
		    error: function(request) {
		        alert("菜单加载失败,请刷新页面!");
		    }
		});
	    $('#mytree').tree({
            data: eval(treeJSON),
            onClick: function (node) {
                if(node.url){
                	var num = Math.random()*100;
                	var url="${basePath}/"+node.url+"/"+parseInt(num);
                    //var url="${basePath}/"+node.url+"/num="+Math.random();
                	//document.getElementById("mainFrame").src=url;
                	//$("#mainContent").load(url,function(){
                		//$.parser.parse("mainContent");
                	//});
                	addTab(node.text,url,node.id);
                	$.parser.parse("mainContent");
                }else{
                	$('#mytree').tree('expandAll', node.target);
                }
            }
	    });
	    $("#tabs").bind('contextmenu',function(e){
			e.preventDefault();
			$('#menu').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
		});
	    		
	});
	
	var index = 0;
	function addTab(text,url,id){
		if(index>9){
			$.messager.show({
				title:'提示',
				msg:"您已打开超过10个窗口,为保证操作流畅,建议关闭后再操作!",
				showType:'show'
			});
		}
		if (!$('#tabs').tabs('exists', text)) {  
		$('#tabs').tabs('add',{
			title:text,
			id:id,
			content:"<iframe src='"+url+"' id='ifm"+id+"' width='100%' height='99%' frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='no' allowtransparency='yes'>",
			closable:true,
			tools:[{
				iconCls:'icon-mini-refresh',
				handler:function(){
					$("#ifm"+id).attr("src",url);
				}
			}]
		});
		index++;
		} else {  
		    $('#tabs').tabs('select', text); 
		} 
		
	}
	
	function reloadTab(){
		var selectedTab = $("#tabs").tabs("getSelected");
		var id = selectedTab.panel('options').id;
		var url=$("#ifm"+id).attr("src");
		$("#ifm"+id).attr("src",url);
	}
	
	function closeTab(){
		var selectedTab = $("#tabs").tabs("getSelected");
		var title = selectedTab.panel('options').title;
		$('#tabs').tabs('close', title);
		index--;
	}
	
	function closeAll(){
		var tiles = new Array();
		var tabs = $('#tabs').tabs('tabs');    
		var len =  tabs.length;	
		if(len>0){
			for(var j=0;j<len;j++){
				var a = tabs[j].panel('options').title;				
				tiles.push(a);
			}
			for(var i=0;i<tiles.length;i++){				
				$('#tabs').tabs('close', tiles[i]);
			}
		}
		index=0;
	}
	
	function closeAllButThis(){
		var selectedTab = $("#tabs").tabs("getSelected");
		var thisTitle = selectedTab.panel('options').title;
		var tiles = new Array();
		var tabs = $('#tabs').tabs('tabs');    
		var len =  tabs.length;	
		if(len>0){
			for(var j=0;j<len;j++){
				var a = tabs[j].panel('options').title;				
				if(a!=thisTitle){
					tiles.push(a);
				}
			} 
			for(var i=0;i<tiles.length;i++){				
				$('#tabs').tabs('close', tiles[i]);
			}
		}
		index=1;
	}

	function show(){
		alert(1);
	}

</script>
</head> 
<body class="easyui-layout">    
	<div id="menu" class="easyui-menu" style="width:150px;">
	    <div id="m-refresh" onclick="reloadTab()">刷新</div>
	    <div class="menu-sep"></div>
	    <div id="m-closeall" onclick="closeAll()">全部关闭</div>
	    <div id="m-closeother" onclick="closeAllButThis()">除此之外全部关闭</div>
	    <div class="menu-sep"></div>   
	    <div id="m-close" onclick="closeTab()">关闭</div>
	</div>
	<div data-options="region:'north',border:false" style="height:62px;background:rgb(248, 248, 248);overflow:hidden;">
		<div style="width:200px;float:left"><!-- 47  150 -->
			<div ><img src="${basePath}/images/mylogo.png" alt="Logo" /></div>  
		</div>
		<div style="float:left;margin-left: -30px"><p class="brand">后台管理</p></div>
		<div style="width:150px;float:right;">
			<p class="brand"><a href="${basePath }/admin/logOut">退出</a></p>  
		</div>	
	</div> 
	<div data-options="region:'west',split:true,title:'菜单栏'" style="width:200px;padding:10px;">
		<!-- 树形菜单 -->     
		<ul id="mytree" class="easyui-tree" data-options="animate:true"></ul>
	</div> 
	<div data-options="region:'east',split:true,collapsed:true,title:'小工具'" style="width:190px;">
		<div id="cc" class="easyui-calendar" style="width:180px;height:180px;"></div>
	</div>
	<!-- 中央区域 -->
	<div data-options="region:'center'" id="mainContent">
	<!-- <iframe id="mainFrame" name="mainFrame" src="${basePath }/admin/index" width="100%" height="99%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe> --> 
		<div id="tabs" class="easyui-tabs" fit=true border=false data-options="" >
			<div title="欢迎页" style="padding:10px">
			<!-- 	<p><span style="font-size: 1.5em"> 欢迎光临新晟亲子教育后台管理系统.</span></p> -->
				<div id="p" class="easyui-panel" title="系统公告"    
				 	       style="width:800px;height:250px;background:#fafafa;"  
					 data-options="closable:true,border:false,collapsible:true,minimizable:true,maximizable:true"> 
				      <table class="easyui-datagrid" style="width:800px;height:250px"  
						        data-options="url:'${basePath}/note',fitColumns:true,singleSelect:true,
						        onmouseover:show">  
						    <thead>  
						        <tr > 
						            <th data-options="field:'title',width:150,align:'center'">标题</th>  
						            <th data-options="field:'content',width:400,align:'center'">内容</th>  
						            <th data-options="field:'author',width:100,align:'center'">作者</th>  
						             <th data-options="field:'pubTime',width:180,align:'center'">发布时间</th>  
						        </tr>  
						    </thead>  
						</table>     
				</div>
			</div>
		</div>
	</div> 
</body>
</html>
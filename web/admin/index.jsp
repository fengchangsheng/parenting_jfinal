<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html>
<html>
<!-- 
<c:if test="${adminUser eq null||adminUser eq ''}">
	<c:import url="${basePath }/admin"></c:import>
</c:if>
<c:if test="${adminUser ne null&&adminUser ne ''}">
 -->
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
			url:"${basePath}/treeMenuAction!treeJSON.action",
			data: {nodeGrade:"0",parentNode:"0"},
			async: false,
		    error: function(request) {
		        alert("菜单加载失败,请刷新页面!");
		    },
		    success: function(data) {
		    	treeJSON=data;
		    }
		});
	    $('#mytree').tree({
            data: eval(treeJSON),
            onClick: function (node) {
                if(node.url){
                	var url="${basePath}/"+node.url+"?num="+Math.random();
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
	<div data-options="region:'north',border:false" style="height:47px;background:rgb(248, 248, 248);overflow:hidden;">
		<div style="width:200px;float:left">
			<p class="brand">河马山庄</p>    
		</div>
		<div style="width:150px;float:right;">
			<p class="brand"><a href="${basePath }/admin/logOut">退出</a></p>  
		</div>	
	</div> 
	<div data-options="region:'west',split:true,title:'菜单栏'" style="width:200px;padding:10px;">
		<!-- 树形菜单 -->     
		<ul id="mytree" class="easyui-tree" data-options="animate:true"></ul>
	</div> 
	<div data-options="region:'east',split:true,collapsed:true,title:'East'" style="width:100px;padding:10px;"></div>
	<!-- 中央区域 -->
	<div data-options="region:'center'" id="mainContent">
	<!-- <iframe id="mainFrame" name="mainFrame" src="${basePath }/admin/index" width="100%" height="99%" frameborder="no" border="0" marginwidth="0" marginheight="0" scrolling="no" allowtransparency="yes"></iframe> --> 
	<div id="tabs" class="easyui-tabs" fit=true border=false data-options="" >
		<div title="欢迎页" style="padding:10px">
			<p>Home Content.</p>
		</div>
	</div>
	</div> 
</body>
<!-- 
</c:if>
 -->
</html>
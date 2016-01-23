<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${basePath}/resource/js/uploadPreview.js" type="text/javascript"></script>
<script type="text/javascript">
	 window.onload = function () { 
         new uploadPreview({ UpBtn: "up_img", DivShow: "imgdiv", ImgShow: "imgShow" });
     }
     
	function submitImageForm(){
		$("#myAddForm").form("submit",{
			success:function(data){
				var data = eval('(' + data + ')');//需要解析
				showMsgParent(data.msg);
		    	window.parent.$('#openWin').window('close');
		    	window.parent.$('#dataTable').datagrid('reload');
			}
		});
	}


	function doSub(){
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/pro/add",
			data:$('#myForm').serialize(),
			async: false,
		    error: function(request) {
		    	alert("系统错误,请刷新后重试");
		    },
		    success: function(data) {
		    	showMsgParent(data.msg);
		    	window.parent.$('#openWin').window('close');
		    	window.parent.$('#dataTable').datagrid('reload');
		    }
		});
	}
	
	function doRest(){
		document.getElementById("myForm").reset();
	}
</script>
</head>
<body>
<div id="tabs" style="overflow-y:scroll;height: 100%;" fit=true border=false data-options="" >
<form action="${basePath}/pro/add" id="myAddForm" enctype="multipart/form-data" method="post">
<input id="content" name="article.content" type="hidden">
<table width="100%">
	<tr>
		<td>
			<table width="100%" align="center" >
				<tr>
					<td width="150px" style="padding-left:10px">商品标题</td>
					<td>
						<input name="product.title" id="title" style="width:450px" class="easyui-validatebox textbox validatebox-text" />
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">促销价格</td>
					<td>
						<input name="product.price" id="author" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">促销标签</td>
					<td>
						<input name="product.saleTag" id="author" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">适用人群</td>
					<td>
						<input name="product.age" id="author" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">分类标签</td>
					<td>
						<input name="product.tag" id="author" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">介绍内容</td>
					<td>
						<textarea rows="6" cols="" style="width:450px" name="product.content"></textarea>
					</td>
				</tr>
				<tr>
				<td style="padding-left:10px">实存地址</td>
					<td>
						<input name="product.addrUrl" id="fromUrl" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
					<tr>
				<td style="padding-left:10px">实存网站</td>
					<td>
						<input name="product.addrName" id="fromUrl" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">图片来源选择</td>
					<td>
						<input type="radio"  name="product.imgFromType"  style="width:50px"  value="1" onclick="showDiv(1)"/>引用
						<input type="radio"  name="product.imgFromType"  style="width:50px"  value="2" onclick="showDiv(2)"/>上传
					</td>
				</tr>
				<tr >
						<td style="padding-left:10px">图片引用地址</td>
						<td style="display:none"  id="sel1">
							<input name="product.img" id="fromUrl" style="width:450px" class="easyui-validatebox textbox validatebox-text" value="${product.img }"/>
						</td>
				</tr>
				<tr >
					<td style="padding-left:10px" >手动上传图片:</td>
					<td >
						 <div id="imgdiv" style="width:450px">
						 	<img id="imgShow" width="100px" height="100px" src="${basePath}/imgUpload/proImg/${product.imgPath}"/>
						 </div>
					</td>
				</tr>
				<tr >
					<td></td>
					<td id="sel2" style="padding-left:10px;display: none"><input type="file" id="up_img" name="file"/></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr >
		<td>
			<div width="100%" style="margin-left: 300px">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitImageForm()">发表</a>&nbsp;&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="doRest()">重置</a>
			</div>
		</td>
	</tr>
</table>
</form>
</div>
<script type="text/javascript">
function showDiv(param){
	 if(param=="1"){
	 	$("#sel1").css('display', 'block'); //显示
	 	$("#sel2").css('display', 'none'); //隐藏
	 }else if(param=="2"){
	 	$("#sel2").css('display', 'block'); //显示
	 	$("#sel1").css('display', 'none '); //隐藏
	 }
}
</script>
</body> 
</html>
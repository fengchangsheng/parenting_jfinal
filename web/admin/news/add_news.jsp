<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>新增广告</title>
<script src="${basePath}/resource/js/uploadPreview.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/zh-cn.js"></script>
<script>
     window.onload = function () { 
          new uploadPreview({ UpBtn: "up_img", DivShow: "imgdiv", ImgShow: "imgShow" });
     }
     
	function submitImageForm(){
		$("#content").val(UE.getEditor('editor').getContent());
		$("#newsAdd").form("submit",{
			success:function(data){
				var data = eval('(' + data + ')');//需要解析
				showMsgParent(data.msg);
		    	window.parent.$('#openWin').window('close');
		    	window.parent.$('#dataTable').datagrid('reload');
			}
		});
	}
        
</script>
</head>
<body>
	<form id="newsAdd" enctype="multipart/form-data" action="${basePath}/news/add" method="post" >
		<input id="content" name="news.content" type="hidden">
	<!-- 
	<div id="tabs" class="easyui-tabs" style="height:400px;" fit=true border=false data-options="" >
	 -->
	 <div id="tabs" style="overflow-y:scroll;height: 100%;padding:10px;" fit=true border=false data-options="" >
		<!-- 
		<div title="新闻信息" style="padding:10px;height:400px;" fit=true> -->
			<table width="100%">
				<tr>
					<td height="45px" width="150px">新闻标题:</td>
					<td><input name="news.title" data-options="required:true" style="width: 300px"/></td>
				</tr>
				<tr>
					<td height="45px">新闻排序:</td>
					<td>
						<select name="news.order" style="width: 300px">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
						</select>
					</td>
				</tr>
				<tr>
					<td height="45px">所属模块:</td>
					<td>
						<input name="news.module" type="text"  data-options="required:true"/>
					</td>
				</tr>
				<tr>
					<td height="45px">是否启用:</td>
					<td>
						<input name="news.status" type="radio" value="1" checked="checked" data-options="required:true"/>启用
						<input name="news.status" type="radio" value="2" data-options="required:true"/>停用
					</td>
				</tr>
				<tr>
					<td height="45px">简要介绍:</td>
					<td>
						<textarea name="news.shortCon" rows="5" style="width: 300px"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div >
						    <script id="editor" type="text/plain" style="width:800px;height:500px;"></script>
						</div> 
					</td>
				</tr>
				<tr>
					<td height="40px" rowspan="2">新闻图片:</td>
					<td style="padding-top:20px;">
						 <div id="imgdiv"><img id="imgShow" width="300" height="100" /></div>
					</td>
				</tr>
				<tr>
					<td><input type="file" id="up_img" name="file"/></td>
				</tr>
				<tr align="center">
					<td colspan="2" height="45px">
						<button onclick="submitImageForm()" type="button">提交</button>&nbsp;&nbsp;&nbsp;&nbsp;
						<button type="reset">重置</button>
					</td>
				</tr>
			</table>	
		</div>
		
	</form>
	
	<script type="text/javascript">
    //实例化编辑器
    //建议使用工厂方法getEditor创建和引用编辑器实例，如果在某个闭包下引用该编辑器，直接调用UE.getEditor('editor')就能拿到相关的实例
    var ue = UE.getEditor('editor');

    function isFocus(e){
        alert(UE.getEditor('editor').isFocus());
        UE.dom.domUtils.preventDefault(e)
    }
    function setblur(e){
        UE.getEditor('editor').blur();
        UE.dom.domUtils.preventDefault(e)
    }
    function insertHtml() {
        var value = prompt('插入html代码', '');
        UE.getEditor('editor').execCommand('insertHtml', value)
    }
    function createEditor() {
        enableBtn();
        UE.getEditor('editor');
    }
    function getAllHtml() {
        alert(UE.getEditor('editor').getAllHtml())
    }
    function getContent() {
        var arr = [];
        arr.push("使用editor.getContent()方法可以获得编辑器的内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getContent());
        alert(arr.join("\n"));
    }
    function getPlainTxt() {
        var arr = [];
        arr.push("使用editor.getPlainTxt()方法可以获得编辑器的带格式的纯文本内容");
        arr.push("内容为：");
        arr.push(UE.getEditor('editor').getPlainTxt());
        alert(arr.join('\n'))
    }
    function setContent(isAppendTo) {
        var arr = [];
        arr.push("使用editor.setContent('欢迎使用ueditor')方法可以设置编辑器的内容");
        UE.getEditor('editor').setContent('欢迎使用ueditor', isAppendTo);
        alert(arr.join("\n"));
    }
    function setDisabled() {
        UE.getEditor('editor').setDisabled('fullscreen');
        disableBtn("enable");
    }

    function setEnabled() {
        UE.getEditor('editor').setEnabled();
        enableBtn();
    }

    function getText() {
        //当你点击按钮时编辑区域已经失去了焦点，如果直接用getText将不会得到内容，所以要在选回来，然后取得内容
        var range = UE.getEditor('editor').selection.getRange();
        range.select();
        var txt = UE.getEditor('editor').selection.getText();
        alert(txt)
    }

    function getContentTxt() {
        var arr = [];
        arr.push("使用editor.getContentTxt()方法可以获得编辑器的纯文本内容");
        arr.push("编辑器的纯文本内容为：");
        arr.push(UE.getEditor('editor').getContentTxt());
        alert(arr.join("\n"));
    }
    function hasContent() {
        var arr = [];
        arr.push("使用editor.hasContents()方法判断编辑器里是否有内容");
        arr.push("判断结果为：");
        arr.push(UE.getEditor('editor').hasContents());
        alert(arr.join("\n"));
    }
    function setFocus() {
        UE.getEditor('editor').focus();
    }
    function deleteEditor() {
        disableBtn();
        UE.getEditor('editor').destroy();
    }
    function disableBtn(str) {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            if (btn.id == str) {
                UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
            } else {
                btn.setAttribute("disabled", "true");
            }
        }
    }
    function enableBtn() {
        var div = document.getElementById('btns');
        var btns = UE.dom.domUtils.getElementsByTagName(div, "button");
        for (var i = 0, btn; btn = btns[i++];) {
            UE.dom.domUtils.removeAttributes(btn, ["disabled"]);
        }
    }

    function getLocalData () {
        alert(UE.getEditor('editor').execCommand( "getlocaldata" ));
    }

    function clearLocalData () {
        UE.getEditor('editor').execCommand( "clearlocaldata" );
        alert("已清空草稿箱")
    }

</script>
</body>
</html>
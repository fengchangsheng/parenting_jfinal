<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - Blog post</title>
<link rel="icon" type="image/png" href="/images/favicon.png" />
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/zh-cn.js"></script>
<script type="text/javascript" src="${basePath }/js/jquery.min.js"></script>
<script type="text/javascript">
	function doSub(){
		var content = UE.getEditor('editor').getContent();
		$("#content").val(content);
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/blog/add",
			data:$('#blogForm').serialize(),
			async: false,
		    error: function(request) {
		    	alert("系统错误,请刷新后重试");
		    },
		    success: function(data) {
				alert(data.msg)
				window.location="${basePath}/blog/findMy";
		    }
		});
	}
	
	function doRest(){
		document.getElementById("myForm").reset();
	}


</script>
</head>

<body>
 <%@ include file="../other/head.jsp" %>  


<!-- START WRAPPER SECTION -->
<div id="wrapper">

	<div id="separator">
		<div class="center-block">
			<h3>博客</h3>
			<span>: 写博客</span>
		</div>
	</div>

<form action="" id="blogForm">
	<input id="content" name="blog.content" type="hidden">
<table width="100%" >
	<tr>
		<td>
			<table width="100%" align="center" >
				<tr>
					<td width="150px" style="padding-left:10px">文章标题</td>
					<td>
						<input name="blog.title" id="title" style="width:450px" class="easyui-validatebox textbox validatebox-text" />
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">转载地址（可不填）</td>
					<td>
						<input name="blog.fromUrl" id="fromUrl" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">是否发布</td>
					<td>
						<input name="blog.status" type="radio" value="1" checked="checked"/> 是
						<input name="blog.status" type="radio" value="0" /> 否
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">是否置顶</td>
					<td>
						<input name="blog.isTop" type="radio" value="1"/> 是
						<input name="blog.isTop" type="radio" value="0" checked="checked"/> 否
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div >
						    <script id="editor" type="text/plain" style="width:800px;height:500px;"></script>
						</div> 
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
		<div class="divider-1px"></div>
			摘要<textarea id="answer-message" placeholder="请输入120字内的博客摘要" name="blog.abstract" style="font-size: 1em;"></textarea>
		</td>
	</tr>
	<tr>
		<td>
		<div class="divider-1px"></div>
			关键字<input type="text" name="blog.tags" placeholder="多个标签以逗号分隔">
			文章分类<select name="blog.type">
				<c:forEach items="${blogTypes }" var="type">
					<option value="${type.id }">${type.name }</option>
				</c:forEach>
			</select>
		</td>
	</tr>
	<tr >
		<td>
			<div width="100%" style="margin-left: 300px">
				<input type="button" onclick="doSub()" value="发表">&nbsp;&nbsp;&nbsp;&nbsp;
				<input type="button" onclick="doRest()" value="重置">
			</div>
		</td>
	</tr>
</table>
</form>

</div><!-- #wrapper -->

<!-- END WRAPPER -->	    

 <%@ include file="../other/foot.jsp"%>
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
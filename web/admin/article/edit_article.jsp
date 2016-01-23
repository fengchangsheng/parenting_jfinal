<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/ueditor.all.min.js"></script>
<script type="text/javascript" charset="utf-8" src="${basePath }/include/js/ueditor/zh-cn.js"></script>
<script type="text/javascript">
	function doSub(){
		$("#content").val(UE.getEditor('editor').getContent());
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/article/edit",
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
<form action="" id="myForm">
<input id="content" name="article.content" type="hidden">
<input id="id" name="article.id" type="hidden" value="${art.id }">
<table width="100%">
	<tr>
		<td>
			<div width="100%" align="right">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="doSub()">提交</a>&nbsp;
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="doRest()">重置</a>
			</div>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" align="center" >
				<tr>
					<td width="180px" style="padding-left:10px">文章标题</td>
					<td>
						<input name="article.title" id="title" value="${art.title }" style="width:450px" class="easyui-validatebox textbox validatebox-text" />
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">作者</td>
					<td>
						<input name="article.author" id="author" value="${art.author }" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">转载地址（可不填）</td>
					<td>
						<input name="article.fromUrl" id="fromUrl" value="${art.fromUrl }" style="width:450px" class="easyui-validatebox textbox validatebox-text"/>
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">是否发布</td>
					<td>
						<input name="article.status" type="radio" value="1" <c:if test='${art.status eq 1}'>checked="checked"</c:if> /> 是
						<input name="article.status" type="radio" value="0" <c:if test='${art.status eq 0}'>checked="checked"</c:if> /> 否
					</td>
				</tr>
				<tr>
					<td style="padding-left:10px">文章分类</td>
					<td>
						<select name="article.type">
							<c:forEach items="${artType }" var="type">
								<option value="${type.id }" <c:if test='${art.type eq type.id}'>selected</c:if> >${type.name }</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<div>
						    <script id="editor" type="text/plain" style="width:100%;height:500px;">${art.content}</script>
						</div>  
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
</div>

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
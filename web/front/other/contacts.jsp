<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NSParenting - contacts</title>
<script type="text/javascript">
jQuery.noConflict()(function($){
//使用jQuery的代码
	$(document).ready(function() {
		if(!Modernizr.input.placeholder){
			$("input").each(
				function(){
				if($(this).val()=="" && $(this).attr("placeholder")!=""){
				$(this).val($(this).attr("placeholder"));
				$(this).focus(function(){
				if($(this).val()==$(this).attr("placeholder")) $(this).val("");
				});
				$(this).blur(function(){
				if($(this).val()=="") $(this).val($(this).attr("placeholder"));
				});
				}
			});
		
			$("textarea").each(
				function(){
				if($(this).val()=="" && $(this).attr("placeholder")!=""){
				$(this).val($(this).attr("placeholder"));
				$(this).focus(function(){
				if($(this).val()==$(this).attr("placeholder")) $(this).val("");
				});
				$(this).blur(function(){
				if($(this).val()=="") $(this).val($(this).attr("placeholder"));
				});
				}
			});
		
		}
	});
	
	$("#subs").click(function(){
		$.ajax({
			cache: true,
			type: "POST",
			url:"${basePath}/sug/add",
			data:$('#sugForm').serialize(),
			async: false,
		    error: function(request) {
		    	alert("系统错误,请刷新后重试");
		    },
		    success: function(data) {
		    	alert(data.msg);
		    	window.location.href="${basePath}/front/other/contacts.jsp";
		    }
		});
	});
});

// 其他库使用 $ 做别名的代码
</script>

</head>

<body>
<%@ include file="../../front/other/head.jsp" %> 

<!-- START WRAPPER SECTION -->
<div id="wrapper">

	<div id="separator">
		<div class="center-block">
			<h3>联系我们</h3>
			<span>: 留下足迹</span>
		</div>
	</div>

	<!-- START CONTENT -->
	<div class="center-block clearfix" >
		<!-- LEFT CONTENT-->
		<div class="left-content" style="margin-top: -60px">
			<!-- 
			<div class="google-map img-border">
				<iframe class="border" width="667" height="350" src=""></iframe>
			</div>
			 -->
			<div class="contacts-block contacts-bg">
				<div class="contacts-bg-white">
			<h3>您有什么好的建议？</h3>
			<p>新晟亲子教育网站作为国内最大的亲子教育平台，近几年来取得不小的成就，这一切少不了您无私的帮助，如果您有什么好的建议，请提交给我们，我们有专业人士来分析，然后努力做得更好！</p>
			
            <fieldset class="info_fieldset">
            <div id="note"></div>            
            <div id="contacts-form">		
	            <form id="sugForm" >
	            	<input type="text" name="suggest.name" required placeholder="您的名字" class="required" />
	                <input type="email" name="suggest.email" required  placeholder="您的email" class="last-item required" />
	             	<input type="text" name="suggest.age" placeholder="您的年龄" />
	                <input type="text" name="suggest.subject" required placeholder="您的职位" class="last-item required" />               
	                <div class="clear"></div>
	                <textarea name="suggest.message" id="message" required placeholder="发表您的建议..."></textarea>
	                <input id="subs" type="button" class="submit no-margin-bottom"  value="提交建议" onclick="doSub()"/>
	                <span></span>
	            </form>
				<div class="clear"></div>
			</div> <!-- end #contact-form -->
			</fieldset>
		    <div class="clear"></div>
		    </div>
		    </div><!-- .comments-block -->
		</div>
		<!-- END LEFT CONTENT -->

		<!-- START SIDEBAR-->
		<div class="right-sidebar">
			<div class="widget">
				<h5>天行健，君子以自强不息。</h5><br>
				<h5>地势坤，君子以厚德载物！</h5>
			</div><!-- end .widget -->
		
		</div><!-- end .right-sidebar -->
		<div class="clear"></div>
		<!-- END SIDEBAR-->	
	</div><!-- .center-block-page -->

	<!-- END CONTENT -->
</div><!-- #wrapper -->

<!-- END WRAPPER -->	    

 <%@ include file="../../front/other/foot.jsp"%>
</body>
</html>
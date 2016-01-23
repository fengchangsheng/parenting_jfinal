<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - Seq</title>
<link rel="icon" type="image/png" href="/images/favicon.png" />
<script>
jQuery.noConflict()(function($){
    $(document).ready(function(){
		$('audio,video').mediaelementplayer();
	});
});
</script>

<script type="text/javascript">
//<![CDATA[  
jQuery.noConflict()(function($){
    $(document).ready(function(){
			$('#slides').slides({
				preload: true,
				preloadImage: '${basePath}/images/loading.gif',
   				effect: 'fade',
   				crossfade: true,				
				pause: 2500,
				hoverPause: true
			});
		});
   });   
//]]>       		
</script>

</head>

<body>

 <%@ include file="../other/head.jsp" %>  


<!-- START WRAPPER SECTION -->
<div id="wrapper">

	<div id="separator">
		<div class="center-block">
			<h3>问答</h3>
			<span>: 三人行必有我师.</span>
		</div>
	</div>
	
	<!-- START CONTENT -->
	<div class="center-block">
		<div class="left-content">
			<div id="comments-form" class="post-bg">
				<div class="post-bg-white">
					<h4>发布问题</h4>				
					<form id="form-post-answer" action="${basePath}/seq/add" onsubmit="return validate()" method="post">
						<input type="text" name="seq.title" placeholder="在这里写下你的问题标题">
						<select name="seq.typeId">
							<option value="0" >请选择一个分类</option>
							<option value="1" >孩子学习</option>
							<option value="2">生活习惯</option>
							<option value="3">情商心理</option>
						</select>
						<textarea id="seq-message" placeholder="在这里写下你的问题的详情,内容控制在10到500字之间" name="seq.content" style="font-size: 1em;"></textarea>
						<input type="submit" value="提交问题" class="submit">
						<span></span>
					</form>
				</div><!-- .post-bg-white -->
			</div><!-- #comments-form -->
		</div><!-- .left-content -->



		<div class="right-sidebar">
			<!-- SEARCH -->
			<div class="widget">
				<h5>查询</h5>
				<form method="get" id="searchform" action="#">
					<fieldset>
						<input type="text" name="s" id="s" value="输入关键字查询" onfocus="if(this.value=='输入关键字查询')this.value='';" onblur="if(this.value=='')this.value='输入关键字查询';">
					</fieldset>
				</form>
			</div><!-- end .widget -->
			
			<!-- CATEGORIES -->
			<div class="widget">
				<h5>分类</h5>
				<ul class="list play">
				<li><a href="#" title="Post With Gallery">Post With Gallery</a></li>
				<li><a href="#" title="Quote Post">Quote Post</a></li>
				<li><a href="#" title="Audio Post">Audio Post</a></li>
				<li><a href="#" title="Post With Link">Post With Link</a></li>
				<li><a href="#" title="Post With Featured Image">Post With Featured Image</a></li>
				</ul>
			</div><!-- end .widget -->

			<!-- COMMENTS -->
			<div class="widget">
				<h5>最新评论</h5>
				<ul class="list comment">
				<li>zerge on <a href="#" >Post With Gallery</a></li>
				<li>dimetrio on <a href="#">Quote Post</a></li>
				<li>ikea on <a href="#">Audio Post</a></li>
				<li>kseniya on <a href="#">Post With Link</a></li>
				<li>kolyan on <a href="#">Post With Featured Image</a></li>
				</ul>
			</div><!-- end .widget -->

			<!-- RECENT POSTS -->
			<div class="widget">
				<h5>最近发表</h5>
				<ul class="list text">
				<li><a href="#">Getting Good with Git</a></li>
				<li><a href="#">Theme Tumblr Like a Pro</a></li>
				<li><a href="#">Post with Slideshow</a></li>
				<li><a href="#">Simple Text Post</a></li>
				<li><a href="#">Corporate Motivation Audio Theme</a></li>
				</ul>
			</div><!-- end .widget -->
		
			
			<!-- ADVERTISING -->
			<div class="widget advertising">
				<h5>Advertising</h5>
				<div class="ads">
					<a href="http://www.cssmoban.com/?books/get-going-with-google-adwords" class="advertising-link"><img src="${basePath}/images/ads/google.jpg" alt=""></a>
					<a href="http://www.cssmoban.com/?books/rockstar-freelancer" class="advertising-link"><img src="${basePath}/images/ads/freelance.jpg" alt=""></a>
					<a href="http://www.cssmoban.com/?books/successful-facebook-marketing" class="advertising-link"><img src="${basePath}/images/ads/facebook.jpg" class="left margin-right-5px no-margin-bottom" alt=""></a>							
					<a href="http://www.cssmoban.com/?books/how-to-be-a-rockstar-wordpress-designer-2" class="advertising-link"><img src="${basePath}/images/ads/wordpress.jpg" class="no-margin-bottom" alt=""></a>														
				</div><!-- .ads -->
			</div><!-- end .widget -->
			
		</div><!-- end .right-sidebar -->
		<div class="clear"></div>
		<!-- END SIDEBAR-->		
		
	</div><!-- .center-block -->
<div class="clear"></div>		
	<!-- END CONTENT -->
<div class="clear"></div>	

</div><!-- #wrapper -->
<div class="clear"></div>
<!-- END WRAPPER -->	    

 <%@ include file="../other/foot.jsp"%>
<script type="text/javascript">
function validate(){
	var con = document.getElementById("seq-message").value;
	if(con==""){
		alert("请填写问题后方可提交！");
		return false;
	}
	return true;
}
</script>
</body>
</html>
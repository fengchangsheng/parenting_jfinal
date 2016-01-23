<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - Blog</title>
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
			<h3>博客</h3>
			<span>: ${blogType }.</span>
		</div>
	</div>
	
	<!-- START CONTENT -->
	<div class="center-block">
		<div class="left-content">


			<!-- POST 数据库查询 -->
		<c:forEach items="${blogs}"  var="blog">
			<div class="post-block-style1 post-bg">
				<div class="post-bg-white">
					<div class="post-meta clearfix">
						<div class="meta-arrow-up"></div>
						<div class="date">
							<h4>${blog.d}</h4>
							<h6>${blog.m}</h6>
						</div>
						<h4><a href="${basePath}/blog/detail?id=${blog.id}" class="title">${blog.title }</a></h4>
						<span class="meta-info author">作者:${blog.f_name }</span>
						<span class="meta-info comments">评论: ${blog.commentNum}</span>
						<span class="meta-info category">阅读次数: ${blog.readTimes }</span>
						<!-- 分类暂时不要
						<span class="meta-info category">分类: <a href="#">Development</a>, <a href="#">Design</a></span>
						 -->
					</div><!-- .post-meta -->
					<!-- 内容不易过多  显示部分信息${fn:substring(blog.content,0,30)}... -->
					<div class="text">
						<c:if test="${fn:length(blog.abstract)>300}">
							${fn:substring(blog.content,0,500)}...
						</c:if>
						<c:if test="${fn:length(blog.abstract)<300}">
							${blog.abstract }
						</c:if>
						<div class="go-to readmore no-margin-bottom"> 
							<a href="${basePath}/blog/detail?id=${blog.id}">Read more</a>
							<span></span>
						</div><!-- .go-to -->
					</div><!-- .text -->
				</div><!-- .post-bg-white -->
			</div><!-- .post-block-style1 -->
		</c:forEach>
			<!-- END POST #2 -->

			

			<!-- START PAGINATION-->
			<div id="nav-pagination">
				<ul class="nav-pagination clearfix">
	   	    	 	<li class="first"><a href="${basePath}/blog?typeId=${typeId}&page=1"></a></li>
	   	    	 	<%
	   	    	 	  int totalPage = (Integer)request.getAttribute("totalPage");
	   	    	 	  for(int i=1;i<=totalPage;i++){
	   	    	 	  	
	   	    	 	 %>
	   	    	 	 <li><a href="${basePath}/blog?typeId=${typeId}&page=<%=i %>"><%=i %></a></li>
	   	    	 	 <%} %>
	   	    	 	 <!-- 
	   	    	 	<li><a href="#">1</a></li>
	   	    	 	<li class="current"><a href="#">2</a></li>
	   	    	 	<li><a href="#">3</a></li>
					<li class="dots">...</li>
	   	    	 	<li><a href="#">20</a></li>
	   	    	 	<li><a href="#">21</a></li>
	   	    	 	<li><a href="#">22</a></li>
	   	    	 	 -->
	   	    	 	<li class="last"><a href="${basePath}/blog?typeId=${typeId}&page=${totalPage}"></a></li>
	   	    	 </ul>
			</div>
			<!-- END PAGINATION-->	
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

			<!-- 分类 
			<div class="widget">
				<h5>分类</h5>
				<ul class="list play">
				<li><a href="#" title="Post With Gallery">Post With Gallery</a></li>
				<li><a href="#" title="Quote Post">Quote Post</a></li>
				<li><a href="#" title="Audio Post">Audio Post</a></li>
				<li><a href="#" title="Post With Link">Post With Link</a></li>
				<li><a href="#" title="Post With Featured Image">Post With Featured Image</a></li>
				</ul>
			</div>
			-->

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

</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fcs.util.WebUtils"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - BlogDetail</title>

<script type="text/javascript">
jQuery.noConflict()(function($){
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
});
</script>

</head>

<body>
<%@ include file="../other/head.jsp" %>  


<!-- START WRAPPER SECTION -->
<div id="wrapper">

	<div id="separator">
		<div class="center-block">
			<h3>博客</h3>
			<span>: 博客详情.</span>
		</div>
	</div>
	
	<div class="left-sidebar">
			<!-- SEARCH -->
			<div class="widget">
				<h5>个人资料</h5>
				<img alt="莫言" src="${basePath }/imgUpload/userImg/${user.f_img}" height="182px" width="182px">
				<div >
					<div align="center" style="margin-top: 20px"><span style="color: red;font-size: 1.5em">${user.f_name }</span></div>				
					<div>博客等级：${user.f_blog_level}</div>
					<div>博客积分：${user.f_blog_score}</div>
					<div>博客访问：50,000</div>
				</div>
			</div><!-- end .widget -->

			<!-- CATEGORIES -->
			<div class="widget">
				<h5>Categories</h5>
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
				<h5>最近评论</h5>
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
				<h5>最新发表</h5>
				<ul class="list text">
				<li><a href="#">Getting Good with Git</a></li>
				<li><a href="#">Theme Tumblr Like a Pro</a></li>
				<li><a href="#">Post with Slideshow</a></li>
				<li><a href="#">Simple Text Post</a></li>
				<li><a href="#">Corporate Motivation Audio Theme</a></li>
				</ul>
			</div><!-- end .widget -->
		

			<!-- ADVERTISING -->
		<c:if test="${!empty adsList}">
			<div class="widget advertising">
				<h5>广告</h5>
				<div class="ads">
					<c:forEach items="${adsList}"  var="ads">
						<a href="${ads.url}" class="advertising-link"><img src="${basePath}/imgUpload/adsImg/${ads.imgPath}" alt="${ads.shortDes }" style="height: 150px;width: 210px"></a>
					</c:forEach>
				<!--  
					<a href="http://www.cssmoban.com/?books/rockstar-freelancer" class="advertising-link"><img src="images/ads/freelance.jpg" alt=""></a>
					<a href="http://www.cssmoban.com/?books/successful-facebook-marketing" class="advertising-link"><img src="images/ads/facebook.jpg" class="left margin-right-5px no-margin-bottom" alt=""></a>							
					<a href="http://www.cssmoban.com/?books/how-to-be-a-rockstar-wordpress-designer-2" class="advertising-link"><img src="images/ads/wordpress.jpg" class="no-margin-bottom" alt=""></a>														
				-->
				</div><!-- .ads -->
			</div><!-- end .widget -->
		</c:if>
		
		</div><!-- end .right-sidebar -->
	
	<!-- START CONTENT -->
	<div class="center-block">
		<div class="right-content">

			<!-- SINGLE POST BLOCK -->
			<div class="single-post-block post-bg">
				<div class="post-bg-white">
					<div class="post-meta clearfix" style="padding: 20px;" >
						<h4><a href="#" class="title">${blog.title}</a></h4>
						<span class="meta-info author">作者: ${user.f_name }</span>
						<span class="meta-info comments">评论: ${blog.commentNum }</span>
						<span class="meta-info category">类别: <a href="#">经验分享</a></span>
					</div><!-- .post-meta -->
					<div class="text">
						${blog.content }
					</div><!-- .text -->
					<div class="post-meta-tag">
						<span class="tags">标签: <a href="#">${blog.tags }</a></span>
						<!-- AddThis Button BEGIN -->
						<div class="addthis_toolbox addthis_default_style ">
						    <a class="addthis_button_facebook"></a>
							<a class="addthis_button_twitter"></a>
						    <a class="addthis_button_google_plusone"></a>    
						</div>
						<script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#pubid=ra-4d8f199d3537a1b7"></script>
						<!-- AddThis Button END -->
					</div><!-- .post-meta-tag -->
				</div><!-- .post-bg-white -->
			</div><!-- .single-post-block -->
			<!-- END SINGLE POST BLOCK -->	
			
			<!-- 广告部分已删除 -->			
			


			<!-- COMMENTS BLOCK -->
			<div class="comments-block post-bg">
				<div class="post-bg-white">
					<h4>评论</h4>

					<!-- FIRST LEVEL COMMENT-->
					 
				<c:set var="id" value="-1"></c:set>
				<c:forEach items="${commentList}"  var="comment">
					<c:if test="${comment.parentId eq 0}">
						<div class="comment-block">
							<div class="gravatar">
								<a href="#"><img src="${basePath }/imgUpload/userImg/${comment.f_img}" alt="${comment.f_name }" title="${comment.f_name }" height="40px"></a>
					        </div><!-- .gravatar -->
							<div class="comment-text clearfix">
								<span class="comment-info">
									<span class="italic" title="">${comment.f_name} 发表于${comment.pubTime}</span>
								</span>
								<p class="comment">
					        		${comment.content }
					        	</p>
								<a href="#" class="replay">回复</a>
							</div><!-- end comment-text -->
						</div><!-- end comment-block -->	
					</c:if>
					
					
					<c:if test="${comment.parentId eq id}">
						<div class="replay-block">
							<div class="gravatar">
								<a href="#"><img src="${basePath }/imgUpload/userImg/${comment.f_img}" alt="${comment.f_name }" title="${comment.f_name }" height="40px"></a>
					        </div><!-- .gravatar -->
							<div class="comment-text clearfix">
								<span class="comment-info" title="January 6, 2011 at 9:14 PM">
									<span class="italic">${comment.f_name} 发表于${comment.pubTime }</span>
								</span>
								<p class="comment">
									${comment.content }
					        	</p>
					        	<a href="#" class="replay">回复</a>
							</div><!-- end comment-text -->
						</div><!-- .replay-block -->
					</c:if>	
					<c:set var="id" value="${comment.id }"></c:set>			
				</c:forEach>

				</div><!-- .post-bg-white -->
			</div><!-- .comments-block -->
			<!-- END COMMENTS BLOCK -->	

           <% 
			  if(user == null){
			%>
           <div id="comments-form" class="post-bg">
			 		登陆后方可评论，请<a href="${basePath}/login?appid={blog/detail?id=${blog.id}}">登录</a>
			</div>
			 <%}else{ %>
				<!-- COMMENTS FORM 登陆后方可显示-->
				<div id="comments-form" class="post-bg">
					<div class="post-bg-white">
						<h4>发表你的评论</h4>				
						<form id="form-post-comment" action="${basePath}/blog/comment" onsubmit="return validate()" method="post">
							<input type="hidden" name="blogId" value="${blog.id}">
							<textarea id="comment-message" placeholder="在这里写下你的评论" name="comComment"></textarea>
							<input type="submit" value="提交评论" class="submit">
							<span></span>
						</form>
					</div><!-- .post-bg-white -->
				</div><!-- #comments-form -->
			<%} %>
			<!-- END COMMENTS FORM -->
		</div><!-- .left-content -->

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
	var con = document.getElementById("comment-message").value;
	if(con==""){
		alert("请填写评论后方可提交！");
		return false;
	}
	return true;
}

</script>
</body>
</html>
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
		
		
		<div class="comments-block post-bg">
				<div class="post-bg-white">
					<h4>问题:${seq.title}</h4>

					<!--问题-->
				<div class="comment-block">
							<div class="gravatar">
								<a href="#"><img src="${basePath }/imgUpload/userImg/${user.f_img}" alt="${user.f_name }" title="${user.f_name }" height="40px"></a>
					        </div><!-- .gravatar -->
							<div class="comment-text clearfix">
								<span class="comment-info">
									<span class="italic" title="">${user.f_name} 提问于<fmt:formatDate value="${seq.pubTime}" type="both"/></span>
								</span>
								<p class="comment">
					        		${seq.content }
					        	</p>
							</div><!-- end comment-text -->
				</div><!-- end comment-block -->		 
					 
					 <!-- 回答 -->
				<c:forEach items="${answerList}"  var="answer">
						<div class="replay-block">
							<div class="gravatar">
								<a href="#"><img src="${basePath }/imgUpload/userImg/${answer.f_img}" alt="${answer.f_name }" title="${comment.f_name }" height="40px"></a>
					        </div><!-- .gravatar -->
							<div class="comment-text clearfix">
								<span class="comment-info" title="January 6, 2011 at 9:14 PM">
									<span class="italic">${answer.f_name} 回答于<fmt:formatDate value="${answer.pubTime}" type="both"/></span>
								</span>
								<p class="comment">
									${answer.content }
					        	</p>
							</div><!-- end comment-text -->
						</div><!-- .replay-block -->
				</c:forEach>

				</div><!-- .post-bg-white -->
			</div><!-- .comments-block -->


			 <% 
			  if(user == null){
			%>
           <div id="comments-form" class="post-bg">
			 		登陆后方可回答，请<a href="${basePath}/login?appid={seq/detail?id=${seq.id}}">登录</a>
			</div>
			 <%}else{ %>
				<!-- COMMENTS FORM 登陆后方可显示-->
				<div id="comments-form" class="post-bg">
					<div class="post-bg-white">
						<h4>参与回答</h4>				
						<form id="form-post-answer" action="${basePath}/seq/answer" onsubmit="return validate()" method="post">
							<input type="hidden" name="answer.seqId" value="${seq.id}">
							<textarea id="answer-message" placeholder="在这里写下你的回答,内容控制在10到500字之间" name="answer.content" style="font-size: 1em;"></textarea>
							<input type="submit" value="提交回答" class="submit">
							<span></span>
						</form>
					</div><!-- .post-bg-white -->
				</div><!-- #comments-form -->
			<%} %>
			


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
	var con = document.getElementById("answer-message").value;
	if(con==""){
		alert("请填写回答后方可提交！");
		return false;
	}
	return true;
}
</script>
</body>
</html>
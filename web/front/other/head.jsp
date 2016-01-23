<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.fcs.core.model.User"%>
<%@page import="com.fcs.util.WebUtils"%>

<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - head</title>
<style type="text/css">
.loginbar{
	float: left;
	margin-top:10px 
}
</style>

</head>

<body>
<!-- START MENU SECTION -->
<div id="top-line"></div>
	
<div id="menu-bar">
	<div class="center-block clearfix">
		<div class="loginbar">
			<% User user = (User)request.getSession().getAttribute(WebUtils.ADMIN_USER); 
			  if(user == null){
			%>
				<span style="color: red;">您还未登陆!</span>&nbsp;&nbsp;&nbsp;|
				<a href="${basePath}/login.jsp">登陆</a>&nbsp;&nbsp;&nbsp;|
				<a href="${basePath}/register.jsp">注册</a>
			
			<%
				}else{
				
			%>
			欢迎您,<%=user.getStr("f_name") %>
			<a href="${basePath}/logOut">退出登录</a>
			<%
			}
			%>
		</div>
		
    	<!-- start menu -->
		<div id="menu" class="fix-fish-menu">
			<div class="white-fix-left"></div>
			<ul id="nav" class="sf-menu">
				<li><a href="${basePath}" class="active">首页</a></li>
			 		<li class=""> <a href="${basePath}/article/classify">教育</a>
					<ul>
						<li><a href="${basePath}/article/classify?typeId=1">胎教</a></li>
						<li><a href="${basePath}/article/classify?typeId=2">早教</a></li>
						<li><a href="${basePath}/article/classify?typeId=3">幼儿园</a></li>
						<li><a href="${basePath}/article/classify?typeId=4">家庭教育</a></li>
						<li><a href="${basePath}/article/classify?typeId=5">素质教育</a></li>
						<li><a href="${basePath}/article/classify?typeId=6">心理行为</a></li>
					</ul>
			    </li>
		 		<li class=""> <a href="${basePath}/blog">博客</a>
					<ul>
						<li><a href="${basePath}/blog?typeId=1">经验分享</a></li>
						<li><a href="${basePath}/blog?typeId=2">问题求助</a></li>
						<li><a href="${basePath}/blog?typeId=0">热门文章</a></li>
						<li><a href="${basePath}/blog/findMy">我的博客</a></li>
						</ul>
				    </li>
			 	<li class=""> <a href="${basePath}/pro">聚生活</a>
					<ul>
						<li><a href="${basePath}/pro?type=1">书籍</a></li>
						<li><a href="${basePath}/pro?type=2">营养</a></li>
						<li><a href="${basePath}/pro?type=3">玩具</a></li>
						<li><a href="${basePath}/pro?type=4">宝宝用品</a></li>
					</ul>
				</li>
		 		<li class=""> <a href="${basePath}/seq">问答</a>
					<ul>
						<li><a href="${basePath}/seq?type=1">孩子学习</a></li>
						<li><a href="${basePath}/seq?type=2">生活习惯</a></li>
						<li><a href="${basePath}/seq?type=3">情商心理</a></li>
					</ul>
			    </li>
			    <!-- 
                <li class=""><a href="#">评测</a>
	   				<ul>
						<li><a href="blog-style1.html">生活用品</a></li>
						<li><a href="blog-style2.html">妈妈用品</a></li>
						<li><a href="blog-post.html">宝宝用品</a></li>
					</ul>
	            </li>
	             -->
	            <%
	            if(user!=null){
	             %>
              	 <li class=""><a href="${basePath}/userCon/me">个人中心</a>
	            </li>
	            <%} %>
 				<li><a href="${basePath}/front/other/contacts.jsp">联系我们</a></li>
		 	</ul>  <!-- end #nav  -->
	 	</div>	<!-- end #menu  -->	
	</div><!-- end .center-block  -->	
</div><!-- end #menu-bar -->
<!-- END MENU SECTION -->


<!-- START LOGO SECTION -->
<div id="logo-bar">
	<div class="center-block clearfix">
		<div class="logo"><img src="${basePath}/images/mylogo.png" alt="Logo" /></div>
		<div class="ads"><a href="http://www.cssmoban.com/?books/freelance-confidential"><img src="${basePath}/images/468x60.png" title="Advertisement" alt="Ads" /></a></div>
	</div><!-- .center-block -->
</div><!-- #logo-bar -->
<!-- END LOGO SECTION -->



</body>
</html>
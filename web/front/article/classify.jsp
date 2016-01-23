<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=UTF-8" http-equiv="Content-Type" />
<title>NsParenting - Classify</title>
</head>

<body>
 <%@ include file="../other/head.jsp" %>  


<!-- START WRAPPER SECTION -->
<div id="wrapper">

	<div id="separator">
		<div class="center-block">
			<h3>亲子教育</h3>
			<span>: 分类</span>
		</div>
	</div>

	<!-- START CONTENT -->
	<div class="center-block clearfix">
	
<!-- START SIDEBAR-->
		<div class="left-sidebar">
			<!-- SEARCH -->
			<div class="widget">
				<h5>查找</h5>
				<form method="Post" id="searchform" action="${basePath}/article/search">
					<fieldset>
						<input type="text" name="sname" value="输入关键字" onfocus="if(this.value=='输入关键字')this.value='';" onblur="if(this.value=='')this.value='输入关键字';">
						<input type="hidden" name="typeId" value="${typeId}"/>
						<input type="submit" value="查询" style="margin-left: 90px">
					</fieldset>
				</form>
			</div><!-- end .widget -->

			<!-- CATEGORIES -->
			<div class="widget">
				<h5>分类</h5>
				<ul class="list play">
					<li><a href="${basePath}/article/classify?typeId=1">胎教</a></li>
					<li><a href="${basePath}/article/classify?typeId=2">早教</a></li>
					<li><a href="${basePath}/article/classify?typeId=3">幼儿园</a></li>
					<li><a href="${basePath}/article/classify?typeId=4">家庭教育</a></li>
					<li><a href="${basePath}/article/classify?typeId=5">素质教育</a></li>
					<li><a href="${basePath}/article/classify?typeId=6">心理行为</a></li>
				</ul>
			</div><!-- end .widget -->

			<!-- RECENT POSTS -->
			<div class="widget">
				<h5>最新发表</h5>
				<ul class="list text">
					<c:forEach items="${newArtList}" var="newArt" >
						<li><a href="${basePath}/article/detail?id=${newArt.id}">${newArt.title }</a></li>
					</c:forEach>
				</ul>
			</div><!-- end .widget -->
		
		</div><!-- end .right-sidebar -->
				<!-- END SIDEBAR-->	
				
				
<!-- 文章列表 -->		
<!-- START CONTENT -->
	<div class="right-content">
		<div style="float: left;width: 350px;">
			<ul class="list">
				<c:forEach items="${artList}" var="art" begin="0" varStatus="status">
					<c:if test="${status.index%5==0&&status.index!=0&&status.index%10!=0}">
						</ul></div><div style="margin-left: 350px"><ul class="list">
						<li><a href="${basePath}/article/detail?id=${art.id}" title="${art.title}">${art.title}</a></li>
					</c:if>
					
					<c:if test="${status.index%10==0&&status.index!=0}">
						</ul></div><div class="divider-1px"></div><div style="float: left;width: 350px;"><ul class="list">
						<li><a href="${basePath}/article/detail?id=${art.id}" title="${art.title}">${art.title}</a></li>
					</c:if>  
					
					<c:if test="${status.index%5!=0||status.index==0}">
						<li><a href="${basePath}/article/detail?id=${art.id}" title="${art.title}">${art.title}</a></li>
					</c:if>	
				</c:forEach>
			</ul>
		</div>
		
	</div><!-- .center-block-page -->

	<!-- END CONTENT -->
</div><!-- #wrapper -->

<!-- END WRAPPER -->	    


 <%@ include file="../other/foot.jsp"%>

</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - myBlog</title>
<link rel="icon" type="image/png" href="/images/favicon.png" />
<link rel="stylesheet" type="text/css" href="${basePath }/css/blog.css" >

</head>

<body>
 <%@ include file="../other/head.jsp" %>  


<!-- START WRAPPER SECTION -->
<div id="wrapper">

	<div id="separator">
		<div class="center-block">
			<h3>博客</h3>
			<span>: 我的博客</span>
		</div>
	</div>
	
	<!-- START CONTENT -->
	<div class="center-block-page clearfix">
		   <div class="tabs_header">
            <ul id="ul_tab" class="tabs">
                <li><a href="#" style="color: gray;"><span>已发表</span></a></li>
                <!--  <li><a href="/category"><span>类别管理</span></a></li>
                <li><a href="/feedback"><span>评论管理</span></a></li>
                -->
                <li><a href="drafts"><span>草稿箱</span></a></li>
                <li><a href="deleted"><span>回收站</span></a></li>
            </ul>
        </div>
	
	
		<div style="float: right;margin-right: 50px">
		    <input type="button" value="写新文章" style="color: red;" onclick="window.location.href='${basePath}/blog/post';">
		</div>
		<div id="sel_div" class="h_status">
		类别：<select id="selCat"><option value="0">全部&nbsp;&nbsp;&nbsp;&nbsp;</option><option value='2451603'>乱码 (1)</option><option value='2465951'>Ajax (3)</option><option value='2548875'>hibernate (2)</option><option value='2551187'>JavaSE (4)</option><option value='2561353'>服务器 (1)</option><option value='2615951'>数据库 (1)</option><option value='2616393'>算法 (1)</option><option value='2662073'>版本控制 (1)</option><option value='2748917'>NoSQL (1)</option><option value='2769151'>设计模式 (2)</option><option value='2797893'>杂谈 (0)</option><option value='2798311'>问题与解决 (1)</option><option value='2820933'>ExtJS (5)</option><option value='2820939'>Spring (0)</option><option value='2867923'>Android (0)</option><option value='2867927'>HTML5+ (1)</option><option value='2930735'>Web (1)</option></select>
		类型：<select id="selType"><option value="all">全部&nbsp;&nbsp;&nbsp;&nbsp;</option><option value="original">原创</option><option value="repost">转载</option><option value="translated">翻译</option></select>&nbsp;
		</div>
		
		
		<table id="lstBox" cellspacing="0">
			<tr><th class="tdleft">标题</th><th style="width:50px;">状态</th><th style="width:50px;">阅读</th><th style="width:50px;">评论</th><th style="width:70px;">评论权限</th><th style="width:170px;">操作</th></tr>
			<c:forEach items="${myBlogs}"  var="blog" varStatus="i">
			    <c:if test="${i.index%2!=0}">
					<tr>
					     <td class='tdleft'><a href='${basePath}/blog/detail?id=${blog.id}' target=_blank>${blog.title }</a><span class='gray'>（<fmt:formatDate value="${blog.pubTime}" type="both"/>）</span></td>
					     <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td><td>${blog.readTimes }</td>
					     <td>${blog.commentNum }</td>
					     <td><a href='?t=lock&id=44219815' class='lock'>禁止评论</a></td>
					     <td><a href='toEdit?id=${blog.id}'>编辑</a> | <a href='?t=top&id=44219815'>置顶</a> | <a href='recycle?id=${blog.id}' name=del>删除</a> </td>
					 </tr>
			    </c:if>
			     <c:if test="${i.index%2==0}">
					 <tr class='altitem'>
					     <td class='tdleft'><a href='${basePath}/blog/detail?id=${blog.id}' target=_blank>${blog.title }</a><span class='gray'>（<fmt:formatDate value="${blog.pubTime}" type="both"/>）</span></td>
					     <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
					     <td>${blog.readTimes }</td>
					     <td>${blog.commentNum }</td>
					     <td><a href='?t=lock&id=43758895' class='lock'>禁止评论</a></td>
					     <td><a href='toEdit?id=${blog.id}'>编辑</a> | <a href='?t=top&id=43758895'>置顶</a> | <a href='recycle?id=${blog.id}' name=del>删除</a> </td></tr>
					 <tr>
				 </c:if>
			</c:forEach>
		</table>
		
		<div class="page_nav">
			<span> ${total}条数据  共${totalPage }页</span>
			<c:if test="${current>1}">
			<a href="${basePath}/blog/findMy?page=1">首页</a>
			<a href="${basePath}/blog/findMy?page=${current-1}">上一页</a> 
			</c:if>
			<strong>${current}</strong> 
			<c:if test="${current<totalPage}">
			<a href="${basePath}/blog/findMy?page=${current+1}">下一页</a> 
			<a href="${basePath}/blog/findMy?page=${totalPage}">尾页</a> 
			</c:if>
		</div>
		
		<div id="setcat_div" style="display:none;">
		    <div class="frame">
		          <input name="close" type="button" class="close" onclick="cancel_cat()">
		        <div id="setcat_box"></div>
		        <p style="text-align:center;">
		            <input type="button" value="确定" class="btn_01" onclick="save_cat()" />
		        </p>
		    </div>
		</div>
		
		<div class="clear"></div>
	</div><!-- .center-block-page -->

	<!-- END CONTENT -->
</div><!-- #wrapper -->

<!-- END WRAPPER -->	    

 <%@ include file="../other/foot.jsp"%>

</body>
</html>
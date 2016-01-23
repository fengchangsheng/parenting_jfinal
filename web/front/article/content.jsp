<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - Classify</title>
<style type="text/css">
.artInfo{
	margin-bottom: 30px;
}
#artibodyTitle{
    font-size: 2em;
    font-weight: bold;
    text-align: center;
}
.img_wrapper{
	margin-bottom: 10px;
}
.img_inner{
	height:60%;
}
.img_descr{
	margin-top:10px;
	text-align: center;

}
</style>
</head>

<body>
 <%@ include file="../other/head.jsp" %>  
<!-- START WRAPPER SECTION -->
<div id="wrapper">
	<div id="separator">
		<div class="center-block">
			<h3>亲子教育</h3>
			<span>: 文章</span>
		</div>
	</div>

	<!-- START CONTENT -->
	<div class="center-block clearfix">
		<div class="left-content">
<!-- copy start -->	
		 <div class="">
				<h1 id="artibodyTitle">${article.title }</h1>
				<div class="artInfo" align="center">
					<span id="art_source"><a <c:if test="${not empty article.fromUrl}">href="${article.fromUrl}" </c:if> >${article.fromUrl }</a></span>&nbsp;&nbsp;
					<span id="pub_date"></span>&nbsp;&nbsp;
					<span id="media_name"><span class="linkRed02">${article.author}</span>&nbsp;</a></span>
				</div>

				<!-- 正文内容 begin -->
				<!-- google_ad_section_start -->
				<div class="blkContainerSblkCon" id="artibody">
					<c:if test="${!empty article.imgUrl}">
							<div align="center" class="img_wrapper">
							    <img alt="${article.imgDes }" src="${article.imgUrl }" title="${article.imgDes }" class="img_inner" />
							     <span class="img_descr" >${article.imgDes }</span>
							</div>
					</c:if>


			<!--显示正文 BEGIN-->
					${article.content }
			<!--显示正文 END-->

<!-- publish_helper_end -->


<div class="divider-1px"></div>
                                        	<div style="overflow:hidden;zoom:1;" class="otherContent_01">
<!-- 相关阅读 begin -->
	<style type="text/css">
		.corrTxt_01{border-top:1px dashed #F0C8C8;margin-top:10px;}
		.corrTxt_01 h3{font-weight:bold;padding:5px 0 0 3px;line-height:25px;margin:0;}
		.corrTxt_01 ul{padding:0 0 0 18px;}
		.corrTxt_01 ul li{font-size:14px;line-height:164.28%;}
		.corrTxt_01 a {text-decoration:none;}
	</style>
		<div class="corrTxt_01">
			<h3>> 相关阅读：</h3>
			<ul>
				<li><a href=http://baby.sina.com.cn/health/09/1108/1219143651.shtml target=_blank>应该如何选择胎教音乐？</a></li><li><a href=http://baby.sina.com.cn/health/09/0408/1319143161.shtml target=_blank>抚摸胎教：最简单有效的方法</a></li><li><a href=http://baby.sina.com.cn/health/09/0308/0843143056.shtml target=_blank>准爸妈如何共同进行胎教</a></li><li><a href=http://baby.sina.com.cn/health/taijiao.shtml target=_blank>如何给宝宝做胎教？</a></li><li><a href=http://baby.sina.com.cn/health/09/1707/1312141980.shtml target=_blank>胎教推荐：胎儿喜欢阅读的书</a></li><li><a href=http://baby.sina.com.cn/health/09/1607/1044141882.shtml target=_blank>情绪胎教可决定宝宝智力</a></li>
			</ul>
		</div>
<!-- 相关阅读 end -->
	</div>

		 <p><font class=title12><b></b></font></p><br>
			   <p>　　<a href="http://baby.sina.com.cn/wap/" target="_blank"><img width="18" height="36" src="http://i0.sinaimg.cn/ent/deco/2009/0507/entphone.gif" style="border-width: 0px;"></a>
<a href="http://baby.sina.com.cn/wap/" target="_blank" style="font-size: 13px;"><font color="red">了解育儿知识，看育儿博文和论坛，上手机新浪网亲子频道 baby.sina.cn</font></a></p>
				</div>
				<!-- google_ad_section_end -->
				<!-- 正文内容 end -->

			</div>
<!-- copy end -->	


		
    <div class="clear"></div>    
</div><!-- left-content -->				
				
<!-- START SIDEBAR-->
		<div class="right-sidebar">
			<!-- SEARCH -->
			<div class="widget">
				<h5>Search</h5>
				<form method="get" id="searchform" action="http://html.color-theme.com/linkup">
					<fieldset>
						<input type="text" name="s" id="s" value="To search type and hit enter" onfocus="if(this.value=='To search type and hit enter')this.value='';" onblur="if(this.value=='')this.value='To search type and hit enter';">
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
		
		</div><!-- end .right-sidebar -->
				<div class="clear"></div>				
				<!-- END SIDEBAR-->				

	
	</div><!-- .center-block-page -->

	<!-- END CONTENT -->
</div><!-- #wrapper -->

<!-- END WRAPPER -->	    

 <%@ include file="../other/foot.jsp"%>

</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    <title>NsParenting - index</title>
	<link rel="icon" type="image/png" href="images/favicon.png" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style type="text/css">
	.shortDes{
		color: rgb(153, 153, 153);
		font-family: 微软雅黑;
		font-size: 12px; 
		line-height: 24px; 
		background-color: rgb(255, 255, 255);
	}
	
	</style>
	<script type="text/javascript" src="js/jquery.slidorion.min.js"></script>
	<script type="text/javascript" src="js/jquery.hoverdir.js"></script>
	<script type="text/javascript" src="js/custom-main.js"></script><!-- Only for home page -->
	<script type="text/javascript">
	/***************************************************
				Slidorion Slider
	***************************************************/
	jQuery.noConflict()(function($){
	
		$(document).ready(function() {//hoverdir
			$(function() {
				$('#da-stage > li').hoverdir();
			});
		});
	
		$('#slidorion').slidorion({
				effect: 'fade',
				autoPlay: true,
				hoverPause: true,
				interval: 5000,
				speed: 800
			});
		});
	</script>
  </head>
  
<body>

 <%@ include file="../front/other/head.jsp" %>  

	<!-- START SLIDER -->
<div id="slider-wrapper">
	<!-- END CTA BLOCK -->
		<div id="slidorion">
			<div id="slider">
				<c:forEach items="${newsList}" var="news" varStatus="s">
					<div id="slide${s.count }" class="slide">
						<img src="${basePath}/imgUpload/newsImg/${news.imgPath}" />
					</div>
				</c:forEach>
			
			</div><!-- #slider -->
		

			<div id="accordion-slidorion">
			<c:forEach items="${newsList}" var="news">
				<div class="link-header">${news.module }</div>
				<div class="link-content">
					<p> <strong><a href="${news.link }">${news.title }</a></strong></p>
					<p><span class="shortDes">
						${news.shortCon }
					</span></p>
				</div>
			</c:forEach>
			</div><!-- #accordion -->
		</div><!-- #slidorion -->
</div><!-- end slider-wrapper -->
<!-- END SLIDER -->



<!-- 正文-->
<div id="wrapper-home">

	<!-- START ABOUT BLOCK -->
	<div id="about-main">
		<div class="center-block clearfix">
			<div class="about-us">
				<h4>关于我们</h4>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;我们是一群富有朝气的年轻人，从小体验不同的家庭教育。我们看到很多优秀的人都少不了出色的家庭教育，因此希望你我撑起一片属于父母的天空，推行所谓的亲子教育，让孩子的明天更美好！</p>
				<div class="about-img">
					<div class="about-bg-white">
						<img src="resource/img/myImg/shouye.jpg" alt="" />
					</div><!-- .about-bg-white -->
				</div><!-- .about-img -->
				<p class="small-italic" style="font-size: 1em">再看看亲子教育.
				<br/><br/>传播亲子教育的理念，是我们的使命.</p>
				<div class="go-to readmore no-margin-bottom"> 
					<a href="${basePath}/front/other/introduce.jsp">查看什么是亲子教育</a>
					<span></span>
				</div><!-- .go-to -->
			</div><!-- .about-us -->
			
			<!-- 问答   显示最新或者最火的8个 -->
			<div class="our-services">
				<h4>问答</h4>
				<p>教育过程中所遇到的问题,在这里有教育界的大师给您满意的解答.</p>
				<c:forEach items="${seqs}" var="seq" varStatus="s">
					<c:if test="${s.index%2!=0}">
						<div class="one_half">
							<img class="servise_icon" src="images/icons/s1.png" alt="" />
							<h8><a href="${basePath}/seq/detail?id=${seq.id}">${seq.title }</a></h8>
						</div>
					</c:if>
					<c:if test="${s.index%2==0}">
						<div class="one_half column-last">
							<img class="servise_icon" src="images/icons/s2.png" alt="" />
							<h8><a href="${basePath}/seq/detail?id=${seq.id}">${seq.title }</a></h8>
						</div>
					</c:if>
				</c:forEach>
			</div><!-- .our-services -->
		</div><!-- .center-block -->
	</div><!-- #about-us -->
	<!-- END ABOUT BLOCK -->

	<div class="divider-2px"></div>
	
	<!-- START 教育分类板块 -->
	<div class="center-block-page">
	<h4>亲子教育</h4>
        	<ul id="da-stage" class="da-thumbs clearfix">
		    	<!-- Item #1 -->
	            <li>
					<a href="${basePath}/article/classify?typeId=1">
						<img src="resource/img/teach/ss1.jpg" alt="" />
						<div><span>胎教</span></div>
					</a>
				</li>

		    	<!-- Item #2 -->
	            <li>
					<a href="${basePath}/article/classify?typeId=2">
						<img src="resource/img/teach/ss2.jpg" alt="" />
						<div><span>早教</span></div>
					</a>
				</li>

		    	<!-- Item #3 -->
	            <li>
					<a href="${basePath}/article/classify?typeId=3">
						<img src="resource/img/teach/ss3.jpg" alt="" />
						<div><span>幼儿园</span></div>
					</a>
				</li>

		    	<!-- Item #4 -->
	            <li>
					<a href="${basePath}/article/classify?typeId=4">
						<img src="resource/img/teach/ss4.jpg" alt="" />
						<div><span>家庭教育</span></div>
					</a>
				</li>

		    	<!-- Item #5 -->
	            <li>
					<a href="${basePath}/article/classify?typeId=5">
						<img src="resource/img/teach/ss5.jpg" alt="" />
						<div><span>素质教育</span></div>
					</a>
				</li>

		    	<!-- Item #6 -->
	            <li>
					<a href="${basePath}/article/classify?typeId=6">
						<img src="resource/img/teach/ss6.jpg" alt="" />
						<div><span>心理行为</span></div>
					</a>
				</li>

			</ul><!-- #stage -->
	</div><!-- .center-block -->
	<!-- END 教育分类 -->

	<div class="divider-2px"></div>
	
	<!-- 博客和优惠 -->
	<div id="recent-projects">
		<div class="center-block">

			<!-- start 博客 -->		
			<div class="rp-block-main">
				<h4>博客</h4>
				<p style="float: left;">来自民间的教育大师</p>
				<div class="go-to" style="float: right;margin-right: 200px">
					<a href="${basePath}/blog?typeId=1">更多博客</a>
					<span></span>
				</div> 
			<!-- 多于两个则可以滑动显示 -->
			<div class="projects_carousel">
			    <div id="rp-carousel">
					<!-- start recent project block -->
					<div class="rp-block rp-bg">
						<div class="rp-bg-white">
							<c:forEach items="${blogs}" var="blog" varStatus="status">
								<ul class="list" style="text-align: left;list-style: none;">
									<li><a href="${basePath}/blog/detail?id=${blog.id}">${blog.title }</a></li><br/>
								</ul>
								<c:if test="${status.index%4==0&&status.index!=0}">
										</div>
								    </div>
									<!-- start recent project block -->
									<div class="rp-block rp-bg">
										<div class="rp-bg-white">
								</c:if>
							</c:forEach>
						</div><!-- .rp-bg-white -->
					</div><!-- .rp-block -->
			    </div><!-- #rp-carousel -->
			    <div class="clearfix"></div>
			    <a class="prev" id="rp-carousel_prev" href="#"><span>prev</span></a>
			    <a class="next" id="rp-carousel_next" href="#"><span>next</span></a>
			</div><!-- .projects_carousel -->
			<div class="clear"></div>	

			</div><!-- .rp-block-main -->
			
			
			
			<!-- 优惠 -->
			<div class="ra-block-main">
				<h4>大杂惠</h4>
				<p style="float: left;">快来看看有什么实惠的东西</p>
				<div class="go-to" style="float: right;margin-right: 200px">
					<a href="${basePath}/pro">更多实惠</a>
					<span></span>
				</div> 
			<!-- CarouFredSel - Recent Articles -->
			<div class="articles_carousel">
			    <div id="ra-carousel">
			  <c:forEach items="${products}" var="pro">
					<!-- start recent articles block -->
					<div class="ra-block ra-bg">
						<div class="ra-bg-white">
						
							<img 
							<c:if test="${pro.imgFromType eq 1}">
								src="${pro.img }" 
							</c:if>
							<c:if test="${pro.imgFromType eq 2}">
								src="imgUpload/proImg/${pro.imgPath}" 
							</c:if>
							
							alt="" style="width: 200px;height: 140px"/>
							<div class="mask">
								<a href="imgUpload/proImg/${pro.imgPath}" class="view-icon" data-rel="zoom-img"></a><!-- 大图 -->
								<a href="${pro.addrUrl}" class="link-icon" style="margin-left: 30px"></a><!-- 链接 -->
							</div><!-- .mask -->
							<div class="ra-arrow-up"></div>
							<div class="ra-content" >
								<h6><a href="blog-post.html">${pro.title }</a></h6>
								
							</div><!-- .ra-content -->
						</div><!-- .ra-bg-white -->
					</div><!-- .ra-block -->
			</c:forEach>
	
			    </div><!-- #ra-carousel -->
			    <div class="clearfix"></div>
			    <a class="prev" id="ra-carousel_prev" href="#"><span>prev</span></a>
			    <a class="next" id="ra-carousel_next" href="#"><span>next</span></a>
			</div><!-- .articles_carousel -->
			<div class="clear"></div>	

			</div><!-- .ra-block-main -->
		<div class="clear"></div>			
			
		</div><!-- .center-block -->
		<div class="clear"></div>
	</div><!-- #recent-projects -->
	<!-- END RECENT PROJECTS -->

	<div class="divider-2px"></div>
	
	<!-- 名人说 -->
	<div id="clients" class="center-block">	
		<div class="cl-block">
			<h4>名人说</h4>
			<!-- CarouFredSel -->

			<div class="testmain_carousel">
				<ul id="testmain_carousel">
			        <li> 孩子们的性格和才能,归根结蒂是受到家庭、父母,特别是母亲的影响最深.孩子长大成人以后,社会成了锻炼他们的环境.
			                                       学校对年轻人的发展也起着重要的作用.但是,在一个人的身上留下不可磨灭的印记的却是家庭.<span>&mdash; 宋庆龄</span></li>

			        <li> 教人要从小教起.幼儿比如幼苗,培养得宜,方能发芽滋长,否则幼年受了损伤,即不夭折,也难成材.<span>&mdash; 陶行知</span></li>

			        <li> 对于稍懂事的孩子，可以给他一个眼神或某种暗示，保持暂时的沉默，常会达到“此时无声胜有声”的效果。
			        <span>&mdash; 吕斌</span></li>

			        <li> 父母唯有不断进取，通过自己的人格力量去获得孩子的钦佩和敬爱。<span>&mdash; 姜晶</span></li>

			        <li>在孩子犯错的情况下，对其进行适当的惩罚是必要的，但一定要在尊重孩子人格、维护孩子自尊心的前提下进行。<span>&mdash; 林格</span></li>
		        </ul>
		        <div class="test-arrow-up"></div>
		    	<div class="clearfix"></div>
			</div><!-- .test_carousel -->
			<div class="clear"></div>			
		</div><!-- .cl-block -->

		<!-- CarouFredSel -->
		<div class="image_carousel">
		    <div id="cl-carousel">
		        <a href="http://envato.com/"><img src="images/clients/envato.png" alt="envato"  /></a>
		        <a href="http://www.cssmoban.com/?"><img src="images/clients/rockablepress.png" alt="rockablepress" ></a>
		        <a href="http://creattica.com/logos/red-fox-validation/668"><img src="images/clients/redfox.png" alt="Red Fox Validation" ></a>
		        <a href="http://photodune.net/?ref=zerge"><img src="images/clients/photodune.png" alt="photodune" /></a>
		        <a href="http://themeforest.net/?ref=zerge"><img src="images/clients/themeforest.png" alt="themeforest" /></a>
		        <a href="#"><img src="images/clients/pinup.png" alt="pinup" /></a>
		        <a href="http://themeforest.net/item/metric-premium-wordpress-theme/1865719?ref=zerge"><img src="images/clients/metric.png" alt="metric" /></a>
		        <a href="#"><img src="images/clients/audiojungle.png" alt="audiojungle" /></a>
		        <a href="#"><img src="images/clients/tutorials.png" alt="tutorials" /></a>
		    </div><!-- #foo3 -->
		    <div class="clearfix"></div>
		    <a class="prev" id="cl-carousel_prev" href="#"><span>prev</span></a>
		    <a class="next" id="cl-carousel_next" href="#"><span>next</span></a>
		    
		</div><!-- .image_carousel -->
		<div class="clear"></div>	
	</div><!-- #clients -->
	<!-- END CLIENTS -->

</div><!-- #wrapper -->
<div class="clear"></div>
<!-- END WRAPPER -->


 <%@ include file="../front/other/foot.jsp"%>

</body>
</html>

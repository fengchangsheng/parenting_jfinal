<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - Product</title>
	<link href='${basePath}/css/prolist/fontcss.css' rel='stylesheet' id="googlefont">
	<link rel="stylesheet" href="${basePath}/css/prolist/index.css">
</head>

<body>
 <%@ include file="../other/head.jsp" %>

<!-- START WRAPPER SECTION -->
<div id="wrapper">

	<div id="separator">
		<div class="center-block">
			<h3>聚生活</h3>
			<span>: 我们不卖东西，我们只是搜集优惠</span>
		</div>
	</div>
	
	<!-- START CONTENT -->
	<div class="center-block-page">
	
	<div class="art-list" id="Jarticle" style="width: 900px">
	
<!--数据库 Start  -->
		<c:forEach items="${proList}" var="pro">
			<div class="art" id="topic${pro.id }" tid="${pro.id }">
			<div class="art-hd">
					<a href="#" target="_blank" class="tag">【优惠】</a>
				<a href="#" >${pro.title }<i class="red">&nbsp;&nbsp;&nbsp;${pro.price }元 ${pro.saleTag }</i></a>
			</div>
			<div class="art-bd" style="width: 700px;margin-left: 50px" >
				<div class="art-pic">
					<a href="${pro.addrUrl}" target="_blank">
						<c:if test="${pro.imgFromType eq 1}">
							<img width="180" height="180" src="${pro.img }">
						</c:if>
						<c:if test="${pro.imgFromType eq 2}">
							<img width="180" height="180" src="${basePath}/imgUpload/proImg/${pro.imgPath}">
						</c:if>
					</a>
					
	                       <p class="btn-wrap">
	                           <a href="${pro.addrUrl}" target="_blank" class="btn">去看看 <em></em></a>
	                       </p>
				</div>
		
				<div class="art-info">
					<span class="mark age-tag">
	                           <a href="#" class="fc-red" target="_blank">
	                             ${pro.age }
								</a>
					</span>
					<span class="mark sj-tag">
						<a href="${pro.addrUrl }" class="fc-red" target="_blank">${pro.addrName }</a>
						<a href="http://best.pconline.com.cn/category/2115/youhui/" target="_blank">${pro.tag }</a>
					</span>
					<span class="mark-sub">
						<fmt:formatDate value="${pro.pubTime }" type="both"/>
					</span>
				</div>
				<div class="art-detail">
					<div class="art-pre">
						${pro.content }
					</div>
					
	                   <!-- 
	                       <a href="#" onclick="Article.extendArt(this);return false;" tempstr="收起文章" class="art-btn">展开全文<em></em></a>
	                    -->
				</div>
				<div class="art-stat">
					<a href="javascript:" onclick="Article.vote(this,0)" class="btn btn-like"><em class="ic-like"></em><span>3</span><i>+1</i></a>
					
					
						<a href="javascript:" onclick="Article.vote(this,1)" class="btn btn-dlike"><em class="ic-dlike"></em><span>1</span><i>+1</i></a>
					                   
					<a href="http://best.pcbaby.com.cn/youhui/131939.html#comment_flag" target="_blank" class="btn btn-cmt"><em class="ic-cmt"></em><span>0</span></a>
					<a href="javascript:" onclick="Article.collect(this);return false;" class="btn btn-clt"><em class="ic-clt"></em><span>4</span></a>
				</div>
				<div class="clear"></div>
			</div>
		</div>
			
		
		</c:forEach>
	
    </div><!-- end list -->
	
		<!-- START PAGINATION-->
			<div id="nav-pagination">
				<ul class="nav-pagination clearfix">
	   	    	 	<li class="first"><a href="${basePath}/pro?page=1"></a></li>
	   	    	 	<%
	   	    	 	  int totalPage = (Integer)request.getAttribute("totalPage");
	   	    	 	  for(int i=1;i<=totalPage;i++){
	   	    	 	  	
	   	    	 	 %>
	   	    	 	 <li><a href="${basePath}/pro?page=<%=i %>"><%=i %></a></li>
	   	    	 	 <%} %>
	   	    	 	<li class="last"><a href="${basePath}/pro?page=${totalPage}"></a></li>
	   	    	 </ul>
			</div>
			<!-- END PAGINATION-->	

	</div><!-- .center-block -->

	<!-- END CONTENT -->
	
</div><!-- #wrapper -->
<div class="clear"></div>
<!-- END WRAPPER -->	    


 <%@ include file="../other/foot.jsp"%>
	<script type="text/javascript">
//js全局变量
var global_domain = "http://best.pcbaby.com.cn",
    global_bestDomain = "http://best.pconline.com.cn",
	global_collectCmu = "cmu",
	global_sessionId = "common_session_id",
	global_loginUrl = "http://passport2.pconline.com.cn/passport2/passport/login.jsp",
	global_pageNo = "1"*1,
	global_pageUrl = global_domain + "/pcbaby/intf/getMoreIndex.jsp",
	global_categoryId = "",
	global_section = "",
	global_tagId = "",
	global_mallName = "",
	global_q = "";
(function(){
	/**
	 * 点赞、滚动、收藏全文算
	 * @type {Object} 0为点赞，1为踩
	 */
	window.Article = {
		obj : $('#Jarticle'),
		scroll : false,
		flag : true,
		counter : 2,
		extendArt : function (obj){
		    var $obj = $(obj),$parent = $obj.parent(),
		        $prev = $obj.prev(),$art = $obj.parents('.art:eq(0)'),
		        _ot = $art.offset().top;

		    if(!$obj.hasClass('active')) {
		        $obj.addClass('active');
		        $parent.addClass('extended');
		        var $imgs = $prev.find('img');
		        $imgs.each(function(){
		            var $this = $(this),_src = $this.attr('src2');
		            //console.log(_src);
		            if(typeof _src != 'undefined'){

		                if($.browser.msie && $.browser.version == '6.0'){
		                    $this.bind('load',function(){
		                        if(this.width > 600){
		                            this.style.width = 600 + 'px';
		                        }
		                    });
		                }
		                
		                $(this).attr('src',_src);
		                $(this).removeAttr('src2');
		            }
		        });
		    }else{
		        $obj.removeClass('active');
		        $parent.removeClass('extended');
		        $('body,html').animate({scrollTop:_ot - 55},500);
		    }
		    var temp = $obj.attr('tempStr');
		    temp = temp.toLowerCase().replace('<em></em>','');
		    $obj.attr('tempStr',$obj.html()).html(temp+'<em><\/em>');
		},
		init : function(o) {
			$.extend(this,o);

			this.bind();
		},
		bind : function(){
			var $list = this.obj.find('.more-item');

			$list.each(function () {
				var $this = $(this);

				if(typeof $this.attr('binded') == 'undefined'){
					$this.attr('binded','true');

					$this.bind('mouseenter',function(){
						$this.addClass('s-hover');
					}).bind('mouseleave',function(){
						$this.removeClass('s-hover');
					});
				}
			});

			if(this.scroll){
				this.scrollLoad();	
			}
		},
		vote : function(obj,type){
			var $obj = $(obj);
				tid = $obj.parents('.art:eq(0)').attr('tid');
				$other = type == 0 ? $obj.next() : $obj.prev();
			alert("ok");
			$.ajax({
				type: "post",
				url: global_domain + '/action/topic/like_and_dislike.jsp',
				data:{
					topicId:tid,
					operate:type
				},
				dataType : 'json',
				success : function(data){
					var code = data.code;

					var $em = $obj.find('em'),
						$num = $obj.find('span'),
						$i = $obj.find('i');

					if (code == 1) {
						$obj.addClass('f-por');
						$i.addClass('i-top');
						$i.animate({
							top : - 30,
							opacity : 0
						},500,function(){											
							$num.html(parseInt($num.html()) + 1);				
							$obj.removeClass('f-por');
						});
					} else if (code == 0) {
						popTips(data.desc, 'popup-warnui');
					}

					$obj.addClass('active');
					$obj.get(0).onclick = function(){};
					$other.addClass('disabled');
					$other.get(0).onclick = function(){};
				}
			});	
		},
		scrollLoad : function(){
			var that = this,
				$article = this.obj;
			var initFlag=0; //初始化标识参数
            var otherParams='';
			$(window).bind('load scroll',function(){
				var _ch = document.documentElement.clientHeight,
					_st = document.body.scrollTop ? document.body.scrollTop : document.documentElement.scrollTop,
					_ot = ($article.offset() == null)?0:$article.offset().top,
					_ach = $article.height();
					flag = that.flag,
					counter = that.counter;
				if(_st + _ch + 200 >= _ot + _ach && flag && counter > 0){
					that.flag = false;

					$('#loading').show();
					if(initFlag==0){
                        var params="";
                        if(params!=''){
                            var paramsArr=params.split(',');
                            for(var i=0;i<paramsArr.length;i++){
                                if(i==paramsArr.length){
                                    otherParams+=paramsArr[i];
                                } else{
                                    otherParams+='&'+paramsArr[i];
                                }
                            }
                        }
                        initFlag=1; //初始化一次。
                    }
				
					var pageNo = global_pageNo + (- counter + 3),
						ajaxUrl = global_pageUrl + '?pageNo=' + pageNo + '&categoryId=' + global_categoryId + '&section=' + global_section + '&tagId=' + global_tagId + "&mallName=" + global_mallName + "&q=" + global_q;

					$.ajax({
						type: "GET",
						url : ajaxUrl,
						dataType : 'html',
						success: function(data) {
							
							$('#loading').hide();
							that.counter-- ;

							if(that.counter == 0){
								$('#pager').show();
							}

							//写入
							that.flag = true;
							$('#Jarticle').append(data);

							//重新绑定
							that.bind();
						}
					});
				}
			});
		},		
		collect : function(obj){
			if (GlobalLogin.ifLogin() == false) {
				GlobalLogin.showFB(function(){Article.collect.call(this,obj)});    
			}else{
				var $obj = $(obj),
					tid = $obj.parents('.art:eq(0)').attr('tid'),
					num = 0;
				
				var url  = global_domain + "/action/collect/collect.jsp";
				$.post(url, { topicId:tid, isCollect:1, num:num},
	                function (data) {
	                	//定义状态 -1未登录  0已收藏不能再收藏 1收藏成功 2收藏不成功  3爆料不存在
			 			var $span = $obj.find('span'),
			 				status = 2,
			 				html = '',
			 				str = '';
						num = parseInt($span.html());

			 			if(data != null){
			 				status = data.status;
			 				num += data.count;
			 			} 
			 			if(status == 1){ 
							str = "已收藏！"; 
						}else if(status == 0){
							str = "已收藏！取消请到收藏夹!";   
						} else if(status == -1) {
							str = "收藏失败，请检查是否登陆通行证!"; 
						} else if(status == 3){
							str = "爆料不存在!请收藏有效的爆料！";
						}else{
							str = "收藏不成功!";
						}

						$span.html(num);

						html = '<p class="info"><i class="icon"></i>'+ str +'</p>';
						
						new  popBox({
						    title: '提示信息',
						    boxClass: 'popup popup-sucs',
						    content: html,
						    bottom : '<a href='+ global_bestDomain +'/my/ target="_blank" class="fc-blue">去我的收藏夹>></a>'
						});       	
				});
			}
		}
	};

	Article.init({
		scroll : true
	});
	
})();	
	
	</script>
 <script src="${basePath}/js/front/prolist/jquery.lazyload.min.js" type="text/javascript"></script><!--图片懒加载js-->	 
</body>
</html>
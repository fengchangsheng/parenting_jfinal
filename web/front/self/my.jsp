<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/inc/taglib.jsp" %>
<%@ include file="/inc/jsInclude.jsp" %>
<%@ include file="/inc/jsFrontInclude.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
<title>NsParenting - myBlog</title>
<link rel="icon" type="image/png" href="/images/favicon.png" />
<link rel="stylesheet" type="text/css" href="${basePath }/css/blog.css" >
<script type="text/javascript">
function toEdit(id){
	$('#openWin').html("");
	$('#openWin').append("<iframe src='${basePath}/userCon/toEditMy/"+id+"' width='100%' height='99%' frameborder='no' border='0' marginwidth='0' marginheight='0' scrolling='no' allowtransparency='yes'></iframe>");
	$('#openWin').window('open');  
}
</script>
</head>

<body>
 <%@ include file="../other/head.jsp" %>  


<!-- START WRAPPER SECTION -->
<div id="wrapper">

	<div id="separator">
		<div class="center-block">
			<h3>个人中心</h3>
			<span>: 我的信息</span>
		</div>
	</div>
	
	<!-- START CONTENT -->
	<div class="center-block-page clearfix">
		<div style="border: 1 thin solid">
			<div style="float: left;" >
				<img alt="" src="${basePath}/imgUpload/userImg/${user.f_img}" width="200px" height="200px">			
			</div>	
			<div style="float: left; margin-left: 30px">
			 <span style="font-size: 1.5em">
			   <p> 用户名: ${user.f_name }</p>  
               <p> 年&nbsp;&nbsp;&nbsp;龄: ${user.f_age }		</p>
               <p> 邮&nbsp;&nbsp;&nbsp;箱: ${user.f_email }		</p>
               <p> 职&nbsp;&nbsp;&nbsp;位:  ${user.f_job }		</p>
               <p> 博客等级:  ${user.f_blog_level}   </p>
               <p> 个性签名: ${user.f_des }		</p>	 
			 </span>   
			</div>	
			<button type="button" style="float: right;" onclick="toEdit('${user.f_id}')">修改</button>
		</div>
	<div class="divider-1px"  style="margin-top: 20px">
		
		<div class="clear"></div>
		
		<div id="openWin" class="easyui-window" title="个人信息管理" data-options="closed:true,modal:true," style="width:500px;height:500px;"></div>
	</div><!-- .center-block-page -->

	<!-- END CONTENT -->
</div><!-- #wrapper -->

<!-- END WRAPPER -->	    

 <%@ include file="../other/foot.jsp"%>

</body>
</html>
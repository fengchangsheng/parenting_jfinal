<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/inc/jsInclude.jsp" %>
<%
    try {
        String message = (String) request.getAttribute("message");
        if (message != null && message.length() > 0) {
            out.println("<Script>var message='" + message + "';</Script>");
            request.setAttribute("message", "");
        }else{
            out.println("<Script>var message='';</Script>");
            request.setAttribute("message", "");
        }
    } catch (Exception e) {
        System.out.println("获取页面消息出错:" + e);
    }
%>
<script type="text/javascript">
	if(message!=''){
		showMsg(message);
	}
</script>

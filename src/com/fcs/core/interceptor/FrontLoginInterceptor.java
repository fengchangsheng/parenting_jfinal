package com.fcs.core.interceptor;


import com.fcs.core.model.Oper;
import com.fcs.core.model.User;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
/**
 * @author Lucare
 * 前台登录拦截器   登录后方可进行某些操作   适用于某些菜单项
 * 2015-4-25
 */
public class FrontLoginInterceptor implements Interceptor{
	
	public void intercept(ActionInvocation ai) {
		System.out.println("拦截的路径-----------》"+ai.getActionKey());
		User user = (User) ai.getController().getRequest().getSession().getAttribute(WebUtils.ADMIN_USER);//这里目前只针对后台用户
		if(user!=null){
			ai.invoke();//调用真正的action
		}else{
			System.out.println("该用户没有登录");
			ai.getController().getRequest().getSession().setAttribute("refer",ai.getActionKey());
			ai.getController().redirect("/login.jsp");//重定向到前台登录
		}
	}

}

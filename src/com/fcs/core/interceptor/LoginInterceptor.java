package com.fcs.core.interceptor;


import com.fcs.core.model.Oper;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
/**
 * @author Lucare
 * 后台登录拦截器   有些操作只要后台用户登录后都可以进行
 * 2015-4-25
 */
public class LoginInterceptor implements Interceptor{
	
	public void intercept(ActionInvocation ai) {
		System.out.println("拦截的路径-----------》"+ai.getActionKey());
		Oper oper = (Oper) ai.getController().getRequest().getSession().getAttribute(WebUtils.ADMIN_OPER);//这里目前只针对后台用户
		if(oper!=null){
			System.out.println("*************** 用户已登录,拥有异步请求的权限  ***************");
			ai.invoke();//调用真正的action
		}else{
			System.out.println("该用户没有登录");
			ai.getController().redirect("/admin");//重定向到后台登录
		}
	}

}

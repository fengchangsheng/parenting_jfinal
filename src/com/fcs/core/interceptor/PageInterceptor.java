package com.fcs.core.interceptor;

import java.util.List;

import com.fcs.core.model.Oper;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
/**
 * @author Lucare
 * 同步拦截器   针对同步请求  需要查找当前用户权限
 * 2015-4-25
 */
public class PageInterceptor implements Interceptor{

	
	public void intercept(ActionInvocation ai) {
		System.out.println("拦截的路径-----------》"+ai.getActionKey());
		Oper oper = (Oper) ai.getController().getRequest().getSession().getAttribute(WebUtils.ADMIN_OPER);
		if(oper != null){
			List<String> urls = (List<String>) ai.getController().getRequest().getSession().getAttribute("urls");
			if(urls!=null){
				String url = ai.getActionKey();
				String realUrl = url.substring(1);
				if(!urls.contains(realUrl)){//判断是否有权限
					System.out.println("**************** 没有权限  ******************");
					ai.getController().redirect("/error/401.jsp");
				}else{
					System.out.println("*************** 拥有权限  ***************");
					ai.invoke();//调用真正的action
				}
			}
		}else{
			System.out.println("该用户没有登录");
			ai.getController().redirect("/admin");//重定向到后台登录
		}
	}

}

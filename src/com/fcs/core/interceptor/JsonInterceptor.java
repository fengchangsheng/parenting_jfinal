package com.fcs.core.interceptor;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fcs.core.model.Oper;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
/**
 * @author Lucare
 * 异步拦截器   针对easyui大量的异步请求   给出适当的提示
 * 2015-4-25
 */
public class JsonInterceptor implements Interceptor{
	
	public void intercept(ActionInvocation ai) {
		System.out.println("拦截的路径-----------》"+ai.getActionKey());
		Oper oper = (Oper) ai.getController().getRequest().getSession().getAttribute(WebUtils.ADMIN_OPER);//这里目前只针对后台用户
		Map<String,String> map = new HashMap<String,String>();
		if(oper!=null){
			List<String> urls = (List<String>) ai.getController().getRequest().getSession().getAttribute("urls");
			if(urls!=null){
				String url = ai.getActionKey();
				String realUrl = url.substring(1);
				if(!urls.contains(realUrl)){//判断是否有权限
					System.out.println("**************** 没有权限  ******************");
					map.put("code", "401");
					map.put("msg", "您没有权限!");
					ai.getController().renderJson(map);
				}else{
					System.out.println("*************** 拥有权限  ***************");
					ai.invoke();//调用真正的action
				}
			}else{
				map.put("code", "401");
				map.put("msg", "用户没有分配角色或者角色没有分配资源!");
				ai.getController().renderJson(map);
			}
		}else{
			map.put("code", "401");
			map.put("msg", "您没有权限!");
			ai.getController().renderJson(map);
		}
	}

}

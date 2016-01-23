package com.fcs.core.interceptor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.fcs.core.model.Oper;
import com.fcs.core.model.Role;
import com.fcs.core.model.RoleRes;
import com.fcs.core.model.TreeMenu;
import com.fcs.core.model.User;
import com.fcs.core.model.UserRole;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Interceptor;
import com.jfinal.core.ActionInvocation;
/**
 * @author Lucare
 * 权限拦截器    不太实用  
 * 1.还要分同步请求和异步请求 
 * 2.切换用户不能更新权限  url始终维持一个实例(还是要放到session中)  
 * 2015-3-31
 */
public class RightInterceptor implements Interceptor{

	//获取全部   需要控制的权限  初步设计成拥有的资源
	private static List<String> urls;
	
	public void intercept(ActionInvocation ai) {
		System.out.println("拦截的路径-----------》"+ai.getActionKey());
		if( "/".equals(ai.getActionKey()) || "/seq".equals(ai.getActionKey()) || "/product".equals(ai.getActionKey()) 
			|| "/blog".equals(ai.getActionKey()) || "/blog/detail".equals(ai.getActionKey()) 
			|| ai.getActionKey().contains("artClass") || "/article/detail".equals(ai.getActionKey()) 
			|| "/user/login".equals(ai.getActionKey())){
			//如果是登录的action 
			System.out.println("---------> 放行!!!");
			ai.invoke();
		}else{
			try {
				Oper oper = (Oper) ai.getController().getRequest().getSession().getAttribute(WebUtils.ADMIN_OPER);//这里目前只针对后台用户
				User user = (User) ai.getController().getRequest().getSession().getAttribute(WebUtils.ADMIN_USER);
				if(oper == null){
					ai.getController().redirect("/");//需要自己重新绘制一个页面  提示重新登录
				}else if("/treeMenu/treeJSON".equals(ai.getActionKey())){//加载菜单树需要放行  只要用户登录了
					System.out.println("--------->该用户已登录，就有后台访问权限， 放行!!!");
					ai.invoke();
				}else{
					if(urls == null){
						urls = new ArrayList<String>();
						List<UserRole> userRoleList = UserRole.me.findByUser(oper.getStr("f_id"));
						Set<String> resSet = null;
						if(userRoleList!=null){//判断该用户有没有角色
							//根据角色找资源id(1:n)
							resSet = RoleRes.me.findByRole(userRoleList);
							if(resSet!=null){//判断是否有资源
								for (String res : resSet) {
									TreeMenu treeMenu = TreeMenu.dao.findFirst("select f_url from t_menutree where f_id=?",res);
									String hasUrl = treeMenu.getStr("f_url");
									if(hasUrl != null && !"".equals(hasUrl))
										urls.add(hasUrl);
								}
							}else{
								System.out.println("该用户没有分配资源");
								ai.getController().renderError(401);
							}
						}else{
							System.out.println("该用户没有分配角色");
							ai.getController().render("401.jsp");
						}
					}
					String url = ai.getActionKey();
					String realUrl = url.substring(1);
					Map<String,String> map = new HashMap<String,String>();
					if(!urls.contains(realUrl)){//判断是否有权限
						System.out.println("**************** 没有权限  ******************");
//						ai.getController().render("error/401.jsp");
					
						if(realUrl.contains("toAdd")|| realUrl.contains("toEdit")){//非ajax请求  返回401页面
							ai.getController().render("/401.jsp");
						}else{//是ajax请求就需要返回响应信息
							map.put("code", "401");
							map.put("msg", "您没有权限!");
							ai.getController().renderJson(map);
						}
						return;//转发不能阻止继续执行   所以还是要让程序终止
					}
					System.out.println("*************** 拥有权限  ***************");
					ai.invoke();//调用真正的action
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}//end else
		
	}

}



//try {
////	if(url.contains("add"))  log
//	if(urls.contains(url) && !ext.hasPermission(url)){//如果url不存在的  或者	   
//		ai.getController().renderError(401);
//	}
//} catch (Exception e) {
//	ai.getController().renderError(401);
//}

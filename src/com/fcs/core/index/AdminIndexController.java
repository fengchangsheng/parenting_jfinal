package com.fcs.core.index;

import javax.servlet.http.HttpServletRequest;

import com.fcs.util.WebUtils;
import com.jfinal.core.Controller;


public class AdminIndexController extends Controller{
	
	public void index() {
		render("login.jsp");
	}
	
	public void logOut(){
		HttpServletRequest request = getRequest();
		request.getSession().removeAttribute(WebUtils.ADMIN_OPER);
		render("login.jsp");
	}
}

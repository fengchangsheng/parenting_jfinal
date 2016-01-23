package com.fcs.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fcs.util.CheckCode;
import com.jfinal.core.Controller;

public class CheckCodeController extends Controller{

	
	//获取验证码
	public void getRegisterImage(){
		HttpServletRequest request = getRequest();
		HttpServletResponse response = getResponse();
		CheckCode.getRegisterImage(request, response);
		//采用流异步返回数据应该调用此方法    以免框架拦截器给默认转发   造成二次转发会报错  不信请注释下面的方法
		renderNull();
	}
}

package com.fcs.common;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.StringUtils;

import com.fcs.common.validator.LoginValidator;
import com.fcs.core.model.Oper;
import com.fcs.core.model.User;
import com.fcs.util.CheckCode;
import com.fcs.util.CookieUtils;
import com.fcs.util.MD5;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
/**
 * @author Lucare
 * 后台用户登录
 * 2015-3-31 
 * 2015-5-25 update(记住用户名和密码)
 */
public class LoginController extends Controller{
	
	protected static MD5 md5 = new MD5();
	private String userCode;
	private String password;
	private String checkCode;
	private String keepTime;
	private String[] isRemberPass;
	private String RedirectPath;
	private String message;
	
	private HashMap<String, String> INFOMAP = new HashMap<String, String>() {
        private static final long serialVersionUID = 1L;
        {
            put("nameNotNull", "用户名不能为空");
            put("passNotNull", "密码不能为空");
            put("codeNotNull", "验证码不能为空");
            put("codeErro", "验证码错误");
            put("isBlack", "抱歉,该用户被列为黑名单,不能进行登陆");
            put("infoErro", "密码错误");
            put("userNotPass", "该代理人信息暂未进行审核，请耐心等待");
            put("userNotActive", "该代理人审核不通过或未激活,请重新申请或激活");
            put("userNotExist", "用户不存在");
        }
    };

	public void setCookie(HttpServletResponse res,HttpServletRequest req,String userId,String passwd,String[] isRemberPass,String keepTime){
    	if(isRemberPass!=null&&!StringUtils.isBlank(keepTime)){
    		String cookieValue=CookieUtils.getCookie(req, "userId");
    		if((StringUtils.isBlank(cookieValue))||(!StringUtils.isBlank(cookieValue)&&!keepTime.equals(CookieUtils.getCookie(req, "keepTime")))){
    			CookieUtils.addCookie(res, "userId", userId, Integer.parseInt(keepTime), "/", null, null);
    			CookieUtils.addCookie(res, "passwd", passwd, Integer.parseInt(keepTime), "/", null, null);
    			CookieUtils.addCookie(res, "isRemberPass", isRemberPass[0], Integer.parseInt(keepTime), "/", null, null);
    			CookieUtils.addCookie(res, "keepTime", keepTime, Integer.parseInt(keepTime), "/", null, null);
    		}
    	}else{
    		CookieUtils.removeCookie(res, "userId", "/", null);
    		CookieUtils.removeCookie(res, "passwd", "/", null);
    		CookieUtils.removeCookie(res, "isRemberPass", "/", null);
    		CookieUtils.removeCookie(res, "keepTime", "/", null);
    	}
	}
	
	//@Before(LoginValidator.class)
	public void login(){
		HttpServletRequest request = getRequest();
		HttpServletResponse response = getResponse();
		Map<String,String> map = new HashMap<String,String>();
		Oper oldOper = (Oper) request.getSession().getAttribute(WebUtils.ADMIN_OPER);
		if(oldOper!=null){
			map.put("code", "0");//用户已登录  未正常退出  能解决同一浏览器  基于request级别的重复登录
		    map.put("msg", "用户已登录");
		    renderJson(map);
			return;
		}
		String backUrl="loginPage";
        String flag="";
        userCode = getPara("userCode");
        password = getPara("password");
        checkCode = getPara("checkCode");
        keepTime = getPara("keepTime");
        isRemberPass = getParaValues("isRemberPass");
//        userCode = "admin";
//        password = "123";
        
        //数据验证
        if (StringUtils.isBlank(userCode)) {
            flag="nameNotNull";
        }else if (StringUtils.isBlank(password)) {
        	flag="passNotNull";
        }else if (StringUtils.isBlank(checkCode)) {
            flag="codeNotNull";
        }else if (checkCode!=null&&!checkCode.equals((String)request.getSession(true).getAttribute("adminRand"))) {
        	flag="codeErro";
        } 
        
        if(!StringUtils.isBlank(flag)){
            message=INFOMAP.get(flag);
            System.out.println(message);
            map.put("code", "1");//为空
            map.put("msg", message);
            renderJson(map);
            return;//重定向却无法阻止程序继续执行  只好return
        }
        
        String validateString = md5.MD5Encode(password);
        Oper oper = Oper.dao.findFirst("select * from t_oper where f_name=?",userCode);
        if (oper != null) {
        	//登记用户
        	flag = Oper.dao.storeOper(oper,validateString,request,response);
        	if("redirectURL".equals(flag)){
                RedirectPath = (String) request.getSession().getAttribute("RedirectPath");
                request.getSession().removeAttribute("RedirectPath");
                setCookie(response, request, userCode, password, isRemberPass, keepTime);
            }else if("redirectIndex".equals(flag)){
            	setCookie(response, request, userCode, password, isRemberPass, keepTime);
            	map.put("code", "3");//登录成功
                map.put("msg", message);
                System.out.println("登录成功");
                renderJson(map);
            }else{
            	message=INFOMAP.get(flag);
            	System.out.println(message);
            	map.put("code", "4");//密码错误
                map.put("msg", message);
                renderJson(map);
            }
        }else {
            flag="userNotExist";
        	message=INFOMAP.get(flag);
        	System.out.println(message);
			map.put("code", "2");//用户名不存在
		    map.put("msg", message);
		    renderJson(map);
        }
	}
}

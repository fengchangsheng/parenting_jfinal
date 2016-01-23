package com.fcs.util;

import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;

import com.fcs.core.model.Oper;
import com.fcs.core.model.User;




public class WebUtils {
    /** 前台用户session对象*/
    public static final String ADMIN_USER = "webUser";
    
    /** 后台用户session对象*/
    public static final String ADMIN_OPER = "adminUser";

    public static Object getOper(HttpSession session, String operSessionName) {
        return session.getAttribute(operSessionName);
    }

    public static Oper getOper(HttpServletRequest request) {
        return getOper(request.getSession());
    }
    
    public static Oper getOper(HttpSession session) {
        Object obj = getOper(session, ADMIN_OPER);
        Oper oper = null;
        if (null != obj) {
        	oper = (Oper) obj;
        }
        return oper;
    }
    
  
//    
//    public static User getAgent(HttpServletRequest request) {
//        return getAgent(request.getSession());
//    }
//    
//    public static User getAgent(HttpSession session) {
//        Object obj = getOper(session, AGENT_OPER);
//        User agent = null;
//        if (null != obj) {
//            agent = (User) obj;
//        }
//        return agent;
//    }
    
//    public static boolean hasAgentRight(HttpServletRequest request, PrivilegeConstant privilege) {
//        return true;
//    }
//
//    public static boolean hasAdminRight(HttpServletRequest request, PrivilegeConstant privilege) {
//        return false;
//    }

    public static void toJson(HttpServletResponse response, String data, Object obj) {
        response.setContentType("text/html");
        response.setCharacterEncoding("GBK");
        PrintWriter out = null;
        try {
            out = response.getWriter();
            JSONObject json = new JSONObject();
            if (obj != null) {
                json.accumulate("success", true);
            } else {
                json.accumulate("success", false);
            }
            json.accumulate(data, obj);
            out.println(json.toString());
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            out.close();
        }
    }

    /**
     * 得到请求的IP地址
     * 
     * @param request
     * @return
     */
    public static String getIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Real-IP");
        if (StringUtils.isBlank(ip)) {
            ip = request.getHeader("Host");
        }
        if (StringUtils.isBlank(ip)) {
            ip = request.getHeader("X-Forwarded-For");
        }
        if (StringUtils.isBlank(ip)) {
            ip = "0.0.0.0";
        }
        return ip;
    }
    
    public static String getIpAddr(HttpServletRequest request) {  
        String ip = request.getHeader("X-Forwarded-For");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        return ip;  
    }

    /**
     * 得到请求的根目录
     * 
     * @param request
     * @return
     */
    public static String getBasePath(HttpServletRequest request) {
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
        return basePath;
    }

    /**
     * 得到结构目录
     * 
     * @param request
     * @return
     */
    public static String getContextPath(HttpServletRequest request) {
        String path = request.getContextPath();
        return path;
    }

    public static Page getPage(HttpServletRequest request) {
        String currentPage = request.getParameter("page.currentPage");
        String showRows = request.getParameter("page.showRows");

        Page page = new Page();
        page.setCurrentPage(NumberUtils.toInt(currentPage, 1));
        page.setShowRows(NumberUtils.toInt(showRows, page.getShowRows()));
        return page;
    }
    
    public static Page getUIPage(HttpServletRequest request) {
    	int pageNum=1;
    	int rows=10;
    	if(!StringUtils.isBlank(request.getParameter("page"))){
    		pageNum=Integer.parseInt(request.getParameter("page"));
    	}
    	if(!StringUtils.isBlank(request.getParameter("rows"))){
    		rows=Integer.parseInt(request.getParameter("rows"));
    	}
        Page page = new Page();
    	page.setCurrentPage(pageNum);
    	page.setShowRows(rows);
        return page;
    }
    
    public static String getPojo(Object obj) {
        String str="{";
        List<Object> list = new ArrayList<Object>();
            Class clazz = obj.getClass();
            Field[] fields = obj.getClass().getDeclaredFields();//获得属�?
            for (Field field : fields) {
            	try {
	                if(!"serialVersionUID".equals(field.getName())){
	                    PropertyDescriptor pd = new PropertyDescriptor(field.getName(), clazz);
	                    Method getMethod = pd.getReadMethod();//获得get方法
	                    Object o = getMethod.invoke(obj);//执行get方法返回�?��Object
	                    if(o==null){
	                    	str+="'"+field.getName()+"':'',";
	                    }else{
	                    	str+="'"+field.getName()+"':'"+o.toString()+"',";
	                    }
	                }
            	}catch (Exception e) {
            	}
            }
            if(str.endsWith(","))str=str.substring(0,str.length()-1);
        str+="},";
        return str;
    }
   
    public static String getTableJSON(List list,int pageTotal){
    	String str="{";
    	if(list!=null&&list.size()!=0){
    		str+="'total':'"+pageTotal+"',";
    		str+="'rows':[";
    		for(Object obj:list){
    			str+=getPojo(obj);
    		}
    		if(str.endsWith(","))str=str.substring(0,str.length()-1);
    		str+="]";
    	}
    	str+="}";
        return str;
    }
    
    public static String getMapJSON(List<Map<String,Object>> list,int pageTotal){
        String str="{";
        if(list!=null&&list.size()!=0){
	        str+="'total':'"+pageTotal+"',";
	        str+="'rows':[";
	        for(Map<String,Object> map:list){
	            str+=getMap(map);
	        }
	        if(str.endsWith(","))str=str.substring(0,str.length()-1);
	        str+="]";
        }
        str+="}";
        return str;
    }
    
    private static String getMap(Map<String,Object> map) {
        String str="{";
        if(map!=null){
	        Set<String> key=map.keySet();
	        for (Iterator it = key.iterator(); it.hasNext();) {
	            String s = (String) it.next();
	            str+="'"+s+"':'"+map.get(s)+"',";
	        }
	        if(str.endsWith(","))str=str.substring(0,str.length()-1);
        }
        str+="},";
        return str;
    }
    
    public static String getConfigValByName(String name){
    	String val="";
//    	IConfigLogic configLogic=(IConfigLogic)SpringBeanFactory.getBean("configLogic");
//    	Config con=configLogic.queryConfigByName(name);
//    	if(con!=null){
//    		val=con.getValue();
//    	}
    	return val;
    }
}

package com.fcs.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author
 *
 */
public class CookieUtils {
	
	/**
	 * @param request
	 * @param name
	 * @return
	 */
	public static String getCookie(HttpServletRequest request, String name) {
		Cookie[] cookies = request.getCookies();
    	for(int i = (cookies==null ? -1 : cookies.length-1); i>=0; i--) {
    		if(cookies[i].getName().equals(name)) {
    			return cookies[i].getValue();
    		}
    	}
		return null;
	}
	
	/**
	 * @param response
	 * @param name
	 * @param value
	 * @param maxAge
	 * @param path
	 * @param domain
	 * @param comment
	 */
	public static void addCookie(HttpServletResponse response, String name, String value, int maxAge, String path, String domain, String comment) {
		Cookie cookie = new Cookie(name, value);
    	cookie.setPath(path);
    	cookie.setMaxAge(maxAge);
    	if(domain!=null) {
    		cookie.setDomain(domain);
    	}
    	if(comment!=null) {
    		cookie.setComment(comment);
    	}
    	response.addCookie(cookie);
	}
	
	/**
	 * @param response
	 * @param name
	 */
	public static void removeCookie(HttpServletResponse response, String name, String path, String domain) {
		addCookie(response, name, "", 0, path, domain, null);
	}
}
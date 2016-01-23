package com.fcs.core.model;


import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fcs.util.CheckCode;
import com.fcs.util.WebUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

public class User extends Model<User>{
	private ByteArrayInputStream imageStream;
	public static final User dao = new User();
	
	/**
	 * @param user
	 * @param validateString
	 * @param req
	 * @param res
	 * @return
	 */
	public String storeUser(User user,String validateString,
			HttpServletRequest req, HttpServletResponse res){
		String flag="";
		String pass = user.getStr("f_passwd");
		if(validateString.equals(pass)){
			req.getSession().setAttribute(WebUtils.ADMIN_USER, user);
			flag = "redirectIndex";
		}else{
			flag = "passError";
		}
		return flag;
	}
	
	/**
	 * @param user 根据user查找权限
	 * @return  一个List<String>
	 */
	public List<String> getOperRights(User user){
		List<String> rightString = null;
		String rights = user.get("f_rights");
		System.out.println("找出权限--"+rights);
		if(!"".equals(rights)&&null!=rights){
			rightString=new ArrayList<String>(Arrays.asList(rights.split(",")));
		}
		return rightString;
	}
	
	public long getTotal(){
		long total = Db.queryLong("select count(*) from t_user");
		return total;
	}

	//查找email是否已经注册过
	public boolean findHasEmail(String email) {
		String sql = "select f_id from t_user where f_email=?";
		User user = super.findFirst(sql,email);
		if(user==null){
			return false;
		}
		return true;
	}

	

	
}

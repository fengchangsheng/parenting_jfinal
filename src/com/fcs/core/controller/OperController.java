package com.fcs.core.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.fcs.common.StringTools;
import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.core.model.Oper;
import com.fcs.core.model.Role;
import com.fcs.core.model.UserRole;
import com.fcs.util.DBUtil;
import com.fcs.util.MD5;
import com.fcs.util.UUIDGenerator;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
/**
 * @author Lucare
 *
 * 2015-4-1 update
 */
public class OperController extends Controller{
	@Before(PageInterceptor.class)
	public void listOper(){
		render("list_oper.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void listOperJSON(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String strPage = getPara("page");
			String strRows = getPara("rows");
			String strName = StringTools.getNoneNullString(getPara("name"));
			String strStatus = StringTools.getNoneNullString(getPara("status"));
			int pageNo = 1;
			int pageSize = 10;
			String[] params = null;
			if(strPage!=null){
				pageNo = Integer.parseInt(strPage);
			}
			if(strRows!=null){
				pageSize = Integer.parseInt(strRows);
			}
			String where = "";                    
			if(!strName.equals("")){
				if(!strStatus.equals("")){
					params =  new String[2];
					params[0] = strName;
					params[1] = strStatus;
					where = "f_name=? and f_status=?";
				}else{
					params =  new String[1];
					params[0] = strName;
					where = "f_name=?";
				}
			}else if(!strStatus.equals("")){
				params =  new String[1];
				params[0] = strStatus;
				where = "f_status=?";
			}
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_oper", "*", where, "", params);
			map.put("rows", pageSet.getList());
			map.put("total", pageSet.getTotalRow());
			map.put("code", 200);
			map.put("msg", "数据查询成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 500);
			map.put("msg", "数据查询失败");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toEdit(){
		String id = getPara(0);
		Oper oper =  Oper.dao.findById(id);//找用户
		List<UserRole> userRoles = UserRole.me.findByUser(id);//找拥有的角色
		if(userRoles != null){//判断是否有角色
			setAttr("userRoles", userRoles);//传递拥有的角色
		}
		List<Role> roleList = Role.dao.find("select * from t_role");
		setAttr("oper", oper);
		setAttr("roleList", roleList);//传递整个角色列表
		render("edit_oper.jsp");
	}
	
	//后台查看和修改个人信息
	@Before(LoginInterceptor.class)
	public void self(){
		HttpServletRequest request = getRequest();
		Oper oper = (Oper) request.getSession().getAttribute(WebUtils.ADMIN_OPER);
		setAttr("oper", oper);
		render("self.jsp");
	}
	
	@Before(LoginInterceptor.class)
	public void editPass(){
		HttpServletRequest request = getRequest();
		Map<String,String> map = new HashMap<String, String>();
		try {
			Oper oper = (Oper) request.getSession().getAttribute(WebUtils.ADMIN_OPER);
			String name = getPara("name");
			String des = getPara("des");
			String pass = StringTools.getNoneNullString(getPara("pass"));
			if(!pass.equals("")){
				String realPass = MD5.MD5Encode(pass);
				oper.set("f_passwd", realPass);
				oper.set("f_name", name);
				oper.set("f_des", des);
				oper.update();
				request.getSession().removeAttribute(WebUtils.ADMIN_OPER);
				map.put("url", "admin");
				map.put("status", "1");
			}else{
				oper.set("f_name", name);
				oper.set("f_des", des);
				oper.update();
				request.getSession().setAttribute(WebUtils.ADMIN_OPER, oper);
				map.put("url", "oper/self");
				map.put("status", "2");
			}
			
			map.put("code", "200");
			map.put("msg", "用户编辑成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "用户编辑失败!");
			renderJson(map);
			
		}
	}
	
	@Before(JsonInterceptor.class)
	public void add(){
		Map<String,String> map = new HashMap<String, String>();
		try {
			String[] roles = getParaValues("roles");//当没有配置角色的时候这个值可能为空 
			Oper oper = getModel(Oper.class);
			String id = UUIDGenerator.getUUID();
			oper.set("f_id", id);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			String passwd = MD5.MD5Encode("123");
			oper.set("f_passwd", passwd);
			oper.set("f_create_time", date);
			boolean flag = oper.save();
			if(flag == true && roles != null){
				for (String roleId : roles) {
					UserRole userRole = new UserRole();
					userRole.set("user_id", id);
					userRole.set("role_id", roleId);
					userRole.save();
				}
				map.put("code", "200");
				map.put("msg", "用户添加成功,角色已经分配!");
				renderJson(map);
			}else if(flag == true && roles == null){
				map.put("code", "200");
				map.put("msg", "用户添加成功,尚未分配角色!");
				renderJson(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "用户添加失败!");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toAdd(){
		List<Role> roleList = Role.dao.find("select * from t_role");
		setAttr("roleList", roleList);
		render("add_oper.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void edit(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String[] roleIds = getParaValues("roleId");
			if(roleIds == null){
				map.put("code", "405");
				map.put("msg", "参数错误!");
			}else{
				Oper oper = getModel(Oper.class);
				boolean flag = oper.update();
				if(flag == true && roleIds.length != 0){//如果用户更新成功  并且分配了角色
					//删除原有的所有角色  再次插入新的组合
					List<UserRole> userRoleList = UserRole.me.find("select * from t_user_role where user_id=?",oper.getStr("f_id"));
					if(userRoleList!=null){
						for (UserRole userRole : userRoleList) {
							userRole.delete();
						}
					}
					for (String str : roleIds) {
						UserRole userRole = new UserRole();
						userRole.set("user_id",oper.getStr("f_id"));
						userRole.set("role_id",str);
						userRole.save();
					}
					map.put("code", "200");
					map.put("msg", "用户编辑成功!");
				}
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "用户编辑失败!");
			renderJson(map);
		}
	}
	
	@Before(JsonInterceptor.class)
	public void delete(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String id = getPara("id");
			//1.删除用户拥有的角色关系(用户-角色)
			UserRole.me.deleteByUser(id);
			
			//2.删除该用户
			Oper.dao.deleteById(id);
			map.put("code", "200");
			map.put("msg", "用户删除成功!");
			renderJson(map);
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "用户删除失败!");
			renderJson(map);
		}
	}
}

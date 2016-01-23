package com.fcs.core.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.fcs.common.StringTools;
import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.core.model.Role;
import com.fcs.core.model.RoleRes;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
/**
 * @author Lucare
 * 角色管理
 * 2015-3-15 create
 * 2015-4-10 update
 */
public class RoleController extends Controller{
	@Before(PageInterceptor.class)
	public void listRole(){
		render("role/list_role.jsp");
	}
	
	/**
	 * 返回角色列表(注意格式:easyui的datagrid要求数据JSON必须是如下格式:{"total":0,"rows":[]})
	 * 在这里我直接返回rows  也OK  自己构建json串太麻烦
	 * 修改后的方法  可以自动  分页  查询  5-18 update
	 */
	@Before(JsonInterceptor.class)
	public void listRoleJSON(){
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
					params[0] = "%"+strName+"%";
					params[1] = strStatus;
					where = "f_name like ? and f_status=?";
				}else{
					params =  new String[1];
					params[0] = "%"+strName+"%";
					where = "f_name like ?";
				}
			}else if(!strStatus.equals("")){
				params =  new String[1];
				params[0] = strStatus;
				where = "f_status=?";
			}
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_role", "*", where, "", params);
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
	public void toAdd(){
		render("role/add_role.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void add(){
		Map<String,String> map = new HashMap<String, String>();
		try {
			Role role = getModel(Role.class);
			String rights = getPara("rights");
			if(rights == null){
				map.put("code", "405");
				map.put("msg", "参数错误!");
			}else{
				//id和时间自己搞定
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String id = UUIDGenerator.getUUID();
				role.set("f_id", id);
				role.set("f_create_time", sdf.format(new Date()));
				if(!rights.equals("")){
					role.set("isPur", "1");//已授权
				}
				boolean flag = role.save();
				if(flag == true && !rights.equals("")){
					String[] rightArray = rights.split(",");
					for (int i = 0; i < rightArray.length; i++) {
						RoleRes roleRes = new RoleRes();
						roleRes.set("role_id", id);
						roleRes.set("res_id", rightArray[i]);
						roleRes.save();
					}
					map.put("code", "200");
					map.put("msg", "角色添加成功,资源配置完毕!");
				}else if(flag == true && "".equals(rights)){
					map.put("code", "200");
					map.put("msg", "角色添加成功,尚未配置资源!");
				}else{
					map.put("code", "500");
					map.put("msg", "角色添加失败,资源配置失败!");
				}
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "角色添加失败!");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toEdit() {
		String id = getPara(0);
		Role role = Role.dao.findById(id);
		setAttr("role", role);
		render("role/edit_role.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void edit(){
		Map<String,String> map = new HashMap<String, String>();
		try {
			String rights = getPara("rights");
			Role role = getModel(Role.class);
			if(!rights.equals("")){
				role.set("isPur", "1");//已授权
			}else{
				role.set("isPur", "0");//未授权
			}
			boolean flag = role.update();//更新角色信息
			if(flag == true && rights!=null && !rights.equals("")){
				String[] rightArray = rights.split(",");
				
				//删除原有的属于该角色的权限
				List<RoleRes> roleResList = RoleRes.me.find("select * from t_role_res where role_id=?",role.getStr("f_id"));
				if (roleResList!=null && roleResList.size()>0) {
					for (RoleRes roleRes : roleResList) {
						roleRes.delete();
					}
				}
				
				//添加新资源
				for (int i = 0; i < rightArray.length; i++) {//逐个保存新资源
					RoleRes roleRes = new RoleRes();
					roleRes.set("role_id", role.getStr("f_id"));
					roleRes.set("res_id", rightArray[i]);
					roleRes.save();
				}
				map.put("code", "200");
				map.put("msg", "角色添加成功,资源配置完毕!");
				renderJson(map);
			}else if(flag == true && rights.equals("")){
				map.put("code", "200");
				map.put("msg", "角色编辑成功,尚未配置资源!");
				renderJson(map);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "角色编辑失败!");
			renderJson(map);
		}
	}
	
	/**
	 * 如果还有用户在使用这个角色  那么是否应该考虑
	 */
	@Before(JsonInterceptor.class)
	public void delete(){
		Map<String,String> map = new HashMap<String, String>();
		try {
			String id = getPara("id");
			//1.删除原有的属于该角色的权限
			List<RoleRes> roleResList = RoleRes.me.find("select * from t_role_res where role_id=?",id);
			if (roleResList!=null && roleResList.size()>0) {
				for (RoleRes roleRes : roleResList) {
					roleRes.delete();
				}
			}
			//2.删除角色信息
			Role.dao.deleteById(id);
			map.put("code", "200");
			map.put("msg", "角色删除成功!");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "角色删除失败!");
			renderJson(map);
		}
	}
}

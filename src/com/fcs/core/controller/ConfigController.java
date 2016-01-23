package com.fcs.core.controller;

import java.util.HashMap;
import java.util.Map;
import com.fcs.common.StringTools;
import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.core.model.Config;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

public class ConfigController extends Controller{

	@Before(PageInterceptor.class)
	public void config(){
		render("list_config.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void listConfigJSON(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String strPage = getPara("page");
			String strRows = getPara("rows");
			String strName = StringTools.getNoneNullString(getPara("name"));
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
				params =  new String[1];
				params[0] = "%"+strName+"%";
				where = "name like ?";
			}
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_config", "*", where, "", params);
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
		render("add_config.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void add(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			Config config = getModel(Config.class);
			String id = UUIDGenerator.getUUID();
			config.set("id", id);
			config.save();
			map.put("code", "200");
			map.put("msg", "参数信息添加成功");
			renderJson(map);
		} catch (Exception e){
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "参数信息添加失败");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toEdit(){
		String id = getPara("id");
		Config config = Config.me.findById(id);
		setAttr("config", config);
		render("edit_config.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void edit(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			Config config = getModel(Config.class);
			config.update();
			map.put("code", "200");
			map.put("msg", "参数信息修改成功");
			renderJson(map);
		} catch (Exception e){
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "参数信息修改失败");
			renderJson(map);
		}
	}
	
	@Before(JsonInterceptor.class)
	public void del(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String id = getPara("id");
			Config.me.deleteById(id);
			map.put("code", "200");
			map.put("msg", "参数信息删除成功");
			renderJson(map);
		} catch (Exception e){
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "参数信息删除失败");
			renderJson(map);
		}
	}
}

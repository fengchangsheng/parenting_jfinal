package com.fcs.core.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.fcs.common.StringTools;
import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.core.model.Notice;
import com.fcs.core.model.Oper;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

public class NoticeController extends Controller{
	
	@Before(LoginInterceptor.class)
	public void index(){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			int pageNo = 1;
			int pageSize = 5;
			String[] params = null;
			String where = "";
			String order = "pubTime desc";
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_notice", "*", where, "", params);
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
		renderJson(map);
	}
	
	@Before(PageInterceptor.class)
	public void noticeList(){
		render("list_notice.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void listNoticeJSON(){
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
			String where = "n.author=o.f_id";                    
			if(!strName.equals("")){
				params =  new String[1];
				params[0] = "%"+strName+"%";
				where += " and title like ?";
			}
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_notice n,t_oper o", "n.*,o.f_des", where, "", params);
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
		render("add_notice.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void add(){
		HttpServletRequest request = getRequest();
		Map<String,String> map = new HashMap<String,String>();
		try {
			Notice notice = getModel(Notice.class);
			String id = UUIDGenerator.getUUID();
			Oper oper = (Oper)request.getSession().getAttribute(WebUtils.ADMIN_OPER);
			notice.set("id", id);
			notice.set("author", oper.getStr("f_id"));
			notice.save();
			map.put("code", "200");
			map.put("msg", "公告信息添加成功");
			renderJson(map);
		} catch (Exception e){
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "公告信息添加失败");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toEdit(){
		String id = getPara("id");
		Notice notice = Notice.me.findById(id);
		setAttr("notice", notice);
		render("edit_notice.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void edit(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			Notice notice = getModel(Notice.class);
			notice.update();
			map.put("code", "200");
			map.put("msg", "公告信息修改成功");
			renderJson(map);
		} catch (Exception e){
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "公告信息修改失败");
			renderJson(map);
		}
	}
	
	@Before(JsonInterceptor.class)
	public void delete(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String id = getPara("id");
			Notice.me.deleteById(id);
			map.put("code", "200");
			map.put("msg", "公告信息删除成功");
			renderJson(map);
		} catch (Exception e){
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "公告信息删除失败");
			renderJson(map);
		}
	}

}

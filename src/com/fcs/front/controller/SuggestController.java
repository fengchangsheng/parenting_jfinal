package com.fcs.front.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.front.model.Suggest;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

public class SuggestController extends Controller{

	public void add(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			Suggest suggest = getModel(Suggest.class);
			String id = UUIDGenerator.getUUID();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			suggest.set("id", id);
			suggest.set("pubTime", date);
			suggest.save();
			map.put("code", "200");
			map.put("msg", "您的建议我们已经收到,谢谢！");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "系统故障,建议提交失败！");
			renderJson(map);
		}
		
	}
	
	@Before(PageInterceptor.class)
	public void sugList(){
		render("/admin/suggest/list_sug.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void listSugJSON(){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String strPage = getPara("page");
			String strRows = getPara("rows");
			int pageNo = Integer.parseInt(strPage);
			int pageSize = Integer.parseInt(strRows);
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_suggest", "*", "", "", null);
			map.put("rows", pageSet.getList());
			map.put("total", pageSet.getTotalRow());
			map.put("code", "200");
			map.put("msg", "建议查询成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "建议查询失败");
			renderJson(map);
		}
		
	}
	
	@Before(JsonInterceptor.class)
	public void del(){
		Map<String,Object> map = new HashMap<String,Object>();
		try {
			String id = getPara("id");
			Suggest.me.deleteById(id);
			map.put("code", "200");
			map.put("msg", "建议删除成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "建议删除失败");
			renderJson(map);
		}
	}
}

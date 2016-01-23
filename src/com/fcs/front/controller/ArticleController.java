package com.fcs.front.controller;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fcs.common.StringTools;
import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.front.model.Article;
import com.fcs.front.model.ArticleType;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
/**
 * @author Lucare
 * 教育类文章控制器   前后台通用
 * 2015-4-30
 */
public class ArticleController extends Controller{
	
	//根据类别查找文章列表    用于前台分类文章页面
	public void classify(){
		String typeId = getPara("typeId");
		List<Article> artList = Article.me.findByType(typeId);
		List<Article> newArtList = Article.me.findByTypeNew(typeId);
		setAttr("typeId", typeId);
		setAttr("artList", artList);
		setAttr("newArtList", newArtList);
		render("/front/article/classify.jsp");
	}
	
	public void detail(){
		String id = getPara("id");
		Article article = Article.me.findById(id);
		setAttr("article", article);
		render("/front/article/content.jsp");
	}
	
	public void search(){
		//乱码   提交方式为get时乱码
		try {
			String sname = getPara("sname");
			String typeId = getPara("typeId");
			List<Article> articles = null;
			if(sname.equals("输入关键字")){
				articles = Article.me.findByType(typeId);
			}else{
				articles = Article.me.searchBy(sname,typeId);
			}
			List<Article> newArtList = Article.me.findByTypeNew(typeId);
			setAttr("typeId", typeId);
			setAttr("artList", articles);
			setAttr("newArtList", newArtList);
			render("/front/article/classify.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Before(PageInterceptor.class)
	public void articleList(){
		render("/admin/article/list_article.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void listArticleJSON(){
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
				where = "title like ?";
			}
			String cols = "id,title,author,fromUrl,imgUrl,imgDes,publicTime,status,type";
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_article", cols, where, "", params);
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
		List<ArticleType> artType = ArticleType.me.findType();
		setAttr("artType", artType);
		render("/admin/article/add_article.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void add(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Article article = getModel(Article.class);
			String id = UUIDGenerator.getUUID();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			String date = sdf.format(new Date());
			article.set("id", id);
			article.set("publicTime", date);
			article.save();
			map.put("code", "200");
			map.put("msg", "文章添加成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "文章添加失败");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toEdit(){
		String id = getPara("id");
		Article article = Article.me.findById(id);
		List<ArticleType> artType = ArticleType.me.findType();
		setAttr("artType", artType);
		setAttr("art", article);
		render("/admin/article/edit_article.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void edit(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Article article = getModel(Article.class);
			article.update();
			map.put("code", "200");
			map.put("msg", "文章编辑成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "文章编辑失败");
			renderJson(map);
		}
	}
	
	@Before(JsonInterceptor.class)
	public void delete(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id = getPara("id");
			Article.me.deleteById(id);
			map.put("code", "200");
			map.put("msg", "文章删除成功");
			renderJson(map);
			
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "文章删除失败");
			renderJson(map);
		}
	}

}

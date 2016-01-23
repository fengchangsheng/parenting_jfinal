package com.fcs.front.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.fcs.common.StringTools;
import com.fcs.core.interceptor.FrontLoginInterceptor;
import com.fcs.core.model.User;
import com.fcs.front.model.Ads;
import com.fcs.front.model.Article;
import com.fcs.front.model.Blog;
import com.fcs.front.model.BlogType;
import com.fcs.front.model.Comments;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
/**
 * @author Lucare
 *博客管理  -- 均为前台操作
 * 2015-5-1
 * 2015-5-19 update
 */
public class BlogController extends Controller{
	
	public void index(){
		String typeId = getPara("typeId");
		String strPage = getPara("page");
		//String strName = StringTools.getNoneNullString(getPara("name"));
		int pageNo = 1;
		int pageSize = 5;
		String[] params = null;
		if(strPage!=null){
			pageNo = Integer.parseInt(strPage);
		}
		String where = "";
		String blogTypeName = "";
		String order = "";
		if(typeId!=null){//分页后点击某页进入都会带有typeId  但是直接点击博客的分页typeId为""
			if(typeId.equals("0")){//属于热门博客
				where = "b.author=u.f_id and b.status='1'";
				order = "b.readTimes desc";
				blogTypeName = "热门博客";
			}else if(!typeId.equals("")){//按类别搜索
				where = "b.author=u.f_id and b.status='1' and b.type = ?";  
				order = "b.pubTime desc";
				params =  new String[1];
				params[0] = typeId;
				BlogType blogType = BlogType.me.findById(typeId);
				blogTypeName = blogType.getStr("name");
			}else{
				where = "b.author=u.f_id and b.status='1'";  
				order = "b.pubTime desc";
				blogTypeName = "所有博客";
			}
		}else{//直接点击博客
			where = "b.author=u.f_id and b.status='1'";  
			order = "b.pubTime desc";
			blogTypeName = "所有博客";
		}
		String cols = "b.id,b.title,b.abstract,b.readTimes,b.commentNum,monthname(b.pubTime) as m,day(b.pubTime) as d,u.f_name";
		Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_blog b,t_user u", cols, where, order, params);
		int total = pageSet.getTotalRow();
		int totalPage = (total-1)/pageSize+1;
		setAttr("blogType",blogTypeName);
		setAttr("blogs",pageSet.getList());
		setAttr("current",pageNo);
		setAttr("total",total);
		setAttr("typeId",typeId);
		setAttr("totalPage",totalPage);
		render("blog.jsp");
	}
	
	/**
	 * 此方法已和按类别查找博客合并了  如上
	 */
	@Deprecated
	public void best(){
		String typeId = getPara("typeId");
		String strPage = getPara("page");
		//String strName = StringTools.getNoneNullString(getPara("name"));
		int pageNo = 1;
		int pageSize = 2;
		String[] params = null;
		if(strPage!=null){
			pageNo = Integer.parseInt(strPage);
		}
		String where = "b.author=u.f_id and b.status='1'";                    
//		params =  new String[1];
//		params[0] = typeId;
		Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_blog b,t_user u", "*", where, "b.readTimes desc", null);
		BlogType blogType = BlogType.me.findById(typeId);
		int total = pageSet.getTotalRow();
		int totalPage = (total-1)/pageSize+1;
		setAttr("blogType","热门文章");
		setAttr("blogs",pageSet.getList());
		setAttr("current",pageNo);
		setAttr("total",total);
		setAttr("typeId",typeId);
		setAttr("totalPage",totalPage);
		render("blog.jsp");
	}
	
	/**
	 * 查看博客详情 
	 * 1.取得IP,判断是否同一客户端发出的请求。不是，访问数加一
	 * 2.查询博客内容及博客作者的详细信息
	 * 3.查找该博客下的所有评论以及评论的用户的相关信息
	 * 4.查询广告
	 */
	public void detail(){
		String id = getPara("id");
		Blog blog = Blog.me.findById(id);
		HttpServletRequest request = getRequest();
		String oldIp = (String) request.getSession().getAttribute("ip");
		Blog oldBlog = (Blog) request.getSession().getAttribute("oldBlog");
		String newIp = WebUtils.getIpAddr(request);
		if(oldIp == null || !blog.getStr("id").equals(oldBlog.getStr("id"))){//非同一ip或者非同一blog
			blog.set("readTimes", blog.getInt("readTimes")+1);
			blog.update();
		}else if(!oldIp.equals(newIp)){
			blog.set("readTimes", blog.getInt("readTimes")+1);
			blog.update();
		}
		request.getSession().setAttribute("ip", newIp);
		request.getSession().setAttribute("oldBlog", blog);
		User user = User.dao.findById(blog.getStr("author"));
		List<Record> commentList = Comments.me.findByBlog2(id);
		List<Ads> adsList = Ads.me.findAll();
		setAttr("blog",blog);
		setAttr("user",user);
		setAttr("commentList",commentList);
		setAttr("adsList",adsList);
		render("blog_detail.jsp");
	}
	
	/**
	 * 删除--标记进回收站
	 */
	public void recycle(){
		String id = getPara("id");
		Blog blog = Blog.me.findById(id);
		blog.set("status", "-1");
		blog.update();
		redirect("/blog/findMy");
	}
	
	/**
	 * 删除回收站里的博客--彻底删除
	 */
	public void del(){
		String id = getPara("id");
		Blog.me.deleteById(id);
		redirect("/blog/findMy");
	}
	
	/**
	 * 查找回收站   status= -1
	 */
	public void deleted(){
		findBlog("-1");
		render("recycleBlog.jsp");
	}
	
	/**
	 * 查找草稿箱
	 */
	public void drafts(){
		findBlog("0");
		render("draftsBlog.jsp");
	}
	
	/**
	 * 草稿箱里再发表
	 */
	public void rePost(){
		String id = getPara("id");
		Blog blog = Blog.me.findById(id);
		blog.set("status", "1");
		blog.update();
		redirect("/blog/findMy");
	}
	
	/**
	 * 添加评论
	 */
	@Before(FrontLoginInterceptor.class)
	public void comment(){
		try {
			HttpServletRequest request = getRequest();
			String comComment = getPara("comComment");
			String blogId = getPara("blogId");
			String id = UUIDGenerator.getUUID();
			User user = (User) request.getSession().getAttribute(WebUtils.ADMIN_USER);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			Comments comments = new Comments();
			comments.set("id", id);
			comments.set("content", comComment);
			comments.set("author", user.get("f_id"));
			comments.set("blogId",blogId );
			comments.set("pubTime",date );
			comments.set("parentId","0" );
			boolean flag = comments.save();
			if(flag){
				Blog blog = Blog.me.findById(blogId);
				blog.set("commentNum", blog.getInt("commentNum")+1);
				blog.update();
			}
			redirect("/blog/detail?id="+blogId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 提炼公用的方法   查找已发布  草稿  回收站
	 * @param status(1,0,-1)
	 */
	public void findBlog(String status){
		HttpServletRequest request = getRequest();
		String strPage = getPara("page");
		//String strName = StringTools.getNoneNullString(getPara("name"));
		int pageNo = 1;
		int pageSize = 10;
		String[] params = null;
		if(strPage!=null){
			int intPage = Integer.parseInt(strPage);
			if(intPage>1){
				pageNo = intPage;
			}
		}
		String where = "b.status='"+status+"' and b.author=?";
		String cols = "b.id,b.title,b.readTimes,b.commentNum,b.pubTime";
		User user = (User) request.getSession().getAttribute(WebUtils.ADMIN_USER);
		params =  new String[1];
		params[0] = user.get("f_id");
		Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_blog b", cols, where, "b.pubTime desc", params);
		int total = pageSet.getTotalRow();
		int totalPage = (total-1)/pageSize+1;
		setAttr("myBlogs",pageSet.getList());
		setAttr("current",pageNo);
		setAttr("total",total);
		setAttr("totalPage",totalPage);
	}
	
	@Before(FrontLoginInterceptor.class)
	public void findMy(){
		findBlog("1");
		render("myBlog.jsp");
	}
	
	public void post(){
		List<BlogType> blogTypes = BlogType.me.findType();
		setAttr("blogTypes", blogTypes);
		render("post.jsp");
	}
	
	public void add(){
		HttpServletRequest request = getRequest();
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User user = (User) request.getSession().getAttribute(WebUtils.ADMIN_USER);
			Blog blog = getModel(Blog.class);
			String id = UUIDGenerator.getUUID();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			blog.set("id", id);
			blog.set("author", user.getStr("f_id"));
			blog.set("pubTime", date);
			boolean flag = blog.save();
			if(flag){
				int oldScore = user.get("f_blog_score");
				int oldLevel = user.get("f_blog_level");
				int newScore = oldScore+10;//积分加十分
				user.set("f_blog_score", newScore);
				if(oldLevel==0){
					user.set("f_blog_level", oldLevel+1);//第一次发表等级为一级
				}
				if(newScore%50==0){
					user.set("f_blog_level", oldLevel+1);//等级加一级
				}
				user.update();
				request.getSession().setAttribute(WebUtils.ADMIN_USER, user);
			}
			map.put("code", "200");
			map.put("msg", "博客发表成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "博客发表失败");
			renderJson(map);
		}
	}
	
	public void toEdit(){
		String id = getPara("id");
		Blog blog = Blog.me.findById(id);
		List<BlogType> blogTypes = BlogType.me.findType();
		setAttr("blogTypes", blogTypes);
		setAttr("blog", blog);
		render("blog_edit.jsp");
	}
	
	public void edit(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			Blog blog = getModel(Blog.class);
			blog.update();
			map.put("code", "200");
			map.put("msg", "博客编辑成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "博客编辑失败");
			renderJson(map);
		}
	}

}

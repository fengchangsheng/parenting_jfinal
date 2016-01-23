package com.fcs.front.index;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fcs.core.model.User;
import com.fcs.front.model.Blog;
import com.fcs.front.model.News;
import com.fcs.front.model.Product;
import com.fcs.front.model.Seq;
import com.fcs.util.MD5;
import com.fcs.util.UUIDGenerator;
import com.fcs.util.WebUtils;
import com.jfinal.core.Controller;
/**
 * @author Lucare
 * 
 * 2015-5-14 update
 */
public class IndexController extends Controller{
	
	public void index() {
		List<News> newsList = News.me.findNews();
		List<Blog> blogs = Blog.me.findForIndex();
		List<Product> products = Product.me.findSome();
		List<Seq> seqs = Seq.me.findIndex();
		setAttr("blogs", blogs);
		setAttr("newsList", newsList);
		setAttr("products", products);
		setAttr("seqs", seqs);
		render("index.jsp");
	}
	
	public void register(){
		HttpServletRequest request = getRequest();
		Map<String,Integer> map = new HashMap<String, Integer>();
		try {
			String email = getPara("email");
			boolean has = User.dao.findHasEmail(email);
			if(has){
				map.put("code", 4);//邮箱已经使用过
			}else{
				String pass = getPara("password");
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				User user = new User();
				user.set("f_id", UUIDGenerator.getUUID());
				user.set("f_name", email);
				user.set("f_passwd", pass);
				user.set("f_email", email);
				user.set("f_create_time", date);
				user.save();
				request.getSession().setAttribute(WebUtils.ADMIN_USER, user);
				map.put("code", 0);//注册成功
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 1);//数据库连接异常
			renderJson(map);
		}
	}
	
	/**
	 * 这是一个转向登陆页面的方法，在这里要记录下之前页面的信息，以appid标示，登陆后便于回跳
	 * 目前没有更好的办法  只能暂时这么做了
	 */
	public void login(){
		String appid = getPara("appid");
		if(appid!=null && !appid.equals("")){
			String refer = appid.substring(1, appid.length()-1);//去掉{}
			HttpServletRequest request = getRequest();
			request.getSession().setAttribute("refer","/"+refer);
		}
		render("/login.jsp");
	}
	
	/**
	 * 前台用户登录  无验证码
	 */
	public void userLogin(){
		Map<String,String> map = new HashMap<String, String>(); 
		HttpServletRequest request = getRequest();
		HttpServletResponse response = getResponse();
		String name = getPara("username");
		String pass = getPara("password");
		String refer = "";
		if(!name.equals("")){
			User user = User.dao.findFirst("select * from t_user where f_name=?",name);
			if(user!=null){
				if(user.getStr("f_status").equals("2")){
					map.put("code", "-1");
					map.put("info", "该用户已禁用,请联系管理员解禁");//重定向的页面
				}else{
					String validateString = MD5.MD5Encode(pass);
					String flag = User.dao.storeUser(user, validateString, request, response);
					if(flag.equals("passError")){
						map.put("code", "-2");
						map.put("info", "密码错误");//重定向的页面
					}else{
						String sessionrefer = (String) request.getSession().getAttribute("refer");
						if(sessionrefer!=null)
							refer = sessionrefer;
						map.put("code", "1");
						map.put("refer", refer);//重定向的页面
						request.getSession().removeAttribute("refer");//及时清理
					}
				}
			}else{
				map.put("code", "-3");
				map.put("info", "用户名不存在");
			}
		}
		renderJson(map);
	}
	
	public void logOut(){
		HttpServletRequest request = getRequest();
		request.getSession().removeAttribute(WebUtils.ADMIN_USER);
		redirect("/");
	}
}

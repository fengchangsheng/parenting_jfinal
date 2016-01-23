package com.fcs.common.config;


import com.fcs.common.CheckCodeController;
import com.fcs.common.FileController;
import com.fcs.common.LoginController;
import com.fcs.core.controller.ConfigController;
import com.fcs.core.controller.NoticeController;
import com.fcs.core.controller.OperController;
import com.fcs.core.controller.RoleController;
import com.fcs.core.controller.TreeMenuController;
import com.fcs.core.controller.UserController;
import com.fcs.core.index.AdminIndexController;
import com.fcs.core.interceptor.RightInterceptor;
import com.fcs.core.model.Config;
import com.fcs.core.model.Notice;
import com.fcs.core.model.Oper;
import com.fcs.core.model.Role;
import com.fcs.core.model.RoleRes;
import com.fcs.core.model.TreeMenu;
import com.fcs.core.model.User;
import com.fcs.core.model.UserRole;
import com.fcs.front.controller.AdsController;
import com.fcs.front.controller.ArticleTypeController;
import com.fcs.front.controller.ArticleController;
import com.fcs.front.controller.BlogController;
import com.fcs.front.controller.NewsController;
import com.fcs.front.controller.ProductController;
import com.fcs.front.controller.SeqController;
import com.fcs.front.controller.SuggestController;
import com.fcs.front.index.IndexController;
import com.fcs.front.model.Ads;
import com.fcs.front.model.Answer;
import com.fcs.front.model.Article;
import com.fcs.front.model.ArticleType;
import com.fcs.front.model.Blog;
import com.fcs.front.model.BlogType;
import com.fcs.front.model.Comments;
import com.fcs.front.model.News;
import com.fcs.front.model.Product;
import com.fcs.front.model.Seq;
import com.fcs.front.model.Suggest;
import com.fcs.util.CheckCode;
import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;

public class CoreConfig extends JFinalConfig{

	public boolean OPEN_SHIRO = false;
	
	@Override
	public void configConstant(Constants me) {
		me.setDevMode(true);
		me.setViewType(ViewType.JSP); 
	}
	
	@Override
	public void configRoute(Routes me) {
		//front  前台路由
		me.add("/", IndexController.class,"/front"); 
		me.add("/artClass", ArticleTypeController.class,"/front/article");
		me.add("/blog", BlogController.class,"/front/blog");
		me.add("/seq", SeqController.class,"/front/seq");
		
		//前后台桥梁   均可调用    后台用于管理   前台用于显示
		me.add("/article", ArticleController.class);
		me.add("/pro", ProductController.class,"/front/product");
		me.add("/sug", SuggestController.class);
		
		
		//admin  后台路由
		me.add("/admin", AdminIndexController.class);
		me.add("/user", LoginController.class,"/admin");
		me.add("/checkCode", CheckCodeController.class,"/admin");
		me.add("/treeMenu", TreeMenuController.class,"/admin");
		me.add("/role", RoleController.class,"/admin");
		me.add("/oper", OperController.class,"/admin/oper");
		me.add("/userCon", UserController.class,"/admin/user");
		me.add("/file", FileController.class);
		me.add("/ads", AdsController.class,"/admin/ads");
		me.add("/news", NewsController.class,"/admin/news");
		me.add("/con", ConfigController.class,"/admin/config");
		me.add("/note", NoticeController.class,"/admin/notice");
		
	}

	@Override
	public void configHandler(Handlers arg0) {
		// TODO Auto-generated method stub
	}

	/**
	 * 配置全局拦截器
	 */
	@Override
	public void configInterceptor(Interceptors me) {
		if(OPEN_SHIRO)
			me.add(new RightInterceptor());
	}

	/**
	 * 配置连接数据库的插件
	 */
	@Override
	public void configPlugin(Plugins me) {
		C3p0Plugin cp = new C3p0Plugin("jdbc:mysql://localhost/parenting",
				"root", "root");
		me.add(cp);
		ActiveRecordPlugin arp = new ActiveRecordPlugin(cp);
		me.add(arp);
		arp.addMapping("t_user" ,"f_id",User.class);//默认id为主键
		arp.addMapping("t_oper" ,"f_id",Oper.class);//默认id为主键
		arp.addMapping("t_menutree" ,"f_id",TreeMenu.class);
		arp.addMapping("t_role" ,"f_id",Role.class);
		arp.addMapping("t_user_role" ,"lsh",UserRole.class);//用户角色表
		arp.addMapping("t_role_res" ,"lsh",RoleRes.class);//角色资源表
		arp.addMapping("t_config" ,"id", Config.class);//参数表
		
		
		arp.addMapping("t_article" ,"id", Article.class);//文章表
		arp.addMapping("t_blog" ,"id", Blog.class);//博客表
		arp.addMapping("t_blog_type" ,"id", BlogType.class);//博客类型表
		arp.addMapping("t_comments" ,"id", Comments.class);//博客表
		arp.addMapping("t_article_type" ,"id", ArticleType.class);//文章类别表
		arp.addMapping("t_seq" ,"id", Seq.class);//文章类别表
		arp.addMapping("t_answer" ,"id", Answer.class);//文章类别表
		arp.addMapping("t_product" ,"id", Product.class);//商品表
		arp.addMapping("t_ads" ,"id", Ads.class);//广告表
		arp.addMapping("t_news" ,"id", News.class);//新闻表
		arp.addMapping("t_suggest" ,"id", Suggest.class);//建议表
		arp.addMapping("t_notice" ,"id", Notice.class);//公告表
	}
	
}

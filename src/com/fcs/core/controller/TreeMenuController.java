package com.fcs.core.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;

import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.core.model.Oper;
import com.fcs.core.model.RoleRes;
import com.fcs.core.model.TreeMenu;
import com.fcs.core.model.User;
import com.fcs.core.model.UserRole;
import com.fcs.util.UUIDGenerator;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
/**
 * @author Lucare
 * 生成菜单树
 * 1.获取用户登录情况
 * 2.获取用户权限
 * 3.根据权限构造菜单树json串
 * 2015-3-13
 * 2015-4-25 update  采用局部拦截器
 */
public class TreeMenuController extends Controller{
	
	private String nodeGrade;
	private String parentNode;
	private String menuName;
	private String status;
	
	/**
	 * 批量获取页面参数
	 * @param args
	 * @return
	 */
	@Deprecated
	public TreeMenu getParams(String... args) {
		Map<String, Object> map = new HashMap<String, Object>();
		TreeMenu t = new TreeMenu();
		for (int i = 0; i < args.length; i++) {
			map.put(args[i], getPara(args[i]));
		}
		t.setAttrs(map);
		return t;
	}
	
	@Before(PageInterceptor.class)
	public void toAdd(){
		String pid = getPara(0);//获取传过来的父级id
		setAttr("pid", pid);
		render("menu/add_menu.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void add(){
		TreeMenu treeMenu = getModel(TreeMenu.class);
		String id = UUIDGenerator.getUUID();
		String pid = getPara("treeMenu.f_parent_node");
		//找父级确定nodeGrade
		TreeMenu parent = TreeMenu.dao.findFirst("select f_node_grade from t_menutree m where m.f_id='"+pid+"'");
		String nowGrade = Integer.parseInt(parent.getStr("f_node_grade"))+1+"";
		treeMenu.set("f_id", id);
		treeMenu.set("f_node_grade", nowGrade);
		/**
		 * TODO 目前貌似没有办法添加文件夹  只能通过数据库来  所以在此统一设定为非文件夹 
		 * 还有一种可能就是当这个菜单拥有子菜单后   它就会是一个forder
		 */
		treeMenu.set("f_isforder", "N");
		boolean flag = treeMenu.save();
		Map<String,String> map = new HashMap<String,String>();
		if(flag == true){
			map.put("code", "200");
			map.put("msg", "菜单添加成功!");
		}else{
			map.put("code", "400");
			map.put("msg", "菜单添加失败!");
		}
		renderJson(map);
	}
	
	@Before(JsonInterceptor.class)
	public void delete(){
		String id = getPara(0);
		Map<String,String> map = new HashMap<String,String>();
		boolean flag = TreeMenu.dao.deleteById(id);
		if(flag == true){
			map.put("code", "200");
			map.put("msg", "菜单删除成功!");
		}else{
			map.put("code", "400");
			map.put("msg", "菜单删除失败!");
		}
		renderJson(map);
	}
	
	@Before(PageInterceptor.class)
	public void toEdit(){
		String id = getPara(0);
		HttpServletRequest req = getRequest();
		TreeMenu tm = TreeMenu.dao.findById(id);
		String sql="select * from t_menutree r where r.f_status = '1'";
		setAttr("tm", tm);
		render("menu/edit_menu.jsp");
	}
	
	/**
	 * TODO  失败需要回滚 -->添加事务
	 */
	@Before(JsonInterceptor.class)
	public void edit(){
		TreeMenu treeMenu = getModel(TreeMenu.class);
		boolean flag = treeMenu.update();
		Map<String,String> map = new HashMap<String,String>();
		if(flag == true){
			map.put("code", "200");
			map.put("msg", "菜单编辑成功!");
		}else{
			map.put("code", "400");
			map.put("msg", "菜单编辑失败!");
		}
		renderJson(map);
	}
	
	/**
	 * 加载左侧菜单树  ajax 后台管理首页
	 */
	@Before(LoginInterceptor.class)
	public void treeJSON(){
		HttpServletRequest req = getRequest();
		HttpServletResponse res = getResponse();
		
		Oper oper = WebUtils.getOper(req);
		
		//根据用户找角色id(1:n)
		List<UserRole> userRoleList = UserRole.me.findByUser(oper.getStr("f_id"));
		Set<String> resSet = null;//资源集合   这里使用set装  防止多个角色的资源重复
		if(userRoleList!=null && userRoleList.size()!=0){//判断该用户有没有角色
			//根据角色找资源id(1:n)
			resSet = RoleRes.me.findByRole(userRoleList);
		}
		//根据资源id找资源url
		
		String str="";
		nodeGrade = getPara("nodeGrade");
		parentNode = getPara("parentNode");
		if(resSet!=null && resSet.size()>0){
			str="[";
			List<TreeMenu> listOne = TreeMenu.dao.queryTreeMenu(nodeGrade, parentNode,resSet);
			str+=getHtmlONE(listOne, resSet);
			str+="]";
		}
		try {
			res.setHeader("ContentType", "text/json");
			res.setCharacterEncoding("UTF-8");
			res.getWriter().print(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
		renderNull();
	}
	
	/**
	 * 菜单管理列表
	 */
	@Before(PageInterceptor.class)
	public void listMenu(){
//		String menuName = getPara("menuName");
//		String status = getPara("status");
//		String sql = "select * from t_rights r";
//		sql += " where 1=1 ";
//		//按名索取菜单  后面有用
//		if(!StringUtils.isBlank(menuName)){
//			sql += " and r.f_name like '"+menuName+"'";
//		}
//		if(!StringUtils.isBlank(status)){
//			sql += " and r.f_status = '"+status+"'";
//		}
//		List<Rights> listRights = Rights.dao.listPojoPage(sql);
		render("menu/list_menu.jsp");
	}
	
	/**
	 * 菜单管理--构造菜单树
	 */
	@Before(JsonInterceptor.class)
	public void listAllTreeJSON(){
		Map<String,String> map = new HashMap<String, String>();
		HttpServletResponse res = getResponse();
		nodeGrade = getPara("nodeGrade");
		parentNode = getPara("parentNode");
		String rid = getPara("roleId");
		List<TreeMenu> listOne=TreeMenu.dao.queryTreeMenu(nodeGrade, parentNode);
		String str="[";
		if(rid != null && !rid.equals("")){
			List<RoleRes> roleResList = RoleRes.me.findByRole(rid);
			List<String> resList = new ArrayList<String>();
			if(roleResList != null && roleResList.size()!=0){
				StringBuffer resStrs = new StringBuffer();
				for (RoleRes roleRes : roleResList) {
					resList.add(roleRes.getStr("res_id"));
				}
			}
			str+=getHtmlTHREE2(listOne,resList);
		}else{
			str+=getHtmlTHREE(listOne);
		}
		str+="]";
		map.put("code", "200");
		map.put("msg", "菜单树信息加载成功");
		map.put("data", str);
		renderJson(map);
	}
	
	/**构造菜单树--用于菜单管理   角色管理
	 * @param listTree
	 * @param rights
	 * @return
	 */
	public String getHtmlTHREE(List<TreeMenu> listTree){
		String str="";
		int flag=1;
		for(TreeMenu tree:listTree){
			str+="{";
			str+="'id':'"+tree.getStr("f_id")+"',";
			str+="'text':'"+tree.getStr("f_name")+"',";
			if("Y".equals(tree.getStr("f_isforder"))) str+="'state':'closed',";
			if(!StringUtils.isBlank(tree.getStr("f_url"))) str+="'url':'"+tree.getStr("f_url")+"',";
			List<TreeMenu> listTreeNext = TreeMenu.dao.queryTreeMenu(tree.getStr("f_node_grade"), tree.getStr("f_id"));
			if(listTreeNext!=null&&listTreeNext.size()!=0){
				str+="'children':[";
				str+=getHtmlTHREE(listTreeNext);
				str+="]";
			}else{
				str=str.substring(0,str.length()-1);
			}
			if(flag!=listTree.size()){
				str+="},";
			}else{
				str+="}";
			}
			flag++;
		}
		return str;
	}
	
	/**
	 * TODO  for循环里面应该避免用"+"  需要改成StringBuffer
	 * @param listTree
	 * @return
	 */
	public String getHtmlTHREE2(List<TreeMenu> listTree,List<String> param){
		String str="";
		int flag=1;
		for(TreeMenu tree:listTree){
			str+="{";
			str+="'id':'"+tree.getStr("f_id")+"',";
			str+="'text':'"+tree.getStr("f_name")+"',";
			if("Y".equals(tree.getStr("f_isforder"))) str+="'state':'closed',";
			if(param.contains(tree.getStr("f_id"))){
				str+="'checked':'true',";//加入checkbox   角色编辑需要确定哪些已拥有
			}
			if(!StringUtils.isBlank(tree.getStr("f_url"))) str+="'url':'"+tree.getStr("f_url")+"',";
			List<TreeMenu> listTreeNext = TreeMenu.dao.queryTreeMenu(tree.getStr("f_node_grade"), tree.getStr("f_id"));
			if(listTreeNext!=null&&listTreeNext.size()!=0){
				str+="'children':[";
				str+=getHtmlTHREE2(listTreeNext,param);
				str+="]";
			}else{
				str=str.substring(0,str.length()-1);
			}
			if(flag!=listTree.size()){
				str+="},";
			}else{
				str+="}";
			}
			flag++;
		}
		return str;
	}
	
	/**后台首页菜单树构造   需要权限
	 * @param listTree
	 * @param resSet
	 * @return
	 */
	public String getHtmlONE(List<TreeMenu> listTree,Set<String> resSet){
		String str="";
		int flag=1;
		for(TreeMenu tree:listTree){
			str+="{";
			str+="'id':'"+tree.getStr("f_id")+"',";
			str+="'text':'"+tree.getStr("f_name")+"',";
			if("Y".equals(tree.getStr("f_isforder"))) str+="'state':'closed',";
			if(!StringUtils.isBlank(tree.getStr("f_url"))) str+="'url':'"+tree.getStr("f_url")+"',";
			List<TreeMenu> listTreeNext = TreeMenu.dao.queryTreeMenu(tree.getStr("f_node_grade"), tree.getStr("f_id"),resSet);
			if(listTreeNext!=null&&listTreeNext.size()!=0){
				str+="'children':[";
				str+=getHtmlONE(listTreeNext,resSet);
				str+="]";
			}else{
				str=str.substring(0,str.length()-1);
			}
			if(flag!=listTree.size()){
				str+="},";
			}else{
				str+="}";
			}
			flag++;
		}
		return str;
	}
	
	public String getHtmlONE(List<TreeMenu> listTree,List<String> rights){
		String str="";
		int flag=1;
		for(TreeMenu tree:listTree){
			str+="{";
			str+="'id':'"+tree.getStr("f_id")+"',";
			str+="'text':'"+tree.getStr("f_name")+"',";
			if("Y".equals(tree.getStr("f_isforder"))) str+="'state':'closed',";
			if(!StringUtils.isBlank(tree.getStr("f_url"))) str+="'url':'"+tree.getStr("f_url")+"',";
			List<TreeMenu> listTreeNext = TreeMenu.dao.queryTreeMenu(tree.getStr("f_node_grade"), tree.getStr("f_id"),rights);
			if(listTreeNext!=null&&listTreeNext.size()!=0){
				str+="'children':[";
				str+=getHtmlONE(listTreeNext,rights);
				str+="]";
			}else{
				str=str.substring(0,str.length()-1);
			}
			if(flag!=listTree.size()){
				str+="},";
			}else{
				str+="}";
			}
			flag++;
		}
		return str;
	}
	

}

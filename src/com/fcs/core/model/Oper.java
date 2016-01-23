package com.fcs.core.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fcs.util.WebUtils;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

public class Oper extends Model<Oper>{
	public static Oper dao = new Oper();
	
	public String storeOper(Oper oper,String validateString,
			HttpServletRequest req, HttpServletResponse res){
		String flag="infoErro";
		String pass = oper.getStr("f_passwd");
		if(validateString.equals(pass)){
			req.getSession().setAttribute(WebUtils.ADMIN_OPER, oper);
			//开始保存资源到session中
			List<String> urls = null;
			Set<String> resSet = null;
			List<UserRole> userRoleList = UserRole.me.findByUser(oper.getStr("f_id"));
			if(userRoleList!=null){//判断该用户有没有角色
				//根据角色找资源id(1:n)
				resSet = RoleRes.me.findByRole(userRoleList);
				if(resSet!=null){//判断是否有资源
					urls = new ArrayList<String>();
					for (String resource : resSet) {
						TreeMenu treeMenu = TreeMenu.dao.findFirst("select f_url from t_menutree where f_id=?",resource);
						if(treeMenu!=null){//当资源不存在   而角色资源表仍保存的时候  就会null
							String hasUrl = treeMenu.getStr("f_url");
							if(hasUrl != null && !"".equals(hasUrl))
								urls.add(hasUrl);
						}
					}
				}
			}
			req.getSession().setAttribute("urls", urls);
			flag = "redirectIndex";
		}
		return flag;
	}
	
	public List<String> getOperRights(Oper oper){
		List<String> rightString = null;
		String roleId = oper.getStr("f_role");//取得角色id
		Role role = Role.dao.findById(roleId);//找到角色
		String rights = role.getStr("f_rights");//找到资源
		System.out.println("找出权限--"+rights);
		if(!"".equals(rights)&&null!=rights){
			rightString=new ArrayList<String>(Arrays.asList(rights.split(",")));
		}
		return rightString;
	}
	
	public Page<Record> pagination(int pageNumber,int pageSize,String select,String sqlExceptSelect){
		return Db.paginate(pageNumber, pageSize, select, sqlExceptSelect);
	}
}

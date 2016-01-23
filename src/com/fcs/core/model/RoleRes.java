package com.fcs.core.model;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.jfinal.plugin.activerecord.Model;

public class RoleRes extends Model<RoleRes>{

	public static final RoleRes me = new RoleRes();
	
	/**
	 * 根据角色找资源
	 * @return 资源id集合
	 */
	public Set<String> findByRole(List<UserRole> userRoles){
		Set<String> ResSet = new HashSet<String>();//使用set避免多个角色的资源重复
		for (UserRole userRole : userRoles) {
			String roleId = userRole.getStr("role_id");
			List<RoleRes> roleReslist = super.find("select * from t_role_res where role_id=?",roleId);
			for (RoleRes roleRes : roleReslist) {
				ResSet.add(roleRes.getStr("res_id"));
			}
		}
		return ResSet;
	}
	
	/**
	 * 根据角色找资源  重载
	 * @return 角色-资源 集合
	 */
	public List<RoleRes> findByRole(String rid){
		List<RoleRes> roleReslist = super.find("select * from t_role_res where role_id=?",rid);
		return roleReslist;
	}
}

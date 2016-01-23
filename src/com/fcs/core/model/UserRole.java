package com.fcs.core.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class UserRole extends Model<UserRole>{

	public static final UserRole me = new UserRole();
	
	public List<UserRole> findByUser(String userId){
		List<UserRole> userRoleList = super.find("select * from t_user_role where user_id=?",userId);
		return userRoleList;
	}
	
	public void deleteByUser(String id) {
		List<UserRole> userRoleList = findByUser(id);
		if(userRoleList!=null && userRoleList.size()>0)
		for (UserRole userRole : userRoleList) {
			userRole.delete();
		}
	}
}

package com.fcs.core.model;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;

public class Role extends Model<Role>{
	
	public static Role dao = new Role();
	
	public long getTotal(){
		long total = Db.queryLong("select count(*) from t_role");
		return total;
	}

	
}

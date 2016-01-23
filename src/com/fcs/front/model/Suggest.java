package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Suggest extends Model<Suggest>{
	
	public static final Suggest me = new Suggest();

	public List<Suggest> findAll() {
		String sql = "select * from t_suggest";
		return super.find(sql);
	}
	
	
}

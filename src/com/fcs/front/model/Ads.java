package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Ads extends Model<Ads>{
	
	public static final Ads me = new Ads();
	
	public List<Ads> findAll(){
		String sql = "select * from t_ads";
		return super.find(sql);
	}

}

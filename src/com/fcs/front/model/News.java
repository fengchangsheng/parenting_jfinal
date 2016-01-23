package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class News extends Model<News>{
	
	public static final News me = new News();

	public List<News> findNews() {
		String sql = "select * from t_news t order by t.order";
		return super.find(sql);
	}
	
	

}

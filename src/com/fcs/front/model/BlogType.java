package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class BlogType extends Model<BlogType>{
	
	public static final BlogType me = new BlogType();
	
	public List<BlogType> findType(){
		String sql = "select * from t_blog_type";
		return super.find(sql);
	}

}

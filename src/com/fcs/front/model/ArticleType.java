package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class ArticleType extends Model<ArticleType>{
	
	public static final ArticleType me = new ArticleType();

	public List<ArticleType> findType(){
		String sql = "select id,name from t_article_type where 1=1";
		return super.find(sql);
	}
}

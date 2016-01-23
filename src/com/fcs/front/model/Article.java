package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Article extends Model<Article>{
	
	public static final Article me = new Article();
	
	@Deprecated
	public List<Article> findALl(){
		String sql = "select id,title,author,fromUrl,imgUrl,imgDes,publicTime from t_article where 1=1";
		return super.find(sql);
	}
	
	public List<Article> findByType(String typeId){
		String sql = "";
		if(typeId==null){
			sql = "select id,title from t_article";
			return super.find(sql);
		}else{
			sql = "select id,title from t_article where type=?";
			return super.find(sql,typeId);
		}
	}

	public List<Article> findByTypeNew(String typeId) {
		String sql = "";
		if(typeId==null){
			sql = "select id,title from t_article order by publicTime desc limit 0,5";
			return super.find(sql);
		}else{
			sql = "select id,title from t_article where type=? order by publicTime desc limit 0,5";
			return super.find(sql,typeId);
		}
	}

	public List<Article> searchBy(String sname,String typeId) {
		String sql = "";
		if(typeId == null || typeId.equals("")){
			sql = "select id,title from t_article where title like '%"+sname+"%'";
			return super.find(sql);
		}else{
			sql = "select id,title from t_article where type=? and title like '%"+sname+"%'";
			return super.find(sql,typeId);
		}
	}

}

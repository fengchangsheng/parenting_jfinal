package com.fcs.front.model;

import java.util.List;

import com.fcs.core.model.User;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

public class Blog extends Model<Blog>{
	
	public static final Blog me = new Blog();

	@Deprecated
	public List<Blog> findByType(String typeId) {
		String sql = "select * from t_blog where type = ?";
		return super.find(sql,typeId);
	}
	
	public List<Record> findByType2(String typeId){
		String sql = "select * from t_blog b,t_user u where b.author=u.f_id and b.status='1' and b.type = ?";
		return Db.find(sql,typeId);
	}
	
	public List<Blog> findForIndex(){
		String sql = "select b.id,b.title from t_blog b where b.status='1' order by b.pubTime desc limit 0,8";
		return super.find(sql);
	}
	
	public List<Record> findBest(){
		String sql = "select * from t_blog b,t_user u where b.author=u.f_id and b.status='1' order by b.readTimes desc";
		return Db.find(sql);
	}
	
	//查找最近发表的
	public List<Record> findRecent(){
		String sql = "select * from t_blog b,t_user u where b.author=u.f_id order by b.readTimes desc";
		return Db.find(sql);
	}

	/**
	 * 根据用户查找  --构建'我的博客'
	 * @return  三个方法可以合并   增加status参数
	 */
	public List<Blog> findByUser(User user) {
		String sql = "select b.id,b.title,b.readTimes,b.commentNum,b.pubTime from t_blog b where b.status='1' and b.author=? order by b.pubTime desc";
		return super.find(sql,user.get("f_id"));
	}
	
	//查找回收站
	public List<Blog> findByUser2(User user) {
		String sql = "select b.id,b.title,b.readTimes,b.commentNum,b.pubTime from t_blog b where b.status='-1' and b.author=? order by b.pubTime desc";
		return super.find(sql,user.get("f_id"));
	}

	//查找草稿箱
	public List<Blog> findByUser3(User user) {
		String sql = "select b.id,b.title,b.readTimes,b.commentNum,b.pubTime from t_blog b where b.status='0' and b.author=? order by b.pubTime desc";
		return super.find(sql,user.get("f_id"));
	}

}

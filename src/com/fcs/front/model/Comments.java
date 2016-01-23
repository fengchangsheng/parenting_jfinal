package com.fcs.front.model;

import java.util.List;

import com.fcs.core.model.User;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

public class Comments extends Model<Comments>{

	public static final Comments me = new Comments();
	
	private User user;

	public List<Comments> findByBlog(String id) {
		String sql = "select * from t_comments where blogId=?";
		String sql2= "SELECT c.*,u.f_id,u.f_name,u.f_img FROM t_user u,t_comments c where u.f_id=c.author";
		List<Comments> commentList = super.find(sql,id);
		for (Comments comments : commentList) {
			String userSql = "select * from t_user where f_id=?";
			User user = User.dao.findFirst(userSql,comments.getStr("author"));
			comments.setUser(user);
		}
		return commentList;
	}
	
	public List<Record> findByBlog2(String blogId){
		String sql = "SELECT c.*,u.f_id,u.f_name,u.f_img FROM t_user u,t_comments c where u.f_id=c.author and c.blogId=?";
		return Db.find(sql,blogId);
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}

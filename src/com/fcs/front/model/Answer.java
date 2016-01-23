package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

public class Answer extends Model<Answer>{
	
	public static final Answer me = new Answer();

	public List<Answer> findBySeq(String id) {
		String sql = "select * from t_answer where seqId=?";
		return super.find(sql,id);
	}
	
	public List<Record> findBySeq2(String id){
		String sql = "select a.*,u.f_name,u.f_img from t_answer a,t_user u where a.author=u.f_id and a.seqId=?";
		return Db.find(sql,id);
	}
}

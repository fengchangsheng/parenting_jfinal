package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Record;

public class Seq extends Model<Seq>{
	
	public static final Seq me = new Seq();
	
	@Deprecated
	public List<Seq> findList(){
		String sql = "select * from t_seq order by pubTime";
		return super.find(sql);
	}
	
	public List<Record> findAll(){
		String sql = "select s.*,u.f_name from t_seq s ,t_user u where s.author=u.f_id order by s.pubTime";
		return Db.find(sql);
	}

	/**
	 * 查找显示到首页
	 * @return
	 */
	public List<Seq> findIndex() {
		String sql = "select id,title from t_seq order by pubTime limit 0,6";
		return super.find(sql);
	}
	
}

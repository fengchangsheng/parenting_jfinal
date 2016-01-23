package com.fcs.util;

import java.util.List;

import net.sf.json.JSONArray;


import com.fcs.common.StringTools;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;

public class DBUtil {
	public static Page<Record> pagination(int pageNo,int pageSize,String tableName,String columns,String where,String orderClause,Object [] params){
		String select = new StringBuffer("select ").append(StringTools.getNoneNullString(columns)).toString();
		StringBuffer sqlExceptSelect = new StringBuffer(" from ");
		sqlExceptSelect.append(StringTools.getNoneNullString(tableName));
		where = StringTools.getNoneNullString(where);
		if(where.length()>0){
			sqlExceptSelect.append(" where ").append(where);
		}
		orderClause = StringTools.getNoneNullString(orderClause);
		if(orderClause.length()>0){
			sqlExceptSelect.append(" order by ").append(orderClause);
		}
		if(params == null){
			params = new Object[]{};
		}
		System.out.println(select+sqlExceptSelect.toString());
		return Db.paginate(pageNo, pageSize, select, sqlExceptSelect.toString(), params);
	}
	
	public static List<Record> find(String tableName,String columns,String where,String orderClause,Object [] params){
		String select = new StringBuffer("select ").append(StringTools.getNoneNullString(columns)).toString();
		StringBuffer sqlExceptSelect = new StringBuffer(" from ");
		sqlExceptSelect.append(StringTools.getNoneNullString(tableName));
		where = StringTools.getNoneNullString(where);
		if(where.length()>0){
			sqlExceptSelect.append(" where ").append(where);
		}
		orderClause = StringTools.getNoneNullString(orderClause);
		if(orderClause.length()>0){
			sqlExceptSelect.append(" order by ").append(orderClause);
		}
		if(params == null){
			params = new Object[]{};
		}
		StringBuffer sql = new StringBuffer(select).append(sqlExceptSelect.toString());
		return Db.find(sql.toString(), params);
	}
	
	public static List<Record> find(String sql,Object ... params){
		System.out.println(sql+"\n==============================================");
		if(params !=null){
			System.out.println(JSONArray.fromObject(params));
		}
		System.out.println("==================================");
		return Db.find(sql, params);
	}
}

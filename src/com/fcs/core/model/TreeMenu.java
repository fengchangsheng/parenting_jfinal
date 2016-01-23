package com.fcs.core.model;

import java.util.List;
import java.util.Set;

import com.jfinal.plugin.activerecord.Model;
/**
 * @author Lucare
 *
 * 2015-5-4 update
 */
public class TreeMenu extends Model<TreeMenu>{
	public static TreeMenu dao = new TreeMenu();
	
	public List<TreeMenu> queryTreeMenu(String nodeGrade, String parentNode,List<String> rights){
		String sql="select * from t_menutree t where t.f_node_Grade = '"+(Integer.parseInt(nodeGrade)+1)+"' and t.f_parent_node = '"+parentNode+"' and t.f_status = '1' ";
		if(null!=rights){
			sql+=" and t.f_right_no in (";
			for(String right:rights){
				sql+="'"+right+"',";
			}	
			sql=sql.substring(0, sql.length()-1);
			sql+=") ";
		}
		sql+=" and t.f_type='1' order by t.f_order";
		List<TreeMenu> list = dao.find(sql);
		return list;
	
	}
	
	/**
	 * 根据权限构造后台管理的菜单树
	 * @param nodeGrade
	 * @param parentNode
	 * @param resSet
	 * @return
	 */
	public List<TreeMenu> queryTreeMenu(String nodeGrade, String parentNode,Set<String> resSet){
		String sql="select * from t_menutree t where t.f_node_Grade = '"+(Integer.parseInt(nodeGrade)+1)+"' and t.f_parent_node = '"+parentNode+"' and t.f_status = '1' ";
		if(null!= resSet && resSet.size()!=0){
			sql+=" and t.f_id in (";
			for (String res : resSet) {
				sql+="'"+res+"',";
			}
			sql=sql.substring(0, sql.length()-1);
			sql+=") ";
		}
		sql+=" and t.f_type='1' order by t.f_order";
		List<TreeMenu> list = dao.find(sql);
		return list;
	
	}
	
	/**
	 * 菜单管理构造菜单树
	 * @param nodeGrade
	 * @param parentNode
	 * @return
	 */
	public List<TreeMenu> queryTreeMenu(String nodeGrade, String parentNode){
		String sql="select * from t_menutree t where t.f_node_Grade = '"+(Integer.parseInt(nodeGrade)+1)+"' and t.f_parent_node = '"+parentNode+"' and t.f_status = '1' ";
		sql+=" order by t.f_order";
		List<TreeMenu> list = dao.find(sql);
		return list;
	
	}
	
}

package com.fcs.front.model;

import java.util.List;

import com.jfinal.plugin.activerecord.Model;

public class Product extends Model<Product>{
	
	public static Product me = new Product();
	
	public List<Product> findAll(){
		String sql = "select * from t_product";	
		return super.find(sql);
	}
	
	public List<Product> findSome(){
		String sql = "select * from t_product order by pubTime desc";	
		return super.find(sql);
	}

}

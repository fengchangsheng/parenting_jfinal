package com.fcs.front.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.front.model.News;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;

public class NewsController extends Controller{
	
	@Before(PageInterceptor.class)
	public void newsList(){
		render("list_news.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void listNewsJSON(){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			Page<Record> pageSet = DBUtil.pagination(1, 10, "t_news", "*", "", "", null);
			map.put("rows", pageSet.getList());
			map.put("total", pageSet.getTotalRow());
			map.put("code", 200);
			map.put("msg", "数据查询成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 500);
			map.put("msg", "数据查询失败,请联系管理员或稍后重试");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toAdd(){
		render("add_news.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void add(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String upStr = uploadImg();
			News news = getModel(News.class);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			String id = UUIDGenerator.getUUID();
			news.set("id", id);
			news.set("pubTime", date);
			if(upStr != null && !upStr.equals("error")){
				news.set("imgPath", upStr);
				news.save();
				map.put("code", "200");
				map.put("msg", "新闻添加成功");
			}else if(upStr == null){
				news.save();
				map.put("code", "200");
				map.put("msg", "新闻添加成功,没有上传图片");
			}else if(upStr.equals("error")){
				news.save();
				map.put("code", "200");
				map.put("msg", "新闻添加成功,图片上传失败");
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("500", "");
			map.put("code", "新闻添加失败");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toEdit(){
		String id = getPara("id");
		News news = News.me.findById(id);
		setAttr("news", news);
		render("edit_news.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void edit(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String upStr = uploadImg();//处理图片
			News news = getModel(News.class);
			if(upStr != null && !upStr.equals("error")){
				news.set("imgPath", upStr);//更新图片  实际更新的只是图片名字
				news.update();
				map.put("code", "200");
				map.put("msg", "新闻编辑成功");
			}else if(upStr == null){
				news.update();
				map.put("code", "200");
				map.put("msg", "新闻编辑成功,没有上传图片");
			}else if(upStr.equals("error")){
				news.update();
				map.put("code", "200");
				map.put("msg", "新闻编辑成功,图片上传失败");
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "新闻编辑失败");
			renderJson(map);
		}
	}
	
	@Before(JsonInterceptor.class)
	public void delete(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String id = getPara("id");
			News.me.deleteById(id);
			map.put("code", "200");
			map.put("msg", "新闻删除成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "新闻删除失败");
			renderJson(map);
		}
	}
	
	public String uploadImg(){
		String path = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
		UploadFile file = getFile("file", PathKit.getWebRootPath() + "/temp");
		if(file==null){
			return null;
		}
		File source = file.getFile();
		String fileName = file.getFileName();
        String extension = fileName.substring(fileName.lastIndexOf("."));
        String prefix;
        if(".png".equals(extension) || ".jpg".equals(extension) || ".gif".equals(extension)){
            prefix = "img";//如果是图像就。。。
            fileName = generateWord() + extension;
        }else{
            prefix = "file";//不是应该提醒  或者这应该放到前端验证
        }
        String newFileName = new SimpleDateFormat("yyyyMMddHHmmSS").format(new Date())+extension;
        try {
            FileInputStream fis = new FileInputStream(source);
            File targetDir = new File(PathKit.getWebRootPath() + "/imgUpload/newsImg");
            if (!targetDir.exists()) {
                targetDir.mkdirs();
            }
            File target = new File(targetDir, newFileName);
            if (!target.exists()) {
                target.createNewFile();
            }
            FileOutputStream fos = new FileOutputStream(target);
            byte[] bts = new byte[300];
            while (fis.read(bts, 0, 300) != -1) {
                fos.write(bts, 0, 300);
            }
            fos.close();
            fis.close();
            source.delete();//删除缓存
        } catch (FileNotFoundException e) {
        	e.printStackTrace();
        	return "error";
        } catch (IOException e) {
            e.printStackTrace();
            return "error";
        }
        return newFileName;
	}
	
	private String generateWord() {
	        String[] beforeShuffle = new String[] { "2", "3", "4", "5", "6", "7",
	                "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
	                "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V",
	                "W", "X", "Y", "Z" };
	        List<String> list = Arrays.asList(beforeShuffle);
	        Collections.shuffle(list);
	        StringBuilder sb = new StringBuilder();
	        for (int i = 0; i < list.size(); i++) {
	            sb.append(list.get(i));
	        }
	        String afterShuffle = sb.toString();
	        String result = afterShuffle.substring(5, 9);
	        return result;
	}
	
}

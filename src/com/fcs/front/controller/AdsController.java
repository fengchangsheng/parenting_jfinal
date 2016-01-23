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

import net.sf.json.JSONObject;

import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.front.model.Ads;
import com.fcs.util.DBUtil;
import com.fcs.util.UUIDGenerator;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.core.JFinal;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
/**
 * @author Lucare
 * 广告控制器   后台操作
 * 2015-5-10
 */
public class AdsController extends Controller{
	
	@Before(PageInterceptor.class)
	public void adsList(){
		render("list_ads.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void listAdsJSON(){
		Map<String,Object> map = new HashMap<String, Object>();
		try {
			String strPage = getPara("page");
			String strRows = getPara("rows");
			int pageNo = Integer.parseInt(strPage);
			int pageSize = Integer.parseInt(strRows);
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_ads", "*", "", "", null);
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
		render("add_ads.jsp");
	}
	
	/**
	 *这是个非常秒的方法  我被自己的机智折服了
	 *即使上传文件          一样获得异步提交的效果
	 */
	@Before(JsonInterceptor.class)
	public void add(){
		Map<String,String> map = new HashMap<String, String>();
		try {
			String upStr = uploadImg();
			Ads ads = getModel(Ads.class);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			String id = UUIDGenerator.getUUID();
			ads.set("id", id);
			ads.set("createTime", date);
			if(upStr != null && !upStr.equals("error")){
				ads.set("imgPath", upStr);
				ads.save();
				map.put("code", "200");
				map.put("msg", "广告添加成功");
			}else if(upStr == null){
				ads.save();
				map.put("code", "200");
				map.put("msg", "广告添加成功,没有上传图片");
			}else if(upStr.equals("error")){
				ads.save();
				map.put("code", "200");
				map.put("msg", "广告添加成功,图片上传失败");
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "广告添加失败");
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
            File targetDir = new File(PathKit.getWebRootPath() + "/imgUpload/adsImg");
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
	
	@Before(PageInterceptor.class)
	public void toEdit(){
		String id = getPara("id");
		Ads ads = Ads.me.findById(id);
		setAttr("ads", ads);
		render("edit_ads.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void edit(){
		Map<String,String> map = new HashMap<String, String>();
		try {
			String upStr = uploadImg();//处理图片
			Ads ads = getModel(Ads.class);
			if(upStr != null && !upStr.equals("error")){
				ads.set("imgPath", upStr);//更新图片  实际更新的只是图片名字
				ads.update();
				map.put("code", "200");
				map.put("msg", "广告编辑成功");
			}else if(upStr == null){
				ads.update();
				map.put("code", "200");
				map.put("msg", "广告编辑成功,没有上传图片");
			}else if(upStr.equals("error")){
				ads.update();
				map.put("code", "200");
				map.put("msg", "广告编辑成功,图片上传失败");
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "广告编辑失败");
			renderJson(map);
		}
	}
	
	@Before(JsonInterceptor.class)
	public void delete(){
		Map<String,String> map = new HashMap<String, String>();
		try {
			String id = getPara("id");
			Ads ads = Ads.me.findById(id);//找到ads
			String pName = ads.getStr("imgPath");
			boolean flag = Ads.me.deleteById(id);
			if(pName != null && flag == true){//图片存在 并且广告删除成功   开始删除图片
			    String s = JFinal.me().getServletContext().getRealPath("")+ "/imgUpload/adsImg/" + pName;//文件的绝对路径
			    File file = new File(s);
			    if(file.exists()){
			    	boolean d = file.delete();
			    }
			}
			map.put("code", "200");
			map.put("msg", "广告删除成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "广告删除失败");
			renderJson(map);
		}
	}

}

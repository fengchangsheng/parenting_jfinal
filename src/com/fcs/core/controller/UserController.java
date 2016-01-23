package com.fcs.core.controller;

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

import javax.servlet.http.HttpServletRequest;

import org.eclipse.jetty.server.Request;

import com.fcs.common.StringTools;
import com.fcs.core.interceptor.JsonInterceptor;
import com.fcs.core.interceptor.LoginInterceptor;
import com.fcs.core.interceptor.PageInterceptor;
import com.fcs.core.model.Role;
import com.fcs.core.model.User;
import com.fcs.util.DBUtil;
import com.fcs.util.MD5;
import com.fcs.util.UUIDGenerator;
import com.fcs.util.WebUtils;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.plugin.activerecord.Page;
import com.jfinal.plugin.activerecord.Record;
import com.jfinal.upload.UploadFile;
/**
 * @author Lucare
 * 前台用户管理
 * 2015-3-16
 * 2015-5-17 update
 */
public class UserController extends Controller{
	
	public void me(){
		HttpServletRequest request = getRequest();
		User user = (User) request.getSession().getAttribute(WebUtils.ADMIN_USER);
		setAttr("user", user);
		render("/front/self/my.jsp");
	}
	
	public void toEditMy(){
		String id = getPara(0);
		User user =  User.dao.findById(id);
		setAttr("user", user);
		render("/front/self/edit_my.jsp");
	}
	
	public void editMy(){
		Map<String,String> map = new HashMap<String,String>();
		HttpServletRequest request = getRequest();
		try {
			String upStr = uploadImg();
			User user = getModel(User.class);
			request.getSession().setAttribute(WebUtils.ADMIN_USER,user);
			if(upStr != null && !upStr.equals("error")){
				user.set("f_img", upStr);
				user.update();
				map.put("code", "200");
				map.put("msg", "个人信息修改成功");
			}else if(upStr == null){
				user.update();
				map.put("code", "200");
				map.put("msg", "个人信息修改成功,没有上传头像");
			}else if(upStr.equals("error")){
				user.update();
				map.put("code", "200");
				map.put("msg", "个人信息修改成功,头像上传失败");
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "个人信息修改失败");
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
            File targetDir = new File(PathKit.getWebRootPath() + "/imgUpload/userImg");
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
	
	/**
	 * 修改密码
	 */
	public void changePass(){
		Map<String,String> map = new HashMap<String,String>();
		HttpServletRequest request = getRequest();
		try {
			User user = (User) request.getSession().getAttribute(WebUtils.ADMIN_USER);
			String newPass = getPara("pw");
			if(newPass!=null && !newPass.equals("")){
				String realPass = MD5.MD5Encode(newPass);
				user.set("f_passwd", realPass);
				user.update();
				request.getSession().removeAttribute(WebUtils.ADMIN_USER);
				map.put("code", "200");
				map.put("msg", "密码修改成功,请重新登录");
			}else{
				map.put("code", "202");
				map.put("msg", "密码修改失败,参数错误");
			}
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "密码修改失败");
			renderJson(map);
		}
		
	}
	
	
	/*********************此处是开后台操作*************************/
	@Before(PageInterceptor.class)
	public void listUser(){
		render("list_user.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void listUserJSON(){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String strPage = getPara("page");
			String strRows = getPara("rows");
			String strName = StringTools.getNoneNullString(getPara("name"));
			String strStatus = StringTools.getNoneNullString(getPara("status"));
			int pageNo = 1;
			int pageSize = 10;
			String[] params = null;
			if(strPage!=null){
				pageNo = Integer.parseInt(strPage);
			}
			if(strRows!=null){
				pageSize = Integer.parseInt(strRows);
			}
			String where = "";                    
			if(!strName.equals("")){
				if(!strStatus.equals("")){
					params =  new String[2];
					params[0] = strName;
					params[1] = strStatus;
					where = "f_name=? and f_status=?";
				}else{
					params =  new String[1];
					params[0] = strName;
					where = "f_name=?";
				}
			}else if(!strStatus.equals("")){
				params =  new String[1];
				params[0] = strStatus;
				where = "f_status=?";
			}
			Page<Record> pageSet = DBUtil.pagination(pageNo, pageSize, "t_user", "*", where, "", params);
			map.put("rows", pageSet.getList());
			map.put("total", pageSet.getTotalRow());
			map.put("code", 200);
			map.put("msg", "数据查询成功");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 500);
			map.put("msg", "数据查询失败");
			renderJson(map);
		}
	}
	
	@Before(PageInterceptor.class)
	public void toEdit(){
		String id = getPara(0);
		User user =  User.dao.findById(id);
		List<Role> listRole = Role.dao.find("select * from t_role");
		setAttr("user", user);
		setAttr("listRole", listRole);
		render("edit_user.jsp");
	}
	
	@Before(JsonInterceptor.class)
	public void edit(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			User user = getModel(User.class);
			user.update();
			map.put("code", "200");
			map.put("msg", "前台用户编辑成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "前台用户编辑失败");
			renderJson(map);
		}
		renderJson(map);
	}
	
	/**
	 *其实后台应该只能修改是否启用 
	 */
	@Before(JsonInterceptor.class)
	public void changeStatus(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String id = getPara("id");
			String flag = getPara("flag");
			User user = User.dao.findById(id);
			if(flag.equals("1")){
				user.set("f_status", "1");//启用
				map.put("msg", "前台用户启用成功");
			}else{
				user.set("f_status", "2");//禁用
				map.put("msg", "前台用户禁用成功");
			}
			user.update();
			map.put("code", "200");
			renderJson(map);
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "前台用户禁用失败");
			renderJson(map);
		}
		
	}
	
	@Before(PageInterceptor.class)
	public void toAdd(){
		List<Role> listRole = Role.dao.find("select * from t_role");
		setAttr("listRole", listRole);
		render("add_user.jsp");
	}
	
	/**
	 * TODO 后台貌似不需要添加前台用户  需要用户自己注册
	 */
	@Before(JsonInterceptor.class)
	public void add(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			User user = getModel(User.class);
			String id = UUIDGenerator.getUUID();
			user.set("f_id", id);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String date = sdf.format(new Date());
			user.set("f_create_time", date);
			user.set("f_passwd", "123");
			user.save();
			map.put("code", "200");
			map.put("msg", "前台用户添加成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "前台用户添加失败");
		}
		renderJson(map);
	}
	
	@Before(JsonInterceptor.class)
	public void delete(){
		Map<String,String> map = new HashMap<String,String>();
		try {
			String id = getPara("id");
			User.dao.deleteById(id);
			map.put("code", "200");
			map.put("msg", "前台用户删除成功");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", "500");
			map.put("msg", "前台用户删除失败");
		}
		renderJson(map);
	}

}

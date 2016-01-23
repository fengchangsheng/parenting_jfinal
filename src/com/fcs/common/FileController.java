package com.fcs.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import com.fcs.core.interceptor.LoginInterceptor;
import com.jfinal.aop.Before;
import com.jfinal.core.Controller;
import com.jfinal.kit.PathKit;
import com.jfinal.upload.UploadFile;

public class FileController extends Controller{
	
	/**
	 * 异步文件上传
	 */
	@Before(LoginInterceptor.class)
	public void ajaxSub(){
		String path = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
		UploadFile file = getFile("file", PathKit.getWebRootPath() + "/temp");
		if(file==null){
			renderNull();
			return;
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
        JSONObject json = new JSONObject();
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
            json.put("error", 1);
            json.put("message", "上传出现错误，请稍后再上传");
        } catch (IOException e) {
            json.put("error", 1);
            json.put("message", "文件写入服务器出现错误，请稍后再上传");
        }
        renderText(newFileName);
	}
	
	/**
	 * 自创又一种方法
	 */
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
	
	 public void upload() {
	        String path = new SimpleDateFormat("yyyy/MM/dd").format(new Date());
	        UploadFile file = getFile("imgFile", PathKit.getWebRootPath() + "/temp");
	        File source = file.getFile();
	        String fileName = file.getFileName();
	        String extension = fileName.substring(fileName.lastIndexOf("."));
	        String prefix;
	        if(".png".equals(extension) || ".jpg".equals(extension) || ".gif".equals(extension)){
	            prefix = "img";
	            fileName = generateWord() + extension;
	        }else{
	            prefix = "file";
	        }
	        JSONObject json = new JSONObject();
	        try {
	            FileInputStream fis = new FileInputStream(source);
	            File targetDir = new File(PathKit.getWebRootPath() + "/" + prefix + "/u/"
	                    + path);
	            if (!targetDir.exists()) {
	                targetDir.mkdirs();
	            }
	            File target = new File(targetDir, fileName);
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
	            json.put("error", 0);
	            json.put("url", "/" + prefix + "/u/" + path + "/" + fileName);
	            source.delete();
	        } catch (FileNotFoundException e) {
	            json.put("error", 1);
	            json.put("message", "上传出现错误，请稍后再上传");
	        } catch (IOException e) {
	            json.put("error", 1);
	            json.put("message", "文件写入服务器出现错误，请稍后再上传");
	        }
	        renderJson(json.toString());
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

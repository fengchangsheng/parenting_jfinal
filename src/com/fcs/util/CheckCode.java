package com.fcs.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sun.image.codec.jpeg.ImageFormatException;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
/**
 * @author Lucare
 * 验证码工具类
 * 2015-3-13
 */
public class CheckCode {
	
	private static ByteArrayInputStream imageStream;
	
    public static Color getRandColor(int fc, int bc) {//给定范围获得随机颜色 
        Random random = new Random();
        if (fc > 255)
            fc = 255;
        if (bc > 255)
            bc = 255;
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }
    
    public static ByteArrayInputStream convertImageToStream(BufferedImage image) {
		ByteArrayInputStream inputStream = null;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		JPEGImageEncoder jpeg = JPEGCodec.createJPEGEncoder(bos);
		try {
			jpeg.encode(image);
			byte[] bts = bos.toByteArray();
			inputStream = new ByteArrayInputStream(bts);
		} catch (ImageFormatException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return inputStream;
	}
    
    
    /**
	 * 动态获取验证码
	 * @param request
	 * @param response
	 */
	public static void getRegisterImage(HttpServletRequest request,HttpServletResponse response){
        // 在内存中创建图象 
        int width = 60, height = 20;
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

        // 获取图形上下文 
        Graphics g = image.getGraphics();

        //生成随机类 
        Random random = new Random();

        // 设定背景色 
        g.setColor(CheckCode.getRandColor(200, 250));
        g.fillRect(0, 0, width, height);

        //设定字体 
        g.setFont(new Font("Times New Roman", Font.PLAIN, 18));

        //画边框 
        //g.setColor(new Color()); 
        //g.drawRect(0,0,width-1,height-1); 

        // 随机产生155条干扰线，使图象中的认证码不易被其它程序探测到 
        //g.setColor(getRandColor(160,200)); 
        /*
         * for (int i=0;i<155;i++) { int x = random.nextInt(width); int y = random.nextInt(height); int xl = random.nextInt(12); int yl = random.nextInt(12); g.drawLine(x,y,x+xl,y+yl); }
         */

        // 取随机产生的认证码(4位数字) 
        String sRand = "";
        for (int i = 0; i < 4; i++) {
            String rand = String.valueOf(random.nextInt(10));
            sRand += rand;
            // 将认证码显示到图象中 
            g.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));//调用函数出来的颜色相同，可能是因为种子太接近，所以只能直接生成 
            g.drawString(rand, 13 * i + 6, 16);
        }

        // 将认证码存入SESSION 
        request.getSession(true).setAttribute("adminRand", sRand);

        // 图象生效 
        g.dispose();

        imageStream = CheckCode.convertImageToStream(image);
        try {
			OutputStream out = response.getOutputStream();
//			PrintWriter out = response.getWriter();
		    byte[] bytes = new byte[1024];
	        int i = 0;
	        while((i=imageStream.read(bytes, 0, bytes.length))!=-1){
	        	out.write(bytes);
	        }
	        out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
}

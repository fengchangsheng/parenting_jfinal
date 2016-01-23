package com.fcs.util;

import java.security.MessageDigest;

/**
 * <p>
 * Title: MD5加密
 * </p>
 * <p>
 * Description: 将字符串加密成MD5�?
 * </p>
 * <p>
 * Copyright: Copyright (c) 2005
 * </p>
 * <p>
 * Company: individual
 * </p>
 * 
 * @author 王晓�?
 * @version 1.0
 */
public class MD5 {

    /**
     * 转换字符串数�?
     */
    private static final String[] hexDigits = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" };

    /**
     * no parameter construct method
     */
    public MD5() {
    }

    /**
     * 转换字节数组�?6进制字串
     * 
     * @param b 字节数组
     * @return 16进制字串
     */
    private static String byteToHexString(byte b) {
        int n = b;
        if (n < 0)
            n = 256 + n;
        int d1 = n / 16;
        int d2 = n % 16;
        return hexDigits[d1] + hexDigits[d2];
    }

    /**
     * 编码
     * 
     * @param str
     * @return
     */
    public static String MD5Encode(String str) {
        StringBuffer sb = new StringBuffer();
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] b = md.digest(str.getBytes());
            for (int i = 0; i < b.length; i++) {
                sb.append(byteToHexString(b[i]));
            }
        } catch (Exception ex) {
            System.err.println(ex);
        }
        return sb.toString();
    }
}

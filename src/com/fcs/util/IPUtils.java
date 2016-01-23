package com.fcs.util;

import java.io.IOException;

/**
 * @author lmq0382
 * @date 2012-12-22
 */
public class IPUtils {
    
    /**
     * 调用新浪的接�? 根据IP地址获取省�?�?
     * @author lmq0382 
     * @date 2012-12-22
     * @param ip
     * @return 字符串数组：String[0]=�? String[1]=�?
     */
    public static String[] getAreaAndAreaSubByIPInSina(String ip) {
        String[] ret = new String[]{"", ""};
        if(ip == null ||ip.trim().length() == 0) {
            return ret;
        }
        HttpRequester request = new HttpRequester();
        request.setDefaultContentEncoding("GBK");
        try {
            HttpResponser resp = request.sendGet("http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=js&ip=" + ip);
            //var remote_ip_info = {"ret":1,"start":"222.246.160.0","end":"222.246.191.255","country":"\u4e2d\u56fd","province":"\u6e56\u5357","city":"\u8861\u9633","district":"","isp":"\u7535\u4fe1","type":"","desc":""};
            String content = resp.getContent();
            if(content == null ||content.trim().length() == 0) {
                return ret;
            }
            //IP地址格式错误返回�?2�? 不存在的IP, 返回的串格式跟实际的IP是一样的, 但是地市和城市内容都为空
            if(content.indexOf("province") == -1 || content.indexOf("city") == -1) {
                return ret;
            }
            String provName = content.replaceAll(".*\"province\":\"(.*?)\".*", "$1").trim();
            provName = EncoderUtils.decodeUnicode(provName);    //unicode编码
            String areaName = content.replaceAll(".*\"city\":\"(.*?)\".*", "$1").trim();
            areaName = EncoderUtils.decodeUnicode(areaName);
            ret[0] = provName;
            ret[1] = areaName;
        } catch (IOException e) {
            e.printStackTrace();
            return new String[]{"", ""};
        }
        return ret;
    }
}

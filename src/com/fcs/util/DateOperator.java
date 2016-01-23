package com.fcs.util;

/**
 * 名称:	 DateOperator        
 * 描述:	 对日期进行格式化,判断期合法�?�?
 * 版权:	 Copyright (c) 2002
 * 公司:	 颖源科技 www.yysoft.com
 * 作�?:	 刘细�?i-office@21cn.com
 * 版本:	 1.0
 * 创建时间:	2002-06-03
 */

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * 日期操作对象，对日期进行格式�?判断期合法�?�?
 * 
 * @version v1.0
 */

public abstract class DateOperator {

    /** 格式：yyyyMMddHHmmss */
    public final static String DATA_TIME_PERSISTENT = "yyyyMMddHHmmss";
    
    /** 格式：yyyy-MM-dd HH:mm:ss */
    public final static String DATE_TIME_DISPLAY = "yyyy-MM-dd HH:mm:ss";

    /** 格式：yyyyMM */
    public final static String DATA_MONTH_PERSISTENT = "yyyyMM";

    /** 格式：yyyyMMdd */
    public final static String DATA_PERSISTENT = "yyyyMMdd";

    /**
     * 判断日期是否正确
     * 
     * @param checkDate 日期字符�?
     * @return true/false 合法返回true
     */
    public static boolean checkDateFormat(String checkDate) {
        DateFormat dateFormat = DateFormat.getDateInstance();
        try {
            dateFormat.parse(checkDate); // 把日期强制转换成日期格式
        } catch (Exception ex) {
            return false;
        }

        return true;
    }

    public static int getYear() {
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        return year;
    }

    public static int getMonth() {
        Calendar calendar = Calendar.getInstance();
        int month = calendar.get(Calendar.MONTH) + 1;
        return month;
    }

    public static int getDay() {
        Calendar calendar = Calendar.getInstance();
        int day = calendar.get(Calendar.DATE);
        return day;
    }

    /**
     * 取得当前时间
     * 
     * @return 当前时间，如:23�?0�?1点等
     */
    public static int getHour() {
        Calendar calendar = Calendar.getInstance();
        int hour = calendar.get(Calendar.HOUR_OF_DAY);
        return hour;
    }

    /**
     * 获得当天偏移天数的日�?
     * 
     * @param offsetDay 偏移天数
     * @param format 日期格式
     * @return String
     * @since 2013-7-1
     */
    public static String getOffsetDate(int offsetDay, String format) {
        Calendar c = Calendar.getInstance();
        c.add(Calendar.DAY_OF_MONTH, offsetDay);
        return format(c.getTime(), format);
    }

    /**
     * 获得当天偏移天数的日期：格式yyyyMMdd
     * 
     * @param offsetDay 偏移天数
     * @return String yyyyMMdd
     * @since 2013-7-1
     */
    public static String getOffsetDate(int offsetDay) {
        return getOffsetDate(offsetDay, "yyyyMMdd");
    }

    /**
     * 获得当天偏移天数的月份：格式yyyyMM
     * 
     * @param offsetDay 偏移天数
     * @return String yyyyMM
     * @since 2013-7-1
     */
    public static String getOffsetDateMonth(int offsetDay) {
        return getOffsetDate(offsetDay, "yyyyMM");
    }

    /**
     * 获取当月偏移月份的日�?
     * 
     * @param offsetMonth 偏移月份
     * @param format 日期格式
     * @return String
     * @since 2013-7-1
     */
    public static String getOffsetMonth(int offsetMonth, String format) {
        Calendar c = Calendar.getInstance();
        c.add(Calendar.MONTH, offsetMonth);
        return format(c.getTime(), format);
    }

    /**
     * 获取当月偏移月份的日期：格式yyyyMM
     * 
     * @param offsetMonth 偏移月份
     * @return String yyyyMM
     * @since 2013-7-1
     */
    public static String getOffsetMonth(int offsetMonth) {
        return getOffsetMonth(offsetMonth, "yyyyMM");
    }

    /**
     * 将date类型转换为指定的格式string类型
     * 
     * @param date
     * @param format
     * @return *
     * @author tzk
     */
    public static String format(Date date, String format) {
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        return sdf.format(date);
    }

    /**
     * 将string转换为DATE
     * 
     * @param date
     * @param format
     * @return
     */
    public static Date getDate(String date, String format) {
        Date d = null;
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        try {
            d = sdf.parse(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return d;
    }

    /**
     * 获取指定日期�?��的月份的�?���?��
     * 
     * @author lmq0382
     * @date 2012-4-24
     * @param date
     * @return
     */
    public static Date getLastDayOfMonth(Date date) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        // 本月�?��天数
        int dayCount = c.getActualMaximum(Calendar.DAY_OF_MONTH);
        c.set(Calendar.DAY_OF_MONTH, dayCount);
        return c.getTime();
    }

    /**
     * 取得指定日期偏移量的月份 <br/>
     * 例如201305�?
     * <ul>
     * <li>偏移量为-1，结果为4</li>
     * <li>偏移量为 0，结果为5</li>
     * <li>偏移量为 1，结果为6</li>
     * <ul>
     * 
     * @param date 日期
     * @param format 日期格式
     * @param offset 偏移月份
     * @return String 返回便宜的月�?
     * @since 2013-6-24
     */
    public static int getYearOfMonth(String date, String format, int offset) {
        Date d = DateOperator.getDate(date, format);
        Calendar c = Calendar.getInstance();
        c.setTime(d);
        c.add(Calendar.MONTH, offset);
        int mon = c.get(Calendar.MONTH) + 1;
        return mon;
    }

    /**
     * 获取日期1和日�?之间的月份差
     * 
     * @author lmq0382
     * @date 2012-10-24
     * @param date1
     * @param date2
     * @return 如果日期1大于日期2,返回结果大于0,否则小于或等�?,�?01201�?01111的结果为2
     */
    public static int getCountMonthBetweenDate(Date date1, Date date2) {
        Calendar calendar1 = Calendar.getInstance();
        calendar1.setTime(date1);
        int year1 = calendar1.get(Calendar.YEAR);
        int month1 = calendar1.get(Calendar.MONTH);
        Calendar calendar2 = Calendar.getInstance();
        calendar2.setTime(date2);
        int year2 = calendar2.get(Calendar.YEAR);
        int month2 = calendar2.get(Calendar.MONTH);
        return (year1 - year2) * 12 + (month1 - month2);
    }
    
    /**
     * 获得指定追加天数日期的格式化日期
     * 
     * @param date 原始日期
     * @return Date
     * @author tzk
     * @since 2009-3-30
     */
    public static Date getEndDate(Date date, int day) {
        Calendar c = Calendar.getInstance();
        c.setTime(date);
        int d = c.get(Calendar.DATE);
        c.set(Calendar.DATE, d + day);
        Date result = c.getTime();
        return result;
    }
    
    /**
     * 判断当前时间是否在时间date2之前
     * 
     * @param date2
     * @return
     */
    public static boolean isDateBefore(String date2) {
        try {
            String date = date2.substring(0, 4) + "-" + date2.substring(4, 6) + "-" + date2.substring(6, 8) + " " + date2.substring(8, 10) + ":" + date2.substring(10, 12) + ":"
                    + date2.substring(12, 14);
            Date date1 = new Date();
            DateFormat df = DateFormat.getDateTimeInstance();
            return date1.before(df.parse(date));
        } catch (ParseException e) {
            System.out.print("[SYS] " + e.getMessage());
            return false;
        }
    }
}

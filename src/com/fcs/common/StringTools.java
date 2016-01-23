package com.fcs.common;

public final class StringTools {
	
	public static String getNoneNullString(String str){
		if(str == null)
			return "";
		return str;
	}
	
	public static String getTrimedString(String str){
		str = getNoneNullString(str);
		return str.trim();
	}
	
	public static String getTrimedString(String str,boolean replaceAll){
		str = getTrimedString(str);
		if(replaceAll){
			str = str.replaceAll("[ ]{0,}","");
		}
		return str;
	}
	public static String getDigitString(String str){
		str = getTrimedString(str,true);;
		if(str.matches("[\\d]")){
			return str;
		}
		return "0";
	}
	
	public static String getNumericString(String str){
		str = getTrimedString(str,true);
		if(str.matches("[\\d]|([\\d]+[.]+[\\d]{1,})")){
			return str;
		}
		return "0";
	}
	

	
	
	public static String getSimilarLikeHqlParam(String src)
	{
		src = StringTools.getTrimedString(src);
		if(src.length()==0)
			return "";
		StringBuffer sb = new StringBuffer("%");
		for(int i=0;i<src.length();i++)
		{
			sb.append(src.charAt(i)).append('%');
		}
		return sb.toString();
	}
	
	
	
	public static void main(String [] args){
		System.out.println(getTrimedString("0.    2   ",true));
	}
	
}

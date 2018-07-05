package com.GetDoubanSearch;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.google.gson.Gson;
import com.info.tempDoc;

import pri.shadoowz.beans.DoubanSearchBean;
import pri.shadoowz.beans.Tag;
import pri.shadoowz.beans.doubanBean;


public class DoubanSearcher {
	public static void main(String[] args) throws Exception{
//		DoubanSearcher ds=new DoubanSearcher();
//		ds.query();
		//test();
	}
	public static void test() throws Exception{
		InputStreamReader in=new InputStreamReader(new FileInputStream("D:/test.txt"));
		BufferedReader buf=new BufferedReader(in);
		String content=new String(buf.readLine().getBytes(),"UTF-8");
		System.out.println(content);
		Gson g=new Gson();
		DoubanSearchBean d=g.fromJson(content, DoubanSearchBean.class);
		System.out.println(d);
	}
public ArrayList<tempDoc> query(String querydata,boolean flag){
	 ArrayList<tempDoc> tp=new ArrayList<tempDoc>();
	// 定义即将访问的链接
	 String url;
	 if(flag)
	   url = "https://api.douban.com/v2/book/search?tag="+querydata;
	 else 
		 url="https://api.douban.com/v2/book/search?q="+querydata;
	  // 定义一个字符串用来存储网页内容
	  String result = "";
	  // 定义一个缓冲字符输入流 
	  BufferedReader in = null;
	  try {
	   // 将string转成url对象
	   URL realUrl = new URL(url);
	   // 初始化一个链接到那个url的连接
	   URLConnection connection = realUrl.openConnection();
	   // 开始实际的连接
	   connection.connect();
	   // 初始化 BufferedReader输入流来读取URL的响应
	   in = new BufferedReader(new InputStreamReader(
	     connection.getInputStream()));
	   // 用来临时存储抓取到的每一行的数据
	   String line;
	   while ((line = in.readLine()) != null) {
	    //遍历抓取到的每一行并将其存储到result里面
	    result += line+"\n";
	    result=new String(result.getBytes("ISO-8859-1"),"UTF-8");
	   }
	  } catch (Exception e) {
	   System.out.println("发送GET请求出现异常！" + e);
	   e.printStackTrace();
	  } 
	  finally{
		  try {
			  if(in!=null)
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  }
	  Gson g=new Gson();
	  DoubanSearchBean search=null;
	  try{
		  search=g.fromJson(result, DoubanSearchBean.class);
	  }
	  catch(Exception e){
		  System.out.println(e.getMessage()+result);
	  }
	  for(doubanBean db:search.getBooks()){
		  tempDoc td=new tempDoc();
		  td.bookname=db.getTitle();
		  td.author=ListToString(db.getAuthor());
		  td.imgsrc=db.getImages().getMedium();
		  td.ISBN=db.getIsbn10();
		  td.price=db.getPrice();
		  td.Rating=db.getRating().getAverage();
		  td.summary=db.getSummary();
		 try{
			 td.tags=db.getTags().size()>1?db.getTags().get(0).getName()+"/"+db.getTags().get(1).getName():db.getTags().get(0).getName();
		 }
		 catch(Exception e){
			 td.tags="";
		 }
		  tp.add(td);
	  }
	 
	  // 使用finally来关闭输入流
	
	return tp;
	
}
public static doubanBean search(String url) throws UnsupportedEncodingException{
	
	  // 定义一个字符串用来存储网页内容
	  String result = "";
	  // 定义一个缓冲字符输入流 
	  BufferedReader in = null;
	  try {
	   // 将string转成url对象
	   URL realUrl = new URL(url);
	   // 初始化一个链接到那个url的连接
	   URLConnection connection = realUrl.openConnection();
	   // 开始实际的连接
	   connection.connect();
	   // 初始化 BufferedReader输入流来读取URL的响应
	   in = new BufferedReader(new InputStreamReader(
	     connection.getInputStream()));
	   // 用来临时存储抓取到的每一行的数据
	   String line;
	   while ((line = in.readLine()) != null) {
	    //遍历抓取到的每一行并将其存储到result里面
	    result += line+"\n";
	   }
	  } catch (Exception e) {
	   System.out.println("发送GET请求出现异常！" + e);
	   e.printStackTrace();
	  } 
	  finally{
		  try {if(in!=null)
			in.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  }
	  result=new String(result.getBytes("ISO-8859-1"),"UTF-8");
	  Gson g=new Gson();
	  doubanBean db=null;
	  try{
	  db=g.fromJson(result, doubanBean.class);
	  }
	  catch(Exception e){
		  db=null;
	  }
	return db;
	
}
public static String ListToString(List<String> target){
	String result="";
	if(target!=null)
		if(target.size()==1)
			return target.get(0);
	for(String s:target)
		result+=s+"/";
	return result;
}
public static String TagToString(List<Tag> target){
	String result="";
	if(target.size()==1)
		result=target.get(0).getName();
	if(target.size()>=2)
		result=target.get(0).getName()+"/"+target.get(1).getName();
	return result;
}
}

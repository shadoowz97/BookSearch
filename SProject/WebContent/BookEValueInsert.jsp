<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jdbc.DataBaseConnector.*"%> 
<%@page import="java.sql.*" %>
<%@page import="org.User.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
String bookname=(String)request.getParameter("bookname");
String evalue=(String)request.getParameter("evalue");
String isbn=(String)request.getParameter("bookisbn");
System.out.println(bookname+"  "+evalue);
SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String time=df.format(new Date());
Connector c=new Connector();
Statement s=c.con.createStatement();
User u=(User)session.getAttribute("user");
u.getHistory().add(isbn);
s.executeUpdate("insert into searcherhistory(username,bookisbn,time) values('"+u.getUsername()+"','"+isbn+"','"+time+"')");
out.clear();
if(s.executeUpdate("insert into evalutionBooks(userid,bookname,evcontent,Evtime)"+
		"values('"+((User)session.getAttribute("user")).getUsername()+"',"+"'"+bookname+"','"+
		
	evalue+"','"+time+"')")==1)
out.print("评论成功！");
else{
	out.print("已评论过该书或网络问题！");
}
%>
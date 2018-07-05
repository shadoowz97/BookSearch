<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@page import="java.io.*" %>
    <%@page import="com.google.gson.Gson"%>
    <%@page import="pri.shadoowz.beans.*" %>
    <%@page import="pri.shadoowz.User.*" %>
    <%@page import="pri.shadoowz.jdbc.DataBaseConnector.*"%> 
<%@page import="java.sql.*" %>
    <%
    Connector c=new Connector();
    String username=(String)request.getParameter("username");
    String password=(String)request.getParameter("password");
    Statement s=c.con.createStatement();
  
   if( s.executeUpdate("insert into userloginfo (username,password) values('"+username+"','"+password+"')")!=1)
  out.print("error");
   else{
	   String sex=((String) request.getParameter("xb")).equals("M")?"男":"女";
	   int age=Integer.parseInt((String)request.getParameter("age"));
	   String tag=((String)request.getParameter("tag")).replaceAll("/", "&&");
	   if(s.executeUpdate("insert into userupperinfo(sex,age,tag,username) values('"+sex+"',"+age+",'"+tag+"','"+username+"')")==1){
		   User u=new User();
		   u.setUsername(username);
		   u.setAge(age);
		   u.setUserTags(tag.split("&&")[0]);
		   u.setSex(sex);
		  session.setAttribute("user", u);
		  out.print("OK");
	   }
	   
   }
    %>

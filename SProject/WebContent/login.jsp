<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jdbc.DataBaseConnector.*"%> 
<%@page import="java.sql.*" %>
<%@page import="com.LuenceSearcher.*" %>
<%@page import="org.User.*" %>
<%
Connector c=new Connector();
String username=(String)request.getParameter("username");
String password=(String)request.getParameter("password");
Statement s=c.con.createStatement();
System.out.println(username);
ResultSet rs=s.executeQuery("select password from userloginfo where username ='"+username+"'");
String ps="";
System.out.println(password);
out.clear();

	while(rs.next()){
		ps=rs.getString(1);
		
	}
	if(ps.equals(password)){
		ResultSet r=s.executeQuery("select * from userloginfo a,userUpperInfo b where a.username='"+username+"' and a.username=b.username;");
		String name=null;
		while(r.next())
		{
			User u=new User();
			name=r.getString("username");
			u.setUsername(r.getString("username"));
			u.setUserTags(r.getString("Tag").split("&&")[0]);
			u.setSex(r.getString("sex"));
			u.setAge(r.getInt("age"));
			session.setAttribute("user", u);
			
		}
		out.print(name);
		}
		else{
			out.print("123");
		}



%>
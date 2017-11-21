package com.jdbc.DataBaseConnector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Connector {
public Connector(String username,String password,String url){
	this.username=username;
	this.password=password;
	InitialConnection();
}
public Connector(){
	InitialConnection();
}
private void InitialConnection(){
	try {
		Class.forName("com.mysql.jdbc.Driver");
		DriverManager.registerDriver(new com.mysql.jdbc.Driver());
		con=getConnection();
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
private Connection getConnection() throws SQLException{
	return (Connection)DriverManager.getConnection(url, username, password);
	
}
public void QueryData(String QueryData){
	try {
		Statement state=con.createStatement();
		rs=state.executeQuery(QueryData);
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
}
//public void QueryData
private String url="jdbc:mysql://localhost:3306/SummerProject";
private String username="dbuser";
private String password="1234";
private boolean conflag=false;
public  Connection con=null;
private ResultSet rs;
}

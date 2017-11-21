package org.User;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Stack;

import com.ansj.vec.Word2VEC;
import com.info.tempDoc;
import com.jdbc.DataBaseConnector.Connector;

public class User {
private String Username;
private String UserTags;
private String sex;
private int age;
private Stack<String> history=new Stack<String>();
public String getUsername() {
	return Username;
}
public void setUsername(String username) {
	Username = username;
}
public String getUserTags() {
	return UserTags;
}
public void setUserTags(String userTags) {
	UserTags = userTags;
}
public String getSex() {
	return sex;
}
public void setSex(String sex) {
	this.sex = sex;
}
public int getAge() {
	return age;
}
public void setAge(int age) {
	this.age = age;
}
public Stack<String> getHistory() {
	return history;
}
public void setHistory(Stack<String> history) {
	this.history = history;
}
@Override
public String toString() {
	return "User [Username=" + Username + ", UserTags=" + UserTags + ", sex=" + sex + ", age=" + age + ", history="
			+ history + "]";
}
public ArrayList<tempDoc> ReRanked(Word2VEC w2v,ArrayList<tempDoc> td){
	tempDoc[] tD=td.toArray(new tempDoc[td.size()]);
	float a=0;
	float b=0;
	boolean flag=true;
	float[] userVector=null;
	if((userVector=w2v.getWordVector(UserTags))==null)
		return td;
	else{
		
		for(int i=0;i<td.size();i++){
			a=VectorDistance(userVector,StanderdVector(w2v.getWordVector(tD[i].FirstTag())));
			for(int j=0;j<td.size()-1-i;j++){
				flag=false;
				if(a<(b=VectorDistance(userVector,StanderdVector(w2v.getWordVector(tD[j+1].FirstTag()))))){
					flag=true;
					a=b;
					tempDoc temp=tD[j];
					tD[j]=tD[j+1];
					tD[j+1]=temp;
					}
			}
		}
		return td;
	}
	
	
}
public String Similiar(Word2VEC w2v) throws SQLException{
	String result=UserTags;
	Connector con=new Connector();
	Statement state=con.con.createStatement();
	ResultSet rs=state.executeQuery("select * from searchertag");
	ArrayList<String> tagList=new ArrayList<String>();
	while(rs.next()){
		tagList.add(rs.getString(2));
	}
	float[] userVector=StanderdVector(w2v.getWordVector(UserTags));
	String tempString=tagList.get(0);
	float similar=0;
	for(String target:tagList){
		float temp=0;
		if((temp=VectorDistance(StanderdVector(w2v.getWordVector("target")),userVector))>similar){
			similar=temp;
			result=target;
		}
	}
return result;
}
public float VectorDistance(float[] a,float[] b){
	if(a==null||b==null)
		return 0;
	else{
		float result=0;
		for(int i=0;i<a.length;i++){
			result+=a[i]*b[i];
		}
		return result;
	}
}
public float[] StanderdVector(float[] target){
	float sum=0;
	if(target==null)
		return new float[200];
	for(int i=0;i<target.length;i++){
		sum+=target[i]*target[i];
	}
	sum=(float) Math.sqrt(sum);
	for(int i=0;i<target.length;i++)
		target[i]/=sum;
	return target;
	
}
}

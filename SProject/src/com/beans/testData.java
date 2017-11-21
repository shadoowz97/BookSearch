package com.beans;

import java.util.ArrayList;
import java.util.HashMap;

public class testData {
public String UserName;
public HashMap<String,Integer> BookValue=new HashMap<String,Integer>();
@Override
public String toString() {
	String result=UserName+"   ";
	for(String a:BookValue.keySet()){
		result+=a+" "+BookValue.get(a)+";";
	}
	return result;
}

}

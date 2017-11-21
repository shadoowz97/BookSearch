package com.info;

public class tempDoc {
public String bookname;
public String author;
public String imgsrc;
public String Rating;
public String price;
public String ISBN;
public String tags;
public String summary;
public String FirstTag(){
	
	return tags.split("/")[0];
}
}

package com.beans;

import java.util.List;

public class DoubanSearchBean {
private int count;
private int start;
private int total;
private List<doubanBean> books;
public int getCount() {
	return count;
}
public void setCount(int count) {
	this.count = count;
}
public int getStart() {
	return start;
}
public void setStart(int start) {
	this.start = start;
}
public int getTotal() {
	return total;
}
public void setTotal(int total) {
	this.total = total;
}
public List<doubanBean> getBooks() {
	return books;
}
public void setBooks(List<doubanBean> books) {
	this.books = books;
}
@Override
public String toString() {
	return "DoubanSearchBean [count=" + count + ", start=" + start + ", total=" + total + ", books=" + books + "]";
}

}

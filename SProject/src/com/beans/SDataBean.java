package com.beans;

import java.util.List;

public class SDataBean {
	private String title;
	private String author;
	private String publisher;
	private String pubdate;
	private String pages;
	private List<String> tags;
	private String price;
	private String binding;
	private String series;
	private String isbn;
	private String rating;
	private String img;
	private String summary;
	private String author_intro;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getPubdate() {
		return pubdate;
	}
	public void setPubdate(String pubdate) {
		this.pubdate = pubdate;
	}
	public String getPages() {
		return pages;
	}
	public void setPages(String pages) {
		this.pages = pages;
	}
	public List<String> getTags() {
		return tags;
	}
	public void setTags(List<String> tags) {
		this.tags = tags;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getBinding() {
		return binding;
	}
	public void setBinding(String binding) {
		this.binding = binding;
	}
	public String getSeries() {
		return series;
	}
	public void setSeries(String series) {
		this.series = series;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getRating() {
		return rating;
	}
	public void setRating(String rating) {
		this.rating = rating;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getAuthor_intro() {
		return author_intro;
	}
	public void setAuthor_intro(String author_intro) {
		this.author_intro = author_intro;
	}
	@Override
	public String toString() {
		return "KJson [title=" + title + ", author=" + author + ", publisher=" + publisher + ", pubdate=" + pubdate
				+ ", pages=" + pages + ", tags=" + tags + ", price=" + price + ", binding=" + binding + ", series=" + series
				+ ", isbn=" + isbn + ", rating=" + rating + ", img=" + img + ", summary=" + summary + ", author_intro="
				+ author_intro + "]";
	}
}

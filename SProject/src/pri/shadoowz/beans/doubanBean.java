package pri.shadoowz.beans;

import java.util.List;

public class doubanBean {
	private Rating rating;
	private String subtitle;
	private List<String> author;
	private String pubdate;
	private List<Tag> tags;
	private String origin_title;
	private String image;
	private String binding;
	private List<String> translator;
	private String catalog;
	private Image images;
	private String pages;
	private String id;
	private String publisher;
	private String isbn10;
	private String isbn13;
	private String title;
	private String url;
	private String alt_title;
	private String author_intro;
	private String summary;
	private String price;
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public Rating getRating() {
		return rating;
	}
	public void setRating(Rating rating) {
		this.rating = rating;
	}
	public String getSubtitle() {
		return subtitle;
	}
	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}
	public List<String> getAuthor() {
		return author;
	}
	public void setAuthor(List<String> author) {
		this.author = author;
	}
	public String getPubdate() {
		return pubdate;
	}
	public void setPubdate(String pubdate) {
		this.pubdate = pubdate;
	}
	public List<Tag> getTags() {
		return tags;
	}
	public void setTags(List<Tag> tags) {
		this.tags = tags;
	}
	public String getOrigin_title() {
		return origin_title;
	}
	public void setOrigin_title(String origin_title) {
		this.origin_title = origin_title;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getBinding() {
		return binding;
	}
	public void setBinding(String binding) {
		this.binding = binding;
	}
	public List<String> getTranslator() {
		return translator;
	}
	public void setTranslator(List<String> translator) {
		this.translator = translator;
	}
	public String getCatalog() {
		return catalog;
	}
	public void setCatalog(String catalog) {
		this.catalog = catalog;
	}
	public Image getImages() {
		return images;
	}
	public void setImages(Image images) {
		this.images = images;
	}
	public String getPages() {
		return pages;
	}
	public void setPages(String pages) {
		this.pages = pages;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	public String getIsbn10() {
		return isbn10;
	}
	public void setIsbn10(String isbn10) {
		this.isbn10 = isbn10;
	}
	public String getIsbn13() {
		return isbn13;
	}
	public void setIsbn13(String isbn13) {
		this.isbn13 = isbn13;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getAlt_title() {
		return alt_title;
	}
	public void setAlt_title(String alt_title) {
		this.alt_title = alt_title;
	}
	public String getAuthor_intro() {
		return author_intro;
	}
	public void setAuthor_intro(String author_intro) {
		this.author_intro = author_intro;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	@Override
	public String toString() {
		return "doubanBean [rating=" + rating + ", subtitle=" + subtitle + ", author=" + author + ", pubdate=" + pubdate
				+ ", tags=" + tags + ", origin_title=" + origin_title + ", image=" + image + ", binding=" + binding
				+ ", translator=" + translator + ", catalog=" + catalog + ", images=" + images + ", pages=" + pages
				+ ", id=" + id + ", publisher=" + publisher + ", isbn10=" + isbn10 + ", isbn13=" + isbn13 + ", title="
				+ title + ", url=" + url + ", alt_title=" + alt_title + ", author_intro=" + author_intro + ", summary="
				+ summary + ", price=" + price + "]";
	}
}

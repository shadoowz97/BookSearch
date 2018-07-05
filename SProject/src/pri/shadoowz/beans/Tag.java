package pri.shadoowz.beans;

public class Tag {
private int count;
private String name;
private String title;
public int getCount() {
	return count;
}
public void setCount(int count) {
	this.count = count;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
@Override
public String toString() {
	return "Tag [count=" + count + ", name=" + name + ", title=" + title + "]";
}

}

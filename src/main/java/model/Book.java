package model;

public class Book {

private int id;
private String title;
private String author;
private float price;
private int quantity;

public Book(int id, String title, String author, float price,int quantity) {
	super();
	id = id;
	title = title;
	author = author;
	price = price;
	quantity = quantity;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
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
public float getPrice() {
	return price;
}
public void setPrice(float price) {
	this.price = price;
}
public int getQuantity() {
	return quantity;
}
public void setQuantity(int quantity) {
	this.quantity = quantity;
}
}
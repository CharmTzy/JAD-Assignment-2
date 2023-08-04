package model;

public class Book {

private String image;
private int id;
private String title;
private String author;
private float price;
private String isbn;
private int quantity;

public Book() {
	
}

public Book(String image,int id, String title, String author, float price,String isbn,int quantity) {
	this.image = image;
	this.id = id;
    this.title = title;
    this.author = author;
    this.price = price;
    this.isbn = isbn;
    this.quantity = quantity;
}

public String getIsbn() {
	return isbn;
}

public void setIsbn(String isbn) {
	this.isbn = isbn;
}

public String getImage() {
	return image;
}

public void setImage(String image) {
	this.image = image;
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

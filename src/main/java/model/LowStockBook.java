package model;

public class LowStockBook {
    private String image;
    private int bookId;
    private String title;
    private String author;
    private double price;
    private String isbn;
    private int quantity;

    // Constructor
    public LowStockBook(String image, int bookId, String title, String author, double price, String isbn, int quantity) {
        this.image = image;
        this.bookId = bookId;
        this.title = title;
        this.author = author;
        this.price = price;
        this.isbn = isbn;
        this.quantity = quantity;
    }

    // Getters
    public String getImage() {
        return image;
    }

    public int getBookId() {
        return bookId;
    }

    public String getTitle() {
        return title;
    }

    public String getAuthor() {
        return author;
    }

    public double getPrice() {
        return price;
    }

    public String getIsbn() {
        return isbn;
    }

    public int getQuantity() {
        return quantity;
    }

    // Setters
    public void setImage(String image) {
        this.image = image;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}

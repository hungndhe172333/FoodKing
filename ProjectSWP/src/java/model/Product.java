/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author minhp
 */
public class Product {

    private int product_id;
    private String name;
    private String description;
    private double price;
    private int stock_quantity;
    private Category category_id;
    private String image;

    public Product() {
    }
    
    public Product(int product_id, String name, double price) {
        this.product_id = product_id;
        this.name = name;
        this.price = price;
    }
    
    public Product(int product_id, String name, String image) {
        this.product_id = product_id;
        this.name = name;
        this.image = image;
    }

    public Product(int product_id, String name, String description, double price, int stock_quantity, Category category_id, String image) {
        this.product_id = product_id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.category_id = category_id;
        this.image = image;
    }

    public Product(int product_id, String name) {
        this.product_id = product_id;
        this.name = name;
    }

    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public Category getCategory_id() {
        return category_id;
    }

    public void setCategory_id(Category category_id) {
        this.category_id = category_id;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "Product{" + "product_id=" + product_id + ", name=" + name + ", description=" + description + ", price=" + price + ", stock_quantity=" + stock_quantity + ", category_id=" + category_id + ", image=" + image + '}';
    }
    
    
}

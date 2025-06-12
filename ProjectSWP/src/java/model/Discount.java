/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author admin
 */
public class Discount {
    
    private int discountId;
    private String code;
    private double discountPercentage;

    public Discount() {
    }
    
    public Discount(int discountId, double discountPercentage) {
        this.discountId = discountId;
        this.discountPercentage = discountPercentage;
    }
    
    public Discount(String code, double discountPercentage) {
        this.code = code;
        this.discountPercentage = discountPercentage;
    }

    public Discount(int discountId, String code, double discountPercentage) {
        this.discountId = discountId;
        this.code = code;
        this.discountPercentage = discountPercentage;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscountPercentage() {
        return discountPercentage;
    }

    public void setDiscountPercentage(double discountPercentage) {
        this.discountPercentage = discountPercentage;
    }

    @Override
    public String toString() {
        return "Discount{" + "discountId=" + discountId + ", code=" + code + ", discountPercentage=" + discountPercentage + '}';
    }
    
    
    
}

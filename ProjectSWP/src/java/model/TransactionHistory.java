/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;


/**
 *
 * @author minhp
 */
public class TransactionHistory {
    private int transactionHistoryId;
    private Order order;
    private Employees employees;
    private double transactionAmount;
    private String transactionType;
    private Date transactionDate;
    private Revenue revenue;

    public TransactionHistory() {
    }
    
    public TransactionHistory(int transactionHistoryId, double transactionAmount, Revenue revenue) {
        this.transactionHistoryId = transactionHistoryId;
        this.transactionAmount = transactionAmount;
        this.revenue = revenue;
    }
    
    public TransactionHistory(double transactionAmount, Date transaction_date,String transactionType) {
        this.transactionAmount = transactionAmount;
        this.transactionDate = transaction_date;
        this.transactionType = transactionType;
    }
    
    public TransactionHistory(Order order, double transactionAmount) {
        this.order = order;
        this.transactionAmount = transactionAmount;
    }
    
    public TransactionHistory(int transactionHistoryId, Order order, double transactionAmount, String transactionType, Revenue revenue) {
        this.transactionHistoryId = transactionHistoryId;
        this.order = order;
        this.transactionAmount = transactionAmount;
        this.transactionType = transactionType;
        this.revenue = revenue;
    }

    public TransactionHistory(int transactionHistoryId, Order order, Employees employees, double transactionAmount, String transactionType, Revenue revenue) {
        this.transactionHistoryId = transactionHistoryId;
        this.order = order;
        this.employees = employees;
        this.transactionAmount = transactionAmount;
        this.transactionType = transactionType;
        this.revenue = revenue;
    }

    public int getTransactionHistoryId() {
        return transactionHistoryId;
    }

    public void setTransactionHistoryId(int transactionHistoryId) {
        this.transactionHistoryId = transactionHistoryId;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Employees getEmployees() {
        return employees;
    }

    public void setEmployees(Employees employees) {
        this.employees = employees;
    }

    public double getTransactionAmount() {
        return transactionAmount;
    }

    public void setTransactionAmount(double transactionAmount) {
        this.transactionAmount = transactionAmount;
    }

    public String getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(String transactionType) {
        this.transactionType = transactionType;
    }

    public Revenue getRevenue() {
        return revenue;
    }

    public void setRevenue(Revenue revenue) {
        this.revenue = revenue;
    }

    public Date getTransactionDate() {
        return transactionDate;
    }

    public void setTransactionDate(Date transactionDate) {
        this.transactionDate = transactionDate;
    }

    @Override
    public String toString() {
        return "TransactionHistory{" + "transactionHistoryId=" + transactionHistoryId + ", order=" + order + ", employees=" + employees + ", transactionAmount=" + transactionAmount + ", transactionType=" + transactionType + ", transactionDate=" + transactionDate + ", revenue=" + revenue + '}';
    }
    
}
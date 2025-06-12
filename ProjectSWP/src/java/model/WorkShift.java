/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author minhp
 */
public class WorkShift {
    private int shift_id;
    private Employees employee;
    private ShiftPattern shift_pattern;
    private double startAmount;
    private double endAmount;

    public WorkShift() {
    }
    
    public WorkShift(int shift_id, Employees employee, ShiftPattern shift_pattern) {
        this.shift_id = shift_id;
        this.employee = employee;
        this.shift_pattern = shift_pattern;
    }

    public WorkShift(int shift_id, Employees employee, ShiftPattern shift_pattern, double startAmount, double endAmount) {
        this.shift_id = shift_id;
        this.employee = employee;
        this.shift_pattern = shift_pattern;
        this.startAmount = startAmount;
        this.endAmount = endAmount;
    }

    public int getShift_id() {
        return shift_id;
    }

    public void setShift_id(int shift_id) {
        this.shift_id = shift_id;
    }

    public Employees getEmployee() {
        return employee;
    }

    public void setEmployee(Employees employee) {
        this.employee = employee;
    }

    public ShiftPattern getShift_pattern() {
        return shift_pattern;
    }

    public void setShift_pattern(ShiftPattern shift_pattern) {
        this.shift_pattern = shift_pattern;
    }

    public double getStartAmount() {
        return startAmount;
    }

    public void setStartAmount(double startAmount) {
        this.startAmount = startAmount;
    }

    public double getEndAmount() {
        return endAmount;
    }

    public void setEndAmount(double endAmount) {
        this.endAmount = endAmount;
    }

    
}

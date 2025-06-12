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
public class Salaries {
    private int salary_id;
    private Employees employee;
    private double total_salary;
    private double totalHoursWorked;
    private Date month_year;

    public Salaries() {
    }

    public Salaries(int salary_id, Employees employee, double total_salary, double totalHoursWorked, Date month_year) {
        this.salary_id = salary_id;
        this.employee = employee;
        this.total_salary = total_salary;
        this.totalHoursWorked = totalHoursWorked;
        this.month_year = month_year;
    }

    public int getSalary_id() {
        return salary_id;
    }

    public void setSalary_id(int salary_id) {
        this.salary_id = salary_id;
    }

    public Employees getEmployee() {
        return employee;
    }

    public void setEmployee(Employees employee) {
        this.employee = employee;
    }

    public double getTotal_salary() {
        return total_salary;
    }

    public void setTotal_salary(double total_salary) {
        this.total_salary = total_salary;
    }

    public double getTotalHoursWorked() {
        return totalHoursWorked;
    }

    public void setTotalHoursWorked(double totalHoursWorked) {
        this.totalHoursWorked = totalHoursWorked;
    }

    public Date getMonth_year() {
        return month_year;
    }

    public void setMonth_year(Date month_year) {
        this.month_year = month_year;
    }

    @Override
    public String toString() {
        return "Salaries{" + "salary_id=" + salary_id + ", employee=" + employee + ", total_salary=" + total_salary + ", totalHoursWorked=" + totalHoursWorked + ", month_year=" + month_year + '}';
    }
    

    
}

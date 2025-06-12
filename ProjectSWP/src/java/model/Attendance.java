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
public class Attendance {
    private int attendance_id;
    private WorkShift workShift;
    private String attendance_status;
    private Date working_date;

    public Attendance() {
    }

    public Attendance(int attendance_id, WorkShift workShift, String attendance_status, Date working_date) {
        this.attendance_id = attendance_id;
        this.workShift = workShift;
        this.attendance_status = attendance_status;
        this.working_date = working_date;
    }

    public int getAttendance_id() {
        return attendance_id;
    }

    public void setAttendance_id(int attendance_id) {
        this.attendance_id = attendance_id;
    }

    public WorkShift getWorkShift() {
        return workShift;
    }

    public void setWorkShift(WorkShift workShift) {
        this.workShift = workShift;
    }

    public String getAttendance_status() {
        return attendance_status;
    }

    public void setAttendance_status(String attendance_status) {
        this.attendance_status = attendance_status;
    }

    public Date getWorking_date() {
        return working_date;
    }

    public void setWorking_date(Date working_date) {
        this.working_date = working_date;
    }
}
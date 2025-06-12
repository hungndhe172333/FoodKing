/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author minhp
 */
import java.sql.Time;

public class ShiftPattern {
    private int pattern_id;
    private String pattern_name;
    private Time start_time;
    private Time end_time;

    public ShiftPattern() {
    }
    
     public ShiftPattern(int pattern_id, String pattern_name) {
        this.pattern_id = pattern_id;
        this.pattern_name = pattern_name;
    }

    public ShiftPattern(int pattern_id, String pattern_name, Time start_time, Time end_time) {
        this.pattern_id = pattern_id;
        this.pattern_name = pattern_name;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public int getPattern_id() {
        return pattern_id;
    }

    public void setPattern_id(int pattern_id) {
        this.pattern_id = pattern_id;
    }

    public String getPattern_name() {
        return pattern_name;
    }

    public void setPattern_name(String pattern_name) {
        this.pattern_name = pattern_name;
    }

    public Time getStart_time() {
        return start_time;
    }

    public void setStart_time(Time start_time) {
        this.start_time = start_time;
    }

    public Time getEnd_time() {
        return end_time;
    }

    public void setEnd_time(Time end_time) {
        this.end_time = end_time;
    }

    @Override
    public String toString() {
        return "ShiftPattern{" + "pattern_id=" + pattern_id + ", pattern_name=" + pattern_name + ", start_time=" + start_time + ", end_time=" + end_time + '}';
    }
    
    
}

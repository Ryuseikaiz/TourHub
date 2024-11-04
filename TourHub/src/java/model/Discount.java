/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author TRONG DUC
 */
public class Discount {

    private int discount_Id;
    private String code;
    private int quantity;
    private double percent_Discount;
    private Date start_Day;
    private Date end_Day;
    private String require;
    private String tour_Id;
    private String description;
    private String tour_name;

    public Discount(int discount_Id, String code, int quantity, double percent_Discount, Date start_Day, Date end_Day, String require, String tour_Id, String description) {
        this.discount_Id = discount_Id;
        this.code = code;
        this.quantity = quantity;
        this.percent_Discount = percent_Discount;
        this.start_Day = start_Day;
        this.end_Day = end_Day;
        this.require = require;
        this.tour_Id = tour_Id;
        this.description = description;
    }

    public Discount() {
    }

    public String getTour_name() {
        return tour_name;
    }

    public void setTour_name(String tour_name) {
        this.tour_name = tour_name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getDiscount_Id() {
        return discount_Id;
    }

    public void setDiscount_Id(int discount_Id) {
        this.discount_Id = discount_Id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPercent_Discount() {
        return percent_Discount;
    }

    public void setPercent_Discount(double percent_Discount) {
        this.percent_Discount = percent_Discount;
    }

    public Date getStart_Day() {
        return start_Day;
    }

    public void setStart_Day(Date start_Day) {
        this.start_Day = start_Day;
    }

    public Date getEnd_Day() {
        return end_Day;
    }

    public void setEnd_Day(Date end_Day) {
        this.end_Day = end_Day;
    }

    public String getRequire() {
        return require;
    }

    public void setRequire(String require) {
        this.require = require;
    }

    public String getTour_Id() {
        return tour_Id;
    }

    public void setTour_Id(String tour_Id) {
        this.tour_Id = tour_Id;
    }

    @Override
    public String toString() {
        return "Discount{" + "discount_Id=" + discount_Id + ", code=" + code + ", quantity=" + quantity + ", percent_Discount=" + percent_Discount + ", start_Day=" + start_Day + ", end_Day=" + end_Day + ", require=" + require + ", tour_Id=" + tour_Id + ", description=" + description + '}';
    }

}

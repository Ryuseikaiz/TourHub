/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 *
 * @author NOMNOM
 */
public class Booking {

    private int book_Id;
    private Date created_At;
    private int slot_Order;
    private BigDecimal total_Cost;
    private String book_Status;
    private int cus_Id;
    private String tour_Id;
    private String tour_Name;
    private Date tour_Date;
    private Date cancel_Date;
    private String booking_Detail;
    private List<String> tour_Img;
    private String option_Name;
    private String cus_Name;
    private BigDecimal refundAmount;

    public Booking(int book_Id, Date created_At, int slot_Order, BigDecimal total_Cost, String book_Status, int cus_Id, String tour_Id, String tour_Name, Date tour_Date, Date cancel_Date) {
        this.book_Id = book_Id;
        this.created_At = created_At;
        this.slot_Order = slot_Order;
        this.total_Cost = total_Cost;
        this.book_Status = book_Status;
        this.cus_Id = cus_Id;
        this.tour_Id = tour_Id;
        this.tour_Name = tour_Name;
        this.tour_Date = tour_Date;
        this.cancel_Date = cancel_Date;
    }

    public Booking(int book_Id, Date created_At, int slot_Order, BigDecimal total_Cost, String book_Status, int cus_Id, String tour_Id, String tour_Name, Date tour_Date, Date cancel_Date, String booking_Detail, List<String> tour_Img, String option_Name) {
        this.book_Id = book_Id;
        this.created_At = created_At;
        this.slot_Order = slot_Order;
        this.total_Cost = total_Cost;
        this.book_Status = book_Status;
        this.cus_Id = cus_Id;
        this.tour_Id = tour_Id;
        this.tour_Name = tour_Name;
        this.tour_Date = tour_Date;
        this.cancel_Date = cancel_Date;
        this.booking_Detail = booking_Detail;
        this.tour_Img = tour_Img;
        this.option_Name = option_Name;
    }

    public Booking(int book_Id, Date created_At, int slot_Order, BigDecimal total_Cost, String book_Status, String tour_Name, Date tour_Date, Date cancel_Date, String booking_Detail, String cus_Name, BigDecimal refundAmount) {
        this.book_Id = book_Id;
        this.created_At = created_At;
        this.slot_Order = slot_Order;
        this.total_Cost = total_Cost;
        this.book_Status = book_Status;
        this.tour_Name = tour_Name;
        this.tour_Date = tour_Date;
        this.cancel_Date = cancel_Date;
        this.booking_Detail = booking_Detail;
        this.cus_Name = cus_Name;
        this.refundAmount = refundAmount;
    }

//    public Booking(int book_Id, Date created_At, int slot_Order, BigDecimal total_Cost, String book_Status, int cus_Id, String tour_Id, String tour_Name, Date tour_Date, Date cancel_Date) {
//        this.book_Id = book_Id;
//        this.created_At = created_At;
//        this.slot_Order = slot_Order;
//        this.total_Cost = total_Cost;
//        this.book_Status = book_Status;
//        this.cus_Id = cus_Id;
//        this.tour_Id = tour_Id;
//        this.tour_Name = tour_Name;
//        this.tour_Date = tour_Date;
//        this.cancel_Date = cancel_Date;
//    }

    public Booking() {
    }

    public int getBook_Id() {
        return book_Id;
    }

    public void setBook_Id(int book_Id) {
        this.book_Id = book_Id;
    }

    public Date getCreated_At() {
        return created_At;
    }

    public void setCreated_At(Date created_At) {
        this.created_At = created_At;
    }

    public Date getTour_Date() {
        return tour_Date;
    }

    public void setTour_Date(Date tour_Date) {
        this.tour_Date = tour_Date;
    }

    public Date getCancel_Date() {
        return cancel_Date;
    }

    public void setCancel_Date(Date cancel_Date) {
        this.cancel_Date = cancel_Date;
    }

    public int getSlot_Order() {
        return slot_Order;
    }

    public void setSlot_Order(int slot_Order) {
        this.slot_Order = slot_Order;
    }

    public BigDecimal getTotal_Cost() {
        return total_Cost;
    }

    public void setTotal_Cost(BigDecimal total_Cost) {
        this.total_Cost = total_Cost;
    }

    public String getBook_Status() {
        return book_Status;
    }

    public void setBook_Status(String book_Status) {
        this.book_Status = book_Status;
    }

    public int getCus_Id() {
        return cus_Id;
    }

    public void setCus_Id(int cus_Id) {
        this.cus_Id = cus_Id;
    }

    public String getTour_Id() {
        return tour_Id;
    }

    public void setTour_Id(String tour_Id) {
        this.tour_Id = tour_Id;
    }

    public String getTour_Name() {
        return tour_Name;
    }

    public void setTour_Name(String tour_Name) {
        this.tour_Name = tour_Name;
    }

    public String getBooking_Detail() {
        return booking_Detail;
    }

    public void setBooking_Detail(String booking_Detail) {
        this.booking_Detail = booking_Detail;
    }

    public List<String> getTour_Img() {
        return tour_Img;
    }

    public void setTour_Img(List<String> tour_Img) {
        this.tour_Img = tour_Img;
    }

    public String getOption_Name() {
        return option_Name;
    }

    public void setOption_Name(String option_Name) {
        this.option_Name = option_Name;
    }

    public String getCus_Name() {
        return cus_Name;
    }

    public void setCus_Name(String cus_Name) {
        this.cus_Name = cus_Name;
    }

    public BigDecimal getRefundAmount() {
        return refundAmount;
    }

    public void setRefundAmount(BigDecimal refundAmount) {
        this.refundAmount = refundAmount;
    }
    
    
    @Override
    public String toString() {
        return "Booking{" + "book_Id=" + book_Id + ", created_At=" + created_At + ", slot_Order=" + slot_Order + ", total_Cost=" + total_Cost + ", book_Status=" + book_Status + ", cus_Id=" + cus_Id + ", tour_Id=" + tour_Id + ", tour_Name=" + tour_Name + ", tour_Date=" + tour_Date + ", cancel_Date=" + cancel_Date + ", booking_Detail=" + booking_Detail + '}';
    }

}

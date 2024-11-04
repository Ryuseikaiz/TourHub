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
public class Tour {

    private String tour_Id; //char(8)
    private String tour_Name;
    private String tour_Description;
    private Date start_Date;
    private Date end_Date;
    private String location;//Nhuan Duc, Cu Chi
    private int purchases_Time;
    private double average_Review_Rating;
    private int number_Of_Review;
    private String total_Time;
    private BigDecimal price; //covert sang int sau 
    private int slot;
    private String tour_Status;
    private Date created_At; //DATE DEFAULT GETDATE()
    private List<String> tour_Img;
    private int company_Id;

    public Tour() {
    }

    public Tour(String tour_Id, String tour_Name, String tour_Description, Date start_Date, Date end_Date, String location, int purchases_Time, double average_Review_Rating, int number_Of_Review, String total_Time, BigDecimal price, int slot, String tour_Status, Date created_At, List<String> tour_Img, int company_Id) {
        this.tour_Id = tour_Id;
        this.tour_Name = tour_Name;
        this.tour_Description = tour_Description;
        this.start_Date = start_Date;
        this.end_Date = end_Date;
        this.location = location;
        this.purchases_Time = purchases_Time;
        this.average_Review_Rating = average_Review_Rating;
        this.number_Of_Review = number_Of_Review;
        this.total_Time = total_Time;
        this.price = price;
        this.slot = slot;
        this.tour_Status = tour_Status;
        this.created_At = created_At;
        this.tour_Img = tour_Img;
        this.company_Id = company_Id;
    }

    public Tour(String tour_Name, String tour_Description, Date start_Date, Date end_Date, String location, String total_Time, BigDecimal price, int slot, Date created_At, int company_Id) {
        this.tour_Name = tour_Name;
        this.tour_Description = tour_Description;
        this.start_Date = start_Date;
        this.end_Date = end_Date;
        this.location = location;
        this.total_Time = total_Time;
        this.price = price;
        this.slot = slot;
        this.created_At = created_At;
        this.company_Id = company_Id;
    }

    public Tour(String tour_Name, String tour_Description, Date start_Date, Date end_Date, String location, String total_Time, BigDecimal price, int slot, String tour_Status, Date created_At) {
        this.tour_Name = tour_Name;
        this.tour_Description = tour_Description;
        this.start_Date = start_Date;
        this.end_Date = end_Date;
        this.location = location;
        this.total_Time = total_Time;
        this.price = price;
        this.slot = slot;
        this.tour_Status = tour_Status;
        this.created_At = created_At;
    }

    public Tour(String tour_Name, String tour_Description, Date start_Date, Date end_Date, String location, String total_Time, int slot, String tour_Status, Date created_At) {
        this.tour_Name = tour_Name;
        this.tour_Description = tour_Description;
        this.start_Date = start_Date;
        this.end_Date = end_Date;
        this.location = location;
        this.total_Time = total_Time;
        this.slot = slot;
        this.tour_Status = tour_Status;
        this.created_At = created_At;
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

    public String getTour_Description() {
        return tour_Description;
    }

    public void setTour_Description(String tour_Description) {
        this.tour_Description = tour_Description;
    }

    public Date getStart_Date() {
        return start_Date;
    }

    public void setStart_Date(Date start_Date) {
        this.start_Date = start_Date;
    }

    public Date getEnd_Date() {
        return end_Date;
    }

    public void setEnd_Date(Date end_Date) {
        this.end_Date = end_Date;

    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getPurchases_Time() {
        return purchases_Time;
    }

    public void setPurchases_Time(int purchases_Time) {
        this.purchases_Time = purchases_Time;
    }

    public double getAverage_Review_Rating() {
        return average_Review_Rating;
    }

    public void setAverage_Review_Rating(double average_Review_Rating) {
        this.average_Review_Rating = average_Review_Rating;
    }

    public int getNumber_Of_Review() {
        return number_Of_Review;
    }

    public void setNumber_Of_Review(int number_Of_Review) {
        this.number_Of_Review = number_Of_Review;
    }

    public String getTotal_Time() {
        return total_Time;
    }

    public void setTotal_Time(String total_Time) {
        this.total_Time = total_Time;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getSlot() {
        return slot;
    }

    public void setSlot(int slot) {
        this.slot = slot;
    }

    public String getTour_Status() {
        return tour_Status;
    }

    public void setTour_Status(String tour_Status) {
        this.tour_Status = tour_Status;
    }

    public Date getCreated_At() {
        return created_At;
    }

    public void setCreated_At(Date created_At) {
        this.created_At = created_At;
    }

    public List<String> getTour_Img() {
        return tour_Img;
    }

    public void setTour_Img(List<String> tour_Img) {
        this.tour_Img = tour_Img;
    }

    public int getCompany_Id() {
        return company_Id;
    }

    public void setCompany_Id(int company_Id) {
        this.company_Id = company_Id;
    }

    @Override
    public String toString() {
        return "Tour{" + "tour_Id=" + tour_Id + ", tour_Name=" + tour_Name + ", tour_Description=" + tour_Description + ", start_Date=" + start_Date + ", end_Date=" + end_Date + ", location=" + location + ", purchases_Time=" + purchases_Time + ", average_Review_Rating=" + average_Review_Rating + ", number_Of_Review=" + number_Of_Review + ", total_Time=" + total_Time + ", price=" + price + ", slot=" + slot + ", tour_Status=" + tour_Status + ", created_At=" + created_At + ", tour_Img=" + tour_Img + ", company_Id=" + company_Id + '}';
    }

}

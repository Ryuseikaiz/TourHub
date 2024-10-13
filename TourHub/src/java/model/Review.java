/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.List;

/**
 *
 * @author TRONG DUC
 */
public class Review {

    private int review_Id;
    private String comment;
    private int rating_Star;
    private int user_Id;
    private String tour_Id;
    private String first_Name;
    private String last_Name;
    private List<ReviewReply> replies;

    public Review() {
    }

    public Review(int review_Id, String comment, int rating_Star, int user_Id, String tour_Id, String first_Name, String last_Name, List<ReviewReply> replies) {
        this.review_Id = review_Id;
        this.comment = comment;
        this.rating_Star = rating_Star;
        this.user_Id = user_Id;
        this.tour_Id = tour_Id;
        this.first_Name = first_Name;
        this.last_Name = last_Name;
        this.replies = replies;
    }

    public List<ReviewReply> getReplies() {
        return replies;
    }

    public void setReplies(List<ReviewReply> replies) {
        this.replies = replies;
    }

    public String getFirst_Name() {
        return first_Name;
    }

    public void setFirst_Name(String first_Name) {
        this.first_Name = first_Name;
    }

    public String getLast_Name() {
        return last_Name;
    }

    public void setLast_Name(String last_Name) {
        this.last_Name = last_Name;
    }

    public int getReview_Id() {
        return review_Id;
    }

    public void setReview_Id(int review_Id) {
        this.review_Id = review_Id;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getRating_Star() {
        return rating_Star;
    }

    public void setRating_Star(int rating_Star) {
        this.rating_Star = rating_Star;
    }

    public int getUser_Id() {
        return user_Id;
    }

    public void setUser_Id(int user_Id) {
        this.user_Id = user_Id;
    }

    public String getTour_Id() {
        return tour_Id;
    }

    public void setTour_Id(String tour_Id) {
        this.tour_Id = tour_Id;
    }

}

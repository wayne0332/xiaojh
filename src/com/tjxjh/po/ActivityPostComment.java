package com.tjxjh.po;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * ActivityPostComment entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="activity_post_comment"
    ,catalog="xiaojh"
)

public class ActivityPostComment  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private User user;
     private ActivityPost activityPost;
     private Timestamp datetime;
     private String text;


    // Constructors

    /** default constructor */
    public ActivityPostComment() {
    }

    
    /** full constructor */
    public ActivityPostComment(User user, ActivityPost activityPost, Timestamp datetime, String text) {
        this.user = user;
        this.activityPost = activityPost;
        this.datetime = datetime;
        this.text = text;
    }

   
    // Property accessors
    @Id @GeneratedValue
    
    @Column(name="id", unique=true, nullable=false)

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
	@ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="user_id", nullable=false)

    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
	@ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="activity_post_id", nullable=false)

    public ActivityPost getActivityPost() {
        return this.activityPost;
    }
    
    public void setActivityPost(ActivityPost activityPost) {
        this.activityPost = activityPost;
    }
    
    @Column(name="datetime", nullable=false, length=19, insertable=false)

    public Timestamp getDatetime() {
        return this.datetime;
    }
    
    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }
    
    @Column(name="text", nullable=false, length=300)

    public String getText() {
        return this.text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
   








}
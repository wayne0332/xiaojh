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
 * ClubPostComment entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="club_post_comment"
    ,catalog="xiaojh"
)

public class ClubPostComment  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private User user;
     private ClubPost clubPost;
     private Timestamp datetime;
     private String text;


    // Constructors

    /** default constructor */
    public ClubPostComment() {
    }

    
    /** full constructor */
    public ClubPostComment(User user, ClubPost clubPost, Timestamp datetime, String text) {
        this.user = user;
        this.clubPost = clubPost;
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
        @JoinColumn(name="club_post_id", nullable=false)

    public ClubPost getClubPost() {
        return this.clubPost;
    }
    
    public void setClubPost(ClubPost clubPost) {
        this.clubPost = clubPost;
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
package com.tjxjh.po;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;

import com.tjxjh.enumeration.OnlineActivityStatus;


/**
 * OnlineActivity entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="online_activity"
    ,catalog="xiaojh"
)

public class OnlineActivity  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Talking talking;
     private User user;
     private String tittle;
     private String text;
     private Timestamp datetime;
     private String videoUrl;
     private String titleImgPath;
     private Integer heat;
     private OnlineActivityStatus status;
     private Integer participantCount;
     private Integer praiseCount;
     private Set<ActivityPost> activityPosts = new HashSet<ActivityPost>(0);


    // Constructors

    /** default constructor */
    public OnlineActivity() {
    }

	/** minimal constructor */
    public OnlineActivity(Talking talking, User user, String tittle, String text, Timestamp datetime, String titleImgPath, Integer heat, OnlineActivityStatus status, Integer participantCount, Integer praiseCount) {
        this.talking = talking;
        this.user = user;
        this.tittle = tittle;
        this.text = text;
        this.datetime = datetime;
        this.titleImgPath = titleImgPath;
        this.heat = heat;
        this.status = status;
        this.participantCount = participantCount;
        this.praiseCount = praiseCount;
    }
    
    /** full constructor */
    public OnlineActivity(Talking talking, User user, String tittle, String text, Timestamp datetime, String videoUrl, String titleImgPath, Integer heat, OnlineActivityStatus status, Integer participantCount, Integer praiseCount, Set<ActivityPost> activityPosts) {
        this.talking = talking;
        this.user = user;
        this.tittle = tittle;
        this.text = text;
        this.datetime = datetime;
        this.videoUrl = videoUrl;
        this.titleImgPath = titleImgPath;
        this.heat = heat;
        this.status = status;
        this.participantCount = participantCount;
        this.praiseCount = praiseCount;
        this.activityPosts = activityPosts;
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
        @JoinColumn(name="talking_id", nullable=false)

    public Talking getTalking() {
        return this.talking;
    }
    
    public void setTalking(Talking talking) {
        this.talking = talking;
    }
	@ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="hold_user_id", nullable=false)

    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    @Column(name="tittle", nullable=false, length=200)

    public String getTittle() {
        return this.tittle;
    }
    
    public void setTittle(String tittle) {
        this.tittle = tittle;
    }
    
    @Column(name="text", nullable=false, length=65535)

    public String getText() {
        return this.text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    
    @Column(name="datetime", nullable=false, length=19, insertable=false)

    public Timestamp getDatetime() {
        return this.datetime;
    }
    
    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }
    
    @Column(name="video_url", length=500)

    public String getVideoUrl() {
        return this.videoUrl;
    }
    
    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }
    
    @Column(name="title_img_path", nullable=false, length=250)

    public String getTitleImgPath() {
        return this.titleImgPath;
    }
    
    public void setTitleImgPath(String titleImgPath) {
        this.titleImgPath = titleImgPath;
    }
    
    @Column(name="heat", nullable=false, insertable=false)

    public Integer getHeat() {
        return this.heat;
    }
    
    public void setHeat(Integer heat) {
        this.heat = heat;
    }
    
    @Column(name="status", nullable=false, length=45)
    @Enumerated(EnumType.STRING)
    public OnlineActivityStatus getStatus() {
        return this.status;
    }
    
    public void setStatus(OnlineActivityStatus underway) {
        this.status = underway;
    }
    
    @Column(name="participant_count", nullable=false, insertable=false)

    public Integer getParticipantCount() {
        return this.participantCount;
    }
    
    public void setParticipantCount(Integer participantCount) {
        this.participantCount = participantCount;
    }
    
    @Column(name="praise_count", nullable=false, insertable=false)

    public Integer getPraiseCount() {
        return this.praiseCount;
    }
    
    public void setPraiseCount(Integer praiseCount) {
        this.praiseCount = praiseCount;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="onlineActivity")
@Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE,org.hibernate.annotations.CascadeType.DELETE_ORPHAN})
    public Set<ActivityPost> getActivityPosts() {
        return this.activityPosts;
    }
    
    public void setActivityPosts(Set<ActivityPost> activityPosts) {
        this.activityPosts = activityPosts;
    }
   








}
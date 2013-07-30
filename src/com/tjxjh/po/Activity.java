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
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.tjxjh.enumeration.ActivityStatus;


/**
 * Activity entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="activity"
    ,catalog="xiaojh"
)

public class Activity  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Merchant merchant;
     private Club club;
     private Talking talking;
     private String tittle;
     private String text;
     private Timestamp datetime;
     private String videoUrl;
     private String titleImgPath;
     private String place;
     private String organizer;
     private Integer heat;
     private String budget;
     private ActivityStatus status;
     private Integer participantCount;
     private Set<User> users = new HashSet<User>(0);


    // Constructors

    /** default constructor */
    public Activity() {
    }

	/** minimal constructor */
    public Activity(Talking talking, String tittle, String text, Timestamp datetime, String titleImgPath, String place, String organizer, Integer heat, String budget, ActivityStatus status, Integer participantCount) {
        this.talking = talking;
        this.tittle = tittle;
        this.text = text;
        this.datetime = datetime;
        this.titleImgPath = titleImgPath;
        this.place = place;
        this.organizer = organizer;
        this.heat = heat;
        this.budget = budget;
        this.status = status;
        this.participantCount = participantCount;
    }
    
    /** full constructor */
    public Activity(Merchant merchant, Club club, Talking talking, String tittle, String text, Timestamp datetime, String videoUrl, String titleImgPath, String place, String organizer, Integer heat, String budget, ActivityStatus status, Integer participantCount, Set<User> users) {
        this.merchant = merchant;
        this.club = club;
        this.talking = talking;
        this.tittle = tittle;
        this.text = text;
        this.datetime = datetime;
        this.videoUrl = videoUrl;
        this.titleImgPath = titleImgPath;
        this.place = place;
        this.organizer = organizer;
        this.heat = heat;
        this.budget = budget;
        this.status = status;
        this.participantCount = participantCount;
        this.users = users;
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
        @JoinColumn(name="hold_merchant_id")

    public Merchant getMerchant() {
        return this.merchant;
    }
    
    public void setMerchant(Merchant merchant) {
        this.merchant = merchant;
    }
	@ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="hold_club_id")

    public Club getClub() {
        return this.club;
    }
    
    public void setClub(Club club) {
        this.club = club;
    }
	@ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="talking_id", nullable=false)

    public Talking getTalking() {
        return this.talking;
    }
    
    public void setTalking(Talking talking) {
        this.talking = talking;
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
    
    @Column(name="place", nullable=false, length=200)

    public String getPlace() {
        return this.place;
    }
    
    public void setPlace(String place) {
        this.place = place;
    }
    
    @Column(name="organizer", nullable=false, length=500)

    public String getOrganizer() {
        return this.organizer;
    }
    
    public void setOrganizer(String organizer) {
        this.organizer = organizer;
    }
    
    @Column(name="heat", nullable=false, insertable=false)

    public Integer getHeat() {
        return this.heat;
    }
    
    public void setHeat(Integer heat) {
        this.heat = heat;
    }
    
    @Column(name="budget", nullable=false, length=100)

    public String getBudget() {
        return this.budget;
    }
    
    public void setBudget(String budget) {
        this.budget = budget;
    }
    
    @Column(name="status", nullable=false, length=45)
    @Enumerated(EnumType.STRING)
    public ActivityStatus getStatus() {
        return this.status;
    }
    
    public void setStatus(ActivityStatus status) {
        this.status = status;
    }
    
    @Column(name="participant_count", nullable=false, insertable=false)

    public Integer getParticipantCount() {
        return this.participantCount;
    }
    
    public void setParticipantCount(Integer participantCount) {
        this.participantCount = participantCount;
    }
@ManyToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="activities")

    public Set<User> getUsers() {
        return this.users;
    }
    
    public void setUsers(Set<User> users) {
        this.users = users;
    }
   








}
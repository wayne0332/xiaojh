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
 * ClubNews entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="club_news"
    ,catalog="xiaojh"
)

public class ClubNews  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Talking talking;
     private Club club;
     private String tittle;
     private Timestamp datetime;
     private String text;
     private String titleImgPath;
     private String videoUrl;


    // Constructors

    /** default constructor */
    public ClubNews() {
    }

	/** minimal constructor */
    public ClubNews(Talking talking, Club club, String tittle, Timestamp datetime, String text, String titleImgPath) {
        this.talking = talking;
        this.club = club;
        this.tittle = tittle;
        this.datetime = datetime;
        this.text = text;
        this.titleImgPath = titleImgPath;
    }
    
    /** full constructor */
    public ClubNews(Talking talking, Club club, String tittle, Timestamp datetime, String text, String titleImgPath, String videoUrl) {
        this.talking = talking;
        this.club = club;
        this.tittle = tittle;
        this.datetime = datetime;
        this.text = text;
        this.titleImgPath = titleImgPath;
        this.videoUrl = videoUrl;
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
        @JoinColumn(name="club_id", nullable=false)

    public Club getClub() {
        return this.club;
    }
    
    public void setClub(Club club) {
        this.club = club;
    }
    
    @Column(name="tittle", nullable=false, length=200)

    public String getTittle() {
        return this.tittle;
    }
    
    public void setTittle(String tittle) {
        this.tittle = tittle;
    }
    
    @Column(name="datetime", nullable=false, length=19, insertable=false)

    public Timestamp getDatetime() {
        return this.datetime;
    }
    
    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }
    
    @Column(name="text", nullable=false, length=65535)

    public String getText() {
        return this.text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    
    @Column(name="title_img_path", nullable=false, length=250)

    public String getTitleImgPath() {
        return this.titleImgPath;
    }
    
    public void setTitleImgPath(String titleImgPath) {
        this.titleImgPath = titleImgPath;
    }
    
    @Column(name="video_url", length=500)

    public String getVideoUrl() {
        return this.videoUrl;
    }
    
    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }
   








}
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
 * Announcement entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="announcement"
    ,catalog="xiaojh"
)

public class Announcement  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Club club;
     private Timestamp datetime;
     private String title;
     private String text;


    // Constructors

    /** default constructor */
    public Announcement() {
    }

	/** minimal constructor */
    public Announcement(Timestamp datetime, String title, String text) {
        this.datetime = datetime;
        this.title = title;
        this.text = text;
    }
    
    /** full constructor */
    public Announcement(Club club, Timestamp datetime, String title, String text) {
        this.club = club;
        this.datetime = datetime;
        this.title = title;
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
        @JoinColumn(name="club_id")

    public Club getClub() {
        return this.club;
    }
    
    public void setClub(Club club) {
        this.club = club;
    }
    
    @Column(name="datetime", nullable=false, length=19, insertable=false)

    public Timestamp getDatetime() {
        return this.datetime;
    }
    
    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }
    
    @Column(name="title", nullable=false, length=200)

    public String getTitle() {
        return this.title;
    }
    
    public void setTitle(String title) {
        this.title = title;
    }
    
    @Column(name="text", nullable=false, length=300)

    public String getText() {
        return this.text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
   








}
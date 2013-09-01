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
 * TalkingComment entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="talking_comment"
    ,catalog="xiaojh"
)

public class TalkingComment  implements java.io.Serializable,Comparable<TalkingComment> {


    // Fields    

     private Integer id;
     private User user;
     private Talking talking;
     private Timestamp datetime;
     private String text;


    // Constructors

    /** default constructor */
    public TalkingComment() {
    }

    
    /** full constructor */
    public TalkingComment(User user, Talking talking, Timestamp datetime, String text) {
        this.user = user;
        this.talking = talking;
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
        @JoinColumn(name="talking_id", nullable=false)

    public Talking getTalking() {
        return this.talking;
    }
    
    public void setTalking(Talking talking) {
        this.talking = talking;
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
   
    @Override
   	public int compareTo(TalkingComment u) {
   		return u.getId()-this.getId();
   	}








}
package com.tjxjh.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;
import javax.persistence.Table;


/**
 * ShareDetails entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="share_details"
    ,catalog="xiaojh"
)

public class ShareDetails  implements java.io.Serializable {


    // Fields    

     private Integer talkingId;
     private Talking talking;
     private Integer shareCount;
     private Integer praiseCount;


    // Constructors

    /** default constructor */
    public ShareDetails() {
    }

    
    /** full constructor */
    public ShareDetails(Talking talking, Integer shareCount, Integer praiseCount) {
        this.talking = talking;
        this.shareCount = shareCount;
        this.praiseCount = praiseCount;
    }

   
    // Property accessors
    @Id @GeneratedValue
    
    @Column(name="talking_id", unique=true, nullable=false)

    public Integer getTalkingId() {
        return this.talkingId;
    }
    
    public void setTalkingId(Integer talkingId) {
        this.talkingId = talkingId;
    }
	@OneToOne(fetch=FetchType.LAZY)@PrimaryKeyJoinColumn

    public Talking getTalking() {
        return this.talking;
    }
    
    public void setTalking(Talking talking) {
        this.talking = talking;
    }
    
    @Column(name="share_count", nullable=false)

    public Integer getShareCount() {
        return this.shareCount;
    }
    
    public void setShareCount(Integer shareCount) {
        this.shareCount = shareCount;
    }
    
    @Column(name="praise_count", nullable=false)

    public Integer getPraiseCount() {
        return this.praiseCount;
    }
    
    public void setPraiseCount(Integer praiseCount) {
        this.praiseCount = praiseCount;
    }
   








}
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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.tjxjh.enumeration.TalkingStatus;
import com.tjxjh.enumeration.TalkingUrlType;


/**
 * Talking entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="talking"
    ,catalog="xiaojh"
)

public class Talking  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private User user;
     private Talking talking;
     private String text;
     private Timestamp datetime;
     private String url;
     private TalkingUrlType urlType;
     private TalkingStatus status;
     private Set<ClubNews> clubNewses = new HashSet<ClubNews>(0);
     private Set<TalkingComment> talkingComments = new HashSet<TalkingComment>(0);
     private Set<Talking> talkings = new HashSet<Talking>(0);
     private Set<OnlineActivity> onlineActivities = new HashSet<OnlineActivity>(0);
     private ShareDetails shareDetails;
     private Set<Activity> activities = new HashSet<Activity>(0);


    // Constructors

    /** default constructor */
    public Talking() {
    }

	/** minimal constructor */
    public Talking(User user, String text, Timestamp datetime, TalkingStatus status) {
        this.user = user;
        this.text = text;
        this.datetime = datetime;
        this.status = status;
    }
    
    /** full constructor */
    public Talking(User user, Talking talking, String text, Timestamp datetime, String url, TalkingUrlType urlType, TalkingStatus status, Set<ClubNews> clubNewses, Set<TalkingComment> talkingComments, Set<Talking> talkings, Set<OnlineActivity> onlineActivities, ShareDetails shareDetails, Set<Activity> activities) {
        this.user = user;
        this.talking = talking;
        this.text = text;
        this.datetime = datetime;
        this.url = url;
        this.urlType = urlType;
        this.status = status;
        this.clubNewses = clubNewses;
        this.talkingComments = talkingComments;
        this.talkings = talkings;
        this.onlineActivities = onlineActivities;
        this.shareDetails = shareDetails;
        this.activities = activities;
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
        @JoinColumn(name="share_talking_id")

    public Talking getTalking() {
        return this.talking;
    }
    
    public void setTalking(Talking talking) {
        this.talking = talking;
    }
    
    @Column(name="text", nullable=false, length=300)

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
    
    @Column(name="url", length=500)

    public String getUrl() {
        return this.url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
    
    @Column(name="url_type", length=45)
    @Enumerated(EnumType.STRING)
    public TalkingUrlType getUrlType() {
        return this.urlType;
    }
    
    public void setUrlType(TalkingUrlType urlType) {
        this.urlType = urlType;
    }
    
    @Column(name="status", nullable=false, length=45)
    @Enumerated(EnumType.STRING)
    public TalkingStatus getStatus() {
        return this.status;
    }
    
    public void setStatus(TalkingStatus status) {
        this.status = status;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="talking")

    public Set<ClubNews> getClubNewses() {
        return this.clubNewses;
    }
    
    public void setClubNewses(Set<ClubNews> clubNewses) {
        this.clubNewses = clubNewses;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="talking")

    public Set<TalkingComment> getTalkingComments() {
        return this.talkingComments;
    }
    
    public void setTalkingComments(Set<TalkingComment> talkingComments) {
        this.talkingComments = talkingComments;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="talking")

    public Set<Talking> getTalkings() {
        return this.talkings;
    }
    
    public void setTalkings(Set<Talking> talkings) {
        this.talkings = talkings;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="talking")

    public Set<OnlineActivity> getOnlineActivities() {
        return this.onlineActivities;
    }
    
    public void setOnlineActivities(Set<OnlineActivity> onlineActivities) {
        this.onlineActivities = onlineActivities;
    }
	@OneToOne(fetch=FetchType.LAZY, mappedBy="talking")

    public ShareDetails getShareDetails() {
        return this.shareDetails;
    }
    
    public void setShareDetails(ShareDetails shareDetails) {
        this.shareDetails = shareDetails;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="talking")

    public Set<Activity> getActivities() {
        return this.activities;
    }
    
    public void setActivities(Set<Activity> activities) {
        this.activities = activities;
    }
   








}
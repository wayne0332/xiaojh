package com.tjxjh.po;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.Cascade;

/**
 * ActivityPost entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "activity_post", catalog = "xiaojh")
public class ActivityPost implements java.io.Serializable
{
	// Fields
	private Integer id;
	private User user;
	private OnlineActivity onlineActivity;
	private String text;
	private Timestamp datetime;
	private Integer praiseCount;
	private String title;
	private Set<ActivityPostComment> activityPostComments = new HashSet<ActivityPostComment>(
			0);
	
	// Constructors
	/** default constructor */
	public ActivityPost()
	{}
	
	/** minimal constructor */
	public ActivityPost(User user, OnlineActivity onlineActivity, String title,
			String text, Timestamp datetime, Integer praiseCount)
	{
		this.user = user;
		this.onlineActivity = onlineActivity;
		this.text = text;
		this.datetime = datetime;
		this.praiseCount = praiseCount;
		this.title = title;
	}
	
	/** full constructor */
	public ActivityPost(User user, OnlineActivity onlineActivity, String title,
			String text, Timestamp datetime, Integer praiseCount,
			Set<ActivityPostComment> activityPostComments)
	{
		this.user = user;
		this.onlineActivity = onlineActivity;
		this.text = text;
		this.datetime = datetime;
		this.praiseCount = praiseCount;
		this.activityPostComments = activityPostComments;
		this.title = title;
	}
	
	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId()
	{
		return this.id;
	}
	
	public void setId(Integer id)
	{
		this.id = id;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	public User getUser()
	{
		return this.user;
	}
	
	public void setUser(User user)
	{
		this.user = user;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "online_activity_id", nullable = false)
	public OnlineActivity getOnlineActivity()
	{
		return this.onlineActivity;
	}
	
	public void setOnlineActivity(OnlineActivity onlineActivity)
	{
		this.onlineActivity = onlineActivity;
	}
	
	@Column(name = "text", nullable = false, length = 65535)
	public String getText()
	{
		return this.text;
	}
	
	public void setText(String text)
	{
		this.text = text;
	}
	
	@Column(name = "datetime", nullable = false, length = 19, insertable = false)
	public Timestamp getDatetime()
	{
		return this.datetime;
	}
	
	public void setDatetime(Timestamp datetime)
	{
		this.datetime = datetime;
	}
	
	@Column(name = "praise_count", nullable = false, insertable = false)
	public Integer getPraiseCount()
	{
		return this.praiseCount;
	}
	
	public void setPraiseCount(Integer praiseCount)
	{
		this.praiseCount = praiseCount;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "activityPost")
	@Cascade({org.hibernate.annotations.CascadeType.SAVE_UPDATE,org.hibernate.annotations.CascadeType.DELETE_ORPHAN})
	public Set<ActivityPostComment> getActivityPostComments()
	{
		return this.activityPostComments;
	}
	
	public void setActivityPostComments(
			Set<ActivityPostComment> activityPostComments)
	{
		this.activityPostComments = activityPostComments;
	}

	@Column(name = "title", nullable = false, length = 200)
	public String getTitle()
	{
		return title;
	}

	public void setTitle(String title)
	{
		this.title = title;
	}
}

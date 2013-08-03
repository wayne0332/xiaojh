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

/**
 * ClubPost entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "club_post", catalog = "xiaojh")
public class ClubPost implements java.io.Serializable
{
	// Fields
	private Integer id;
	private User user;
	private Club club;
	private String text;
	private String tittle;
	private Timestamp datetime;
	private Integer praiseCount;
	private Set<ClubPostComment> clubPostComments = new HashSet<ClubPostComment>(
			0);
	
	// Constructors
	/** default constructor */
	public ClubPost()
	{}
	
	/** minimal constructor */
	public ClubPost(User user, Club club, String text, String tittle,
			Timestamp datetime, Integer praiseCount)
	{
		this.user = user;
		this.club = club;
		this.text = text;
		this.tittle = tittle;
		this.datetime = datetime;
		this.praiseCount = praiseCount;
	}
	
	/** full constructor */
	public ClubPost(User user, Club club, String text, String tittle,
			Timestamp datetime, Integer praiseCount,
			Set<ClubPostComment> clubPostComments)
	{
		this.user = user;
		this.club = club;
		this.text = text;
		this.tittle = tittle;
		this.datetime = datetime;
		this.praiseCount = praiseCount;
		this.clubPostComments = clubPostComments;
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
	@JoinColumn(name = "club_id", nullable = false)
	public Club getClub()
	{
		return this.club;
	}
	
	public void setClub(Club club)
	{
		this.club = club;
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
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "clubPost")
	public Set<ClubPostComment> getClubPostComments()
	{
		return this.clubPostComments;
	}
	
	public void setClubPostComments(Set<ClubPostComment> clubPostComments)
	{
		this.clubPostComments = clubPostComments;
	}
	
	@Column(name = "title", nullable = false, length = 200)
	public String getTittle()
	{
		return this.tittle;
	}
	
	public void setTittle(String tittle)
	{
		this.tittle = tittle;
	}
}

package com.tjxjh.po;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.tjxjh.enumeration.PersonalLetterStatus;

/**
 * PersonalLetter entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "personal_letter", catalog = "xiaojh")
public class PersonalLetter implements java.io.Serializable
{
	// Fields
	private Integer id;
	private User userByTargetUserId;
	private User userBySourceUserId;
	private String text;
	private String title;
	private Timestamp datetime;
	private PersonalLetterStatus status;
	
	// Constructors
	/** default constructor */
	public PersonalLetter()
	{}
	
	/** full constructor */
	public PersonalLetter(User userByTargetUserId, User userBySourceUserId,
			String title, String text, PersonalLetterStatus status,
			Timestamp datetime)
	{
		this.userByTargetUserId = userByTargetUserId;
		this.userBySourceUserId = userBySourceUserId;
		this.title = title;
		this.text = text;
		this.datetime = datetime;
		this.status = status;
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
	@JoinColumn(name = "target_user_id", nullable = false)
	public User getUserByTargetUserId()
	{
		return this.userByTargetUserId;
	}
	
	public void setUserByTargetUserId(User userByTargetUserId)
	{
		this.userByTargetUserId = userByTargetUserId;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "source_user_id", nullable = false)
	public User getUserBySourceUserId()
	{
		return this.userBySourceUserId;
	}
	
	public void setUserBySourceUserId(User userBySourceUserId)
	{
		this.userBySourceUserId = userBySourceUserId;
	}
	
	@Column(name = "text", nullable = false, length = 300)
	public String getText()
	{
		return this.text;
	}
	
	public void setText(String text)
	{
		this.text = text;
	}
	
	@Column(name = "title", nullable = false, length = 100)
	public String getTitle()
	{
		return title;
	}
	
	public void setTitle(String title)
	{
		this.title = title;
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
	
	@Column(name = "status", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public PersonalLetterStatus getStatus()
	{
		return status;
	}
	
	public void setStatus(PersonalLetterStatus status)
	{
		this.status = status;
	}
}

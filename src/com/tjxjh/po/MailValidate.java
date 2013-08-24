package com.tjxjh.po;

import java.sql.Timestamp;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * MailValidate entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "mail_validate", catalog = "xiaojh")
public class MailValidate implements java.io.Serializable
{
	// Fields
	private String code;
	private User user;
	private Timestamp datetime;
	
	// Constructors
	/** default constructor */
	public MailValidate()
	{}
	
	/** full constructor */
	public MailValidate(String code, User user)
	{
		this.code = code;
		this.user = user;
	}
	
	// Property accessors
	@Id
	@Column(name = "code", unique = true, nullable = false, length = 250)
	public String getCode()
	{
		return this.code;
	}
	
	public void setCode(String code)
	{
		this.code = code;
	}
	
	@ManyToOne(fetch = FetchType.LAZY, cascade = {CascadeType.REFRESH})
	@JoinColumn(name = "user_id", nullable = false)
	public User getUser()
	{
		return this.user;
	}
	
	public void setUser(User user)
	{
		this.user = user;
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
}

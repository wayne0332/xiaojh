package com.tjxjh.po;

import java.sql.Timestamp;

import javax.persistence.AttributeOverride;
import javax.persistence.AttributeOverrides;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.tjxjh.enumeration.ClubMemberRole;
import com.tjxjh.enumeration.ClubMemberSource;
import com.tjxjh.enumeration.ClubMemberStatus;

/**
 * ClubMember entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "club_member", catalog = "xiaojh")
public class ClubMember implements java.io.Serializable
{
	// Fields
	private ClubMemberId id;
	private User user;
	private Club club;
	private ClubMemberSource source;
	private ClubMemberStatus status;
	private Timestamp datetime;
	private ClubMemberRole role;
	
	// Constructors
	/** default constructor */
	public ClubMember()
	{}
	
	/** full constructor */
	public ClubMember(ClubMemberId id, User user, Club club,
			ClubMemberSource source, ClubMemberStatus status,
			Timestamp datetime, ClubMemberRole role)
	{
		this.id = id;
		this.user = user;
		this.club = club;
		this.source = source;
		this.status = status;
		this.datetime = datetime;
		this.role = role;
	}
	
	// Property accessors
	@EmbeddedId
	@AttributeOverrides({
			@AttributeOverride(name = "clubId", column = @Column(name = "club_id", nullable = false)),
			@AttributeOverride(name = "userId", column = @Column(name = "user_id", nullable = false))})
	public ClubMemberId getId()
	{
		return this.id;
	}
	
	public void setId(ClubMemberId id)
	{
		this.id = id;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false, insertable = false, updatable = false)
	public User getUser()
	{
		return this.user;
	}
	
	public void setUser(User user)
	{
		this.user = user;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "club_id", nullable = false, insertable = false, updatable = false)
	public Club getClub()
	{
		return this.club;
	}
	
	public void setClub(Club club)
	{
		this.club = club;
	}
	
	@Column(name = "source", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public ClubMemberSource getSource()
	{
		return source;
	}
	
	public void setSource(ClubMemberSource source)
	{
		this.source = source;
	}
	
	@Column(name = "status", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public ClubMemberStatus getStatus()
	{
		return status;
	}
	
	public void setStatus(ClubMemberStatus status)
	{
		this.status = status;
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
	
	@Column(name = "role", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public ClubMemberRole getRole()
	{
		return role;
	}
	
	public void setRole(ClubMemberRole role)
	{
		this.role = role;
	}
}

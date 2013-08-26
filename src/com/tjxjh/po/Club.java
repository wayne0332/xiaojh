package com.tjxjh.po;

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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.tjxjh.enumeration.ClubStatus;
import com.tjxjh.enumeration.ClubType;

/**
 * Club entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "club", catalog = "xiaojh")
public class Club implements java.io.Serializable,Comparable<Club>
{
	// Fields
	private Integer id;
	private School school;
	private User proprieter;
	private String introduction;
	private String name;
	private String logoPath;
	private Integer liveness;
	private ClubType type;
	private ClubStatus status;
	private Integer memberNumber;
	private String briefIntroduction;
	private Integer popularity;
	private User user;
	private Set<Activity> activities = new HashSet<Activity>(0);
	private Set<ClubNews> clubNewses = new HashSet<ClubNews>(0);
	private Set<ClubPost> clubPosts = new HashSet<ClubPost>(0);
	private Set<Merchant> beFocusMerchants = new HashSet<Merchant>(0);
	private Set<Merchant> focusMerchants = new HashSet<Merchant>(0);
	private Set<ClubMember> clubMembers = new HashSet<ClubMember>(0);
	private Set<Announcement> announcements = new HashSet<Announcement>(0);
	private Set<Club> clubsForTargetClubId = new HashSet<Club>(0);
	private Set<Club> clubsForSourceClubId = new HashSet<Club>(0);
	private Set<User> users = new HashSet<User>(0);
	
	// Constructors
	/** default constructor */
	public Club()
	{}
	
	/** minimal constructor */
	public Club(School school, User proprieter, String introduction,
			String name, String logoPath, Integer liveness, ClubType type,
			ClubStatus status, Integer memberNumber, String briefIntroduction,
			Integer popularity, User user)
	{
		this.school = school;
		this.proprieter = proprieter;
		this.introduction = introduction;
		this.name = name;
		this.logoPath = logoPath;
		this.liveness = liveness;
		this.type = type;
		this.status = status;
		this.memberNumber = memberNumber;
		this.briefIntroduction = briefIntroduction;
		this.popularity = popularity;
		this.user = user;
	}
	
	/** full constructor */
	public Club(School school, User proprieter, String introduction,
			String name, String logoPath, Integer liveness, ClubType type,
			ClubStatus status, Integer memberNumber, String briefIntroduction,
			Integer popularity, User user, Set<Activity> activities,
			Set<ClubNews> clubNewses, Set<ClubPost> clubPosts,
			Set<Merchant> beFocusMerchants, Set<Merchant> focusMerchants,
			Set<ClubMember> clubMembers, Set<Announcement> announcements,
			Set<Club> clubsForTargetClubId, Set<Club> clubsForSourceClubId,
			Set<User> users)
	{
		this.school = school;
		this.proprieter = proprieter;
		this.introduction = introduction;
		this.name = name;
		this.logoPath = logoPath;
		this.liveness = liveness;
		this.type = type;
		this.status = status;
		this.memberNumber = memberNumber;
		this.briefIntroduction = briefIntroduction;
		this.popularity = popularity;
		this.user = user;
		this.activities = activities;
		this.clubNewses = clubNewses;
		this.clubPosts = clubPosts;
		this.beFocusMerchants = beFocusMerchants;
		this.focusMerchants = focusMerchants;
		this.clubMembers = clubMembers;
		this.announcements = announcements;
		this.clubsForTargetClubId = clubsForTargetClubId;
		this.clubsForSourceClubId = clubsForSourceClubId;
		this.users = users;
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
	@JoinColumn(name = "school_id", nullable = false)
	public School getSchool()
	{
		return this.school;
	}
	
	public void setSchool(School school)
	{
		this.school = school;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "proprieter_user_id", nullable = false)
	public User getProprieter()
	{
		return proprieter;
	}
	
	public void setProprieter(User proprieter)
	{
		this.proprieter = proprieter;
	}
	
	@Column(name = "introduction", nullable = false, length = 65535)
	public String getIntroduction()
	{
		return this.introduction;
	}
	
	public void setIntroduction(String introduction)
	{
		this.introduction = introduction;
	}
	
	@Column(name = "name", nullable = false, length = 100)
	public String getName()
	{
		return this.name;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	@Column(name = "logo_path", nullable = false, length = 250)
	public String getLogoPath()
	{
		return this.logoPath;
	}
	
	public void setLogoPath(String logoPath)
	{
		this.logoPath = logoPath;
	}
	
	@Column(name = "liveness", nullable = false, insertable = false)
	public Integer getLiveness()
	{
		return this.liveness;
	}
	
	public void setLiveness(Integer liveness)
	{
		this.liveness = liveness;
	}
	
	@Column(name = "type", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public ClubType getType()
	{
		return this.type;
	}
	
	public void setType(ClubType type)
	{
		this.type = type;
	}
	
	@Column(name = "status", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public ClubStatus getStatus()
	{
		return status;
	}
	
	public void setStatus(ClubStatus status)
	{
		this.status = status;
	}
	
	@Column(name = "member_number", nullable = false, insertable = false)
	public Integer getMemberNumber()
	{
		return this.memberNumber;
	}
	
	public void setMemberNumber(Integer memberNumber)
	{
		this.memberNumber = memberNumber;
	}
	
	@Column(name = "brief_introduction", nullable = false, length = 200)
	public String getBriefIntroduction()
	{
		return this.briefIntroduction;
	}
	
	public void setBriefIntroduction(String briefIntroduction)
	{
		this.briefIntroduction = briefIntroduction;
	}
	
	@Column(name = "popularity", nullable = false, insertable = false)
	public Integer getPopularity()
	{
		return this.popularity;
	}
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	public User getUser()
	{
		return user;
	}
	
	public void setUser(User user)
	{
		this.user = user;
	}
	
	public void setPopularity(Integer popularity)
	{
		this.popularity = popularity;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "club")
	public Set<Activity> getActivities()
	{
		return this.activities;
	}
	
	public void setActivities(Set<Activity> activities)
	{
		this.activities = activities;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "club")
	public Set<ClubNews> getClubNewses()
	{
		return this.clubNewses;
	}
	
	public void setClubNewses(Set<ClubNews> clubNewses)
	{
		this.clubNewses = clubNewses;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "club")
	public Set<ClubPost> getClubPosts()
	{
		return this.clubPosts;
	}
	
	public void setClubPosts(Set<ClubPost> clubPosts)
	{
		this.clubPosts = clubPosts;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "focusClubs")
	public Set<Merchant> getBeFocusMerchants()
	{
		return beFocusMerchants;
	}
	
	public void setBeFocusMerchants(Set<Merchant> beFocusMerchants)
	{
		this.beFocusMerchants = beFocusMerchants;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "club")
	public Set<ClubMember> getClubMembers()
	{
		return this.clubMembers;
	}
	
	public void setClubMembers(Set<ClubMember> clubMembers)
	{
		this.clubMembers = clubMembers;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "club")
	public Set<Announcement> getAnnouncements()
	{
		return this.announcements;
	}
	
	public void setAnnouncements(Set<Announcement> announcements)
	{
		this.announcements = announcements;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "club_focus_club", catalog = "xiaojh", joinColumns = {@JoinColumn(name = "source_club_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "target_club_id", nullable = false, updatable = false)})
	public Set<Club> getClubsForTargetClubId()
	{
		return this.clubsForTargetClubId;
	}
	
	public void setClubsForTargetClubId(Set<Club> clubsForTargetClubId)
	{
		this.clubsForTargetClubId = clubsForTargetClubId;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY,mappedBy = "clubsForTargetClubId")
	public Set<Club> getClubsForSourceClubId()
	{
		return this.clubsForSourceClubId;
	}
	
	public void setClubsForSourceClubId(Set<Club> clubsForSourceClubId)
	{
		this.clubsForSourceClubId = clubsForSourceClubId;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "focusClubs")
	public Set<User> getUsers()
	{
		return this.users;
	}
	
	public void setUsers(Set<User> users)
	{
		this.users = users;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "club_focus_merchant", catalog = "xiaojh", joinColumns = {@JoinColumn(name = "club_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "merchant_id", nullable = false, updatable = false)})
	public Set<Merchant> getFocusMerchants()
	{
		return focusMerchants;
	}
	
	public void setFocusMerchants(Set<Merchant> focusMerchants)
	{
		this.focusMerchants = focusMerchants;
	}

	@Override
	public int compareTo(Club o) {
		// TODO Auto-generated method stub
		return o.getId()-this.getId();
	}
}

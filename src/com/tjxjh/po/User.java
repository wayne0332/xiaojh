package com.tjxjh.po;

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.UniqueConstraint;

import com.tjxjh.enumeration.Sex;
import com.tjxjh.enumeration.UserStatus;

/**
 * User entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "user", catalog = "xiaojh", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class User implements java.io.Serializable,Comparable<User>
{
	// Fields
	private Integer id;
	private School school;
	private String name;
	private String password;
	private String signature;
	private Integer announcementCount;
	private String email;
	private Sex sex;
	private String realName;
	private String subject;
	private String profession;
	private Integer grade;
	private Date birthday;
	private String phone;
	private String qq;
	private String portraitPath;
	private Integer liveness;
	private Integer popularity;
	private Integer receiveLetterCount;
	private UserStatus status;
	private String code;
	private Set<Picture> pictures = new HashSet<Picture>(0);
	private Set<ActivityPostComment> activityPostComments = new HashSet<ActivityPostComment>(
			0);
	private Set<Club> focusClubs = new HashSet<Club>(0);
	private Set<ActivityPost> activityPosts = new HashSet<ActivityPost>(0);
	private Set<Talking> talkings = new HashSet<Talking>(0);
	private Set<Merchant> merchants = new HashSet<Merchant>(0);
	private Set<Activity> activities = new HashSet<Activity>(0);
	private Set<ClubPostComment> clubPostComments = new HashSet<ClubPostComment>(
			0);
	private Set<TalkingComment> talkingComments = new HashSet<TalkingComment>(0);
	private Set<PersonalLetter> personalLettersForSourceUserId = new HashSet<PersonalLetter>(
			0);
	private Set<PersonalLetter> personalLettersForTargetUserId = new HashSet<PersonalLetter>(
			0);
	private Set<ClubPost> clubPosts = new HashSet<ClubPost>(0);
	private Set<Club> joinClubs = new HashSet<Club>(0);
	private Set<OnlineActivity> onlineActivities = new HashSet<OnlineActivity>(
			0);
	private Set<ClubMember> clubMembers = new HashSet<ClubMember>(0);
	private Set<User> usersForTargetUserId = new HashSet<User>(0);
	private Set<User> usersForSourceUserId = new HashSet<User>(0);
	
	// Constructors
	/** default constructor */
	public User()
	{}
	
	/** minimal constructor */
	public User(School school, String name, String password, String signature,
			Integer announcementCount, String email, Sex sex, String realName,
			String subject, String profession, Integer grade, Date birthday,
			String phone, String qq, String portraitPath, Integer liveness,
			Integer popularity, Integer receiveLetterCount, UserStatus status,
			String code)
	{
		this.school = school;
		this.name = name;
		this.password = password;
		this.signature = signature;
		this.announcementCount = announcementCount;
		this.email = email;
		this.sex = sex;
		this.realName = realName;
		this.subject = subject;
		this.profession = profession;
		this.grade = grade;
		this.birthday = birthday;
		this.phone = phone;
		this.qq = qq;
		this.portraitPath = portraitPath;
		this.liveness = liveness;
		this.popularity = popularity;
		this.receiveLetterCount = receiveLetterCount;
		this.status = status;
		this.code = code;
	}
	
	/** full constructor */
	public User(School school, String name, String password, String signature,
			Integer announcementCount, String email, Sex sex, String realName,
			String subject, String profession, Integer grade, Date birthday,
			String phone, String qq, String portraitPath, Integer liveness,
			Integer popularity, Integer receiveLetterCount, UserStatus status,
			String code, Set<Picture> pictures,
			Set<ActivityPostComment> activityPostComments, Set<Club> focusClubs,
			Set<ActivityPost> activityPosts, Set<Talking> talkings,
			Set<Merchant> merchants, Set<Activity> activities,
			Set<ClubPostComment> clubPostComments,
			Set<TalkingComment> talkingComments,
			Set<PersonalLetter> personalLettersForSourceUserId,
			Set<PersonalLetter> personalLettersForTargetUserId,
			Set<ClubPost> clubPosts, Set<Club> joinClubs,
			Set<OnlineActivity> onlineActivities, Set<ClubMember> clubMembers,
			Set<User> usersForTargetUserId, Set<User> usersForSourceUserId)
	{
		this.school = school;
		this.name = name;
		this.password = password;
		this.signature = signature;
		this.announcementCount = announcementCount;
		this.email = email;
		this.sex = sex;
		this.realName = realName;
		this.subject = subject;
		this.profession = profession;
		this.grade = grade;
		this.birthday = birthday;
		this.phone = phone;
		this.qq = qq;
		this.portraitPath = portraitPath;
		this.liveness = liveness;
		this.popularity = popularity;
		this.receiveLetterCount = receiveLetterCount;
		this.status = status;
		this.code = code;
		this.pictures = pictures;
		this.activityPostComments = activityPostComments;
		this.focusClubs = focusClubs;
		this.activityPosts = activityPosts;
		this.talkings = talkings;
		this.merchants = merchants;
		this.activities = activities;
		this.clubPostComments = clubPostComments;
		this.talkingComments = talkingComments;
		this.personalLettersForSourceUserId = personalLettersForSourceUserId;
		this.personalLettersForTargetUserId = personalLettersForTargetUserId;
		this.clubPosts = clubPosts;
		this.joinClubs = joinClubs;
		this.onlineActivities = onlineActivities;
		this.clubMembers = clubMembers;
		this.usersForTargetUserId = usersForTargetUserId;
		this.usersForSourceUserId = usersForSourceUserId;
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
	@JoinColumn(name = "school_id", nullable = true)
	public School getSchool()
	{
		return this.school;
	}
	
	public void setSchool(School school)
	{
		this.school = school;
	}
	
	@Column(name = "name", unique = true, nullable = false, length = 45)
	public String getName()
	{
		return this.name;
	}
	
	public void setName(String name)
	{
		this.name = name;
	}
	
	@Column(name = "password", nullable = false, length = 45)
	public String getPassword()
	{
		return this.password;
	}
	
	public void setPassword(String password)
	{
		this.password = password;
	}
	
	@Column(name = "signature", nullable = false, length = 300, insertable = false)
	public String getSignature()
	{
		return this.signature;
	}
	
	public void setSignature(String signature)
	{
		this.signature = signature;
	}
	
	@Column(name = "announcement_count", nullable = false, insertable = false)
	public Integer getAnnouncementCount()
	{
		return this.announcementCount;
	}
	
	public void setAnnouncementCount(Integer announcementCount)
	{
		this.announcementCount = announcementCount;
	}
	
	@Column(name = "email", nullable = false, length = 45)
	public String getEmail()
	{
		return this.email;
	}
	
	public void setEmail(String email)
	{
		this.email = email;
	}
	
	@Column(name = "sex", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public Sex getSex()
	{
		return this.sex;
	}
	
	public void setSex(Sex sex)
	{
		this.sex = sex;
	}
	
	@Column(name = "real_name", nullable = true, length = 45)
	public String getRealName()
	{
		return this.realName;
	}
	
	public void setRealName(String realName)
	{
		this.realName = realName;
	}
	
	@Column(name = "subject", nullable = true, length = 45)
	public String getSubject()
	{
		return this.subject;
	}
	
	public void setSubject(String subject)
	{
		this.subject = subject;
	}
	
	@Column(name = "profession", nullable = true, length = 45)
	public String getProfession()
	{
		return this.profession;
	}
	
	public void setProfession(String profession)
	{
		this.profession = profession;
	}
	
	@Column(name = "grade", nullable = false)
	public Integer getGrade()
	{
		return this.grade;
	}
	
	public void setGrade(Integer grade)
	{
		this.grade = grade;
	}
	
	@Temporal(TemporalType.DATE)
	@Column(name = "birthday", nullable = true, length = 10)
	public Date getBirthday()
	{
		return this.birthday;
	}
	
	public void setBirthday(Date birthday)
	{
		this.birthday = birthday;
	}
	
	@Column(name = "phone", nullable = true, length = 45)
	public String getPhone()
	{
		return this.phone;
	}
	
	public void setPhone(String phone)
	{
		this.phone = phone;
	}
	
	@Column(name = "qq", nullable = true, length = 45)
	public String getQq()
	{
		return this.qq;
	}
	
	public void setQq(String qq)
	{
		this.qq = qq;
	}
	
	@Column(name = "portrait_path", nullable = true, length = 250)
	public String getPortraitPath()
	{
		return portraitPath;
	}
	
	public void setPortraitPath(String portraitPath)
	{
		this.portraitPath = portraitPath;
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
	
	@Column(name = "popularity", nullable = false, insertable = false)
	public Integer getPopularity()
	{
		return this.popularity;
	}
	
	public void setPopularity(Integer popularity)
	{
		this.popularity = popularity;
	}
	
	@Column(name = "receive_letter_count", nullable = false, insertable = false)
	public Integer getReceiveLetterCount()
	{
		return receiveLetterCount;
	}
	
	public void setReceiveLetterCount(Integer receiveLetterCount)
	{
		this.receiveLetterCount = receiveLetterCount;
	}
	
	@Column(name = "status", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public UserStatus getStatus()
	{
		return status;
	}
	
	public void setStatus(UserStatus status)
	{
		this.status = status;
	}
	
	@Column(name = "code", nullable = true, length = 200, insertable = false)
	public String getCode()
	{
		return code;
	}
	
	public void setCode(String code)
	{
		this.code = code;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<Picture> getPictures()
	{
		return this.pictures;
	}
	
	public void setPictures(Set<Picture> pictures)
	{
		this.pictures = pictures;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<ActivityPostComment> getActivityPostComments()
	{
		return this.activityPostComments;
	}
	
	public void setActivityPostComments(
			Set<ActivityPostComment> activityPostComments)
	{
		this.activityPostComments = activityPostComments;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "user_focus_club", catalog = "xiaojh", joinColumns = {@JoinColumn(name = "user_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "club_id", nullable = false, updatable = false)})
	public Set<Club> getFocusClubs() {
		return focusClubs;
	}

	public void setFocusClubs(Set<Club> focusClubs) {
		this.focusClubs = focusClubs;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<ActivityPost> getActivityPosts()
	{
		return this.activityPosts;
	}
	
	public void setActivityPosts(Set<ActivityPost> activityPosts)
	{
		this.activityPosts = activityPosts;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<Talking> getTalkings()
	{
		return this.talkings;
	}
	
	public void setTalkings(Set<Talking> talkings)
	{
		this.talkings = talkings;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "user_focus_merchant", catalog = "xiaojh", joinColumns = {@JoinColumn(name = "user_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "merchant_id", nullable = false, updatable = false)})
	public Set<Merchant> getMerchants()
	{
		return this.merchants;
	}
	
	public void setMerchants(Set<Merchant> merchants)
	{
		this.merchants = merchants;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "activity_participant", catalog = "xiaojh", joinColumns = {@JoinColumn(name = "user_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "activity_id", nullable = false, updatable = false)})
	public Set<Activity> getActivities()
	{
		return this.activities;
	}
	
	public void setActivities(Set<Activity> activities)
	{
		this.activities = activities;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<ClubPostComment> getClubPostComments()
	{
		return this.clubPostComments;
	}
	
	public void setClubPostComments(Set<ClubPostComment> clubPostComments)
	{
		this.clubPostComments = clubPostComments;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<TalkingComment> getTalkingComments()
	{
		return this.talkingComments;
	}
	
	public void setTalkingComments(Set<TalkingComment> talkingComments)
	{
		this.talkingComments = talkingComments;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userBySourceUserId")
	public Set<PersonalLetter> getPersonalLettersForSourceUserId()
	{
		return this.personalLettersForSourceUserId;
	}
	
	public void setPersonalLettersForSourceUserId(
			Set<PersonalLetter> personalLettersForSourceUserId)
	{
		this.personalLettersForSourceUserId = personalLettersForSourceUserId;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "userByTargetUserId")
	public Set<PersonalLetter> getPersonalLettersForTargetUserId()
	{
		return this.personalLettersForTargetUserId;
	}
	
	public void setPersonalLettersForTargetUserId(
			Set<PersonalLetter> personalLettersForTargetUserId)
	{
		this.personalLettersForTargetUserId = personalLettersForTargetUserId;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<ClubPost> getClubPosts()
	{
		return this.clubPosts;
	}
	
	public void setClubPosts(Set<ClubPost> clubPosts)
	{
		this.clubPosts = clubPosts;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<Club> getJoinClubs() {
		return joinClubs;
	}

	public void setJoinClubs(Set<Club> joinClubs) {
		this.joinClubs = joinClubs;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<OnlineActivity> getOnlineActivities()
	{
		return this.onlineActivities;
	}
	
	public void setOnlineActivities(Set<OnlineActivity> onlineActivities)
	{
		this.onlineActivities = onlineActivities;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "user")
	public Set<ClubMember> getClubMembers()
	{
		return this.clubMembers;
	}
	
	public void setClubMembers(Set<ClubMember> clubMembers)
	{
		this.clubMembers = clubMembers;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "user_focus_user", catalog = "xiaojh", joinColumns = {@JoinColumn(name = "source_user_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "target_user_id", nullable = false, updatable = false)})
	public Set<User> getUsersForTargetUserId()
	{
		return this.usersForTargetUserId;
	}
	
	public void setUsersForTargetUserId(Set<User> usersForTargetUserId)
	{
		this.usersForTargetUserId = usersForTargetUserId;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "usersForTargetUserId")
	public Set<User> getUsersForSourceUserId()
	{
		return this.usersForSourceUserId;
	}
	
	public void setUsersForSourceUserId(Set<User> usersForSourceUserId)
	{
		this.usersForSourceUserId = usersForSourceUserId;
	}

	@Override
	public int compareTo(User u) {
		// TODO Auto-generated method stub
		return u.getId()-this.getId();
	}
	
}

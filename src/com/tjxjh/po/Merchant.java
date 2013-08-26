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

import com.tjxjh.enumeration.MerchantBusiness;
import com.tjxjh.enumeration.MerchantStatus;
import com.tjxjh.enumeration.MerchantType;

/**
 * Merchant entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "merchant", catalog = "xiaojh")
public class Merchant implements java.io.Serializable,Comparable<Merchant>
{
	// Fields
	private Integer id;
	private String name;
	private String merchantName;
	private String logoPath;
	private String password;
	private String template;
	private MerchantStatus status;
	private MerchantType type;
	private MerchantBusiness business;
	private String purpose;
	private String address;
	private String phone;
	private String connectorName;
	private String connectorPhone;
	private String connectorQq;
	private String connectorEmail;
	private Integer liveness;
	private Integer popularity;
	private User user;
	private Set<User> users = new HashSet<User>(0);
	private Set<Merchant> merchantsForMerchantId1 = new HashSet<Merchant>(0);
	private Set<Merchant> merchantsForMerchantId = new HashSet<Merchant>(0);
	private Set<MerchantNews> merchantNewses = new HashSet<MerchantNews>(0);
	private Set<Activity> activities = new HashSet<Activity>(0);
	private Set<Club> focusClubs = new HashSet<Club>(0);
	private Set<Club> beFocusClubs = new HashSet<Club>(0);
	
	// Constructors
	/** default constructor */
	public Merchant()
	{}
	
	/** minimal constructor */
	public Merchant(String name, String merchantName, String password,
			String logoPath, MerchantStatus status, MerchantType type,
			MerchantBusiness business, String purpose, String address,
			String phone, String connectorName, String connectorPhone,
			String connectorQq, String connectorEmail, Integer liveness,
			Integer popularity, User user)
	{
		this.name = name;
		this.merchantName = merchantName;
		this.logoPath = logoPath;
		this.password = password;
		this.status = status;
		this.type = type;
		this.business = business;
		this.purpose = purpose;
		this.address = address;
		this.phone = phone;
		this.connectorName = connectorName;
		this.connectorPhone = connectorPhone;
		this.connectorQq = connectorQq;
		this.connectorEmail = connectorEmail;
		this.liveness = liveness;
		this.popularity = popularity;
		this.user = user;
	}
	
	/** full constructor */
	public Merchant(String name, String merchantName, String password,
			String logoPath, String template, MerchantStatus status,
			MerchantType type, MerchantBusiness business, String purpose,
			String address, String phone, String connectorName,
			String connectorPhone, String connectorQq, String connectorEmail,
			Integer liveness, Integer popularity, User user, Set<User> users,
			Set<Merchant> merchantsForMerchantId1,
			Set<Merchant> merchantsForMerchantId,
			Set<MerchantNews> merchantNewses, Set<Activity> activities,
			Set<Club> focusClubs, Set<Club> beFocusClubs)
	{
		this.name = name;
		this.merchantName = merchantName;
		this.logoPath = logoPath;
		this.password = password;
		this.template = template;
		this.status = status;
		this.type = type;
		this.business = business;
		this.purpose = purpose;
		this.address = address;
		this.phone = phone;
		this.connectorName = connectorName;
		this.connectorPhone = connectorPhone;
		this.connectorQq = connectorQq;
		this.connectorEmail = connectorEmail;
		this.liveness = liveness;
		this.popularity = popularity;
		this.user = user;
		this.users = users;
		this.merchantsForMerchantId1 = merchantsForMerchantId1;
		this.merchantsForMerchantId = merchantsForMerchantId;
		this.merchantNewses = merchantNewses;
		this.activities = activities;
		this.focusClubs = focusClubs;
		this.beFocusClubs = beFocusClubs;
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
	
	@Column(name = "name", nullable = false, length = 45)
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
	
	@Column(name = "template", length = 300)
	public String getTemplate()
	{
		return this.template;
	}
	
	public void setTemplate(String template)
	{
		this.template = template;
	}
	
	@Column(name = "status", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public MerchantStatus getStatus()
	{
		return status;
	}
	
	public void setStatus(MerchantStatus status)
	{
		this.status = status;
	}
	
	@Column(name = "type", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public MerchantType getType()
	{
		return type;
	}
	
	public void setType(MerchantType type)
	{
		this.type = type;
	}
	
	@Column(name = "business", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public MerchantBusiness getBusiness()
	{
		return this.business;
	}
	
	public void setBusiness(MerchantBusiness business)
	{
		this.business = business;
	}
	
	@Column(name = "purpose", nullable = false, length = 45)
	public String getPurpose()
	{
		return this.purpose;
	}
	
	public void setPurpose(String purpose)
	{
		this.purpose = purpose;
	}
	
	@Column(name = "address", nullable = false, length = 300)
	public String getAddress()
	{
		return this.address;
	}
	
	public void setAddress(String address)
	{
		this.address = address;
	}
	
	@Column(name = "phone", nullable = false, length = 45)
	public String getPhone()
	{
		return this.phone;
	}
	
	public void setPhone(String phone)
	{
		this.phone = phone;
	}
	
	@Column(name = "connector_name", nullable = false, length = 45)
	public String getConnectorName()
	{
		return this.connectorName;
	}
	
	public void setConnectorName(String connectorName)
	{
		this.connectorName = connectorName;
	}
	
	@Column(name = "connector_phone", nullable = false, length = 45)
	public String getConnectorPhone()
	{
		return this.connectorPhone;
	}
	
	public void setConnectorPhone(String connectorPhone)
	{
		this.connectorPhone = connectorPhone;
	}
	
	@Column(name = "connector_qq", nullable = false, length = 45)
	public String getConnectorQq()
	{
		return this.connectorQq;
	}
	
	public void setConnectorQq(String connectorQq)
	{
		this.connectorQq = connectorQq;
	}
	
	@Column(name = "connector_email", nullable = false, length = 45)
	public String getConnectorEmail()
	{
		return this.connectorEmail;
	}
	
	public void setConnectorEmail(String connectorEmail)
	{
		this.connectorEmail = connectorEmail;
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
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "merchants")
	public Set<User> getUsers()
	{
		return this.users;
	}
	
	public void setUsers(Set<User> users)
	{
		this.users = users;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "merchant_focus_merchant", catalog = "xiaojh", joinColumns = {@JoinColumn(name = "merchant_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "merchant_id1", nullable = false, updatable = false)})
	public Set<Merchant> getMerchantsForMerchantId1()
	{
		return this.merchantsForMerchantId1;
	}
	
	public void setMerchantsForMerchantId1(Set<Merchant> merchantsForMerchantId1)
	{
		this.merchantsForMerchantId1 = merchantsForMerchantId1;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "merchantsForMerchantId1")
	public Set<Merchant> getMerchantsForMerchantId()
	{
		return this.merchantsForMerchantId;
	}
	
	public void setMerchantsForMerchantId(Set<Merchant> merchantsForMerchantId)
	{
		this.merchantsForMerchantId = merchantsForMerchantId;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "merchant")
	public Set<MerchantNews> getMerchantNewses()
	{
		return this.merchantNewses;
	}
	
	public void setMerchantNewses(Set<MerchantNews> merchantNewses)
	{
		this.merchantNewses = merchantNewses;
	}
	
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "merchant")
	public Set<Activity> getActivities()
	{
		return this.activities;
	}
	
	public void setActivities(Set<Activity> activities)
	{
		this.activities = activities;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY)
	@JoinTable(name = "merchant_focus_club", catalog = "xiaojh", joinColumns = {@JoinColumn(name = "merchant_id", nullable = false, updatable = false)}, inverseJoinColumns = {@JoinColumn(name = "club_id", nullable = false, updatable = false)})
	public Set<Club> getFocusClubs()
	{
		return focusClubs;
	}
	
	public void setFocusClubs(Set<Club> focusClubs)
	{
		this.focusClubs = focusClubs;
	}
	
	@ManyToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "focusMerchants")
	public Set<Club> getBeFocusClubs()
	{
		return beFocusClubs;
	}
	
	public void setBeFocusClubs(Set<Club> beFocusClubs)
	{
		this.beFocusClubs = beFocusClubs;
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
	
	@Column(name = "merchantName", nullable = false, length = 100)
	public String getMerchantName()
	{
		return merchantName;
	}
	
	public void setMerchantName(String merchantName)
	{
		this.merchantName = merchantName;
	}

	@Override
	public int compareTo(Merchant o) {
		// TODO Auto-generated method stub
		return o.getId()-this.getId();
	}
}

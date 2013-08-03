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
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.tjxjh.enumeration.AdvertisementType;

/**
 * Advertisement entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "advertisement", catalog = "xiaojh")
public class Advertisement implements java.io.Serializable {

	// Fields

	private Integer id;
	private AdvertisementType type;
	private String name;
	private Integer height;
	private Integer width;
	private Set<AdvertisementContent> advertisementContents = new HashSet<AdvertisementContent>(
			0);

	// Constructors

	/** default constructor */
	public Advertisement() {
	}

	/** minimal constructor */
	public Advertisement(AdvertisementType type, String name) {
		this.type = type;
		this.name = name;
	}

	/** full constructor */
	public Advertisement(AdvertisementType type, String name, Integer height,
			Integer width, Set<AdvertisementContent> advertisementContents) {
		this.type = type;
		this.name = name;
		this.height = height;
		this.width = width;
		this.advertisementContents = advertisementContents;
	}

	// Property accessors
	@Id
	@GeneratedValue
	@Column(name = "id", unique = true, nullable = false)
	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	@Column(name = "type", nullable = false, length = 45)
	@Enumerated(EnumType.STRING)
	public AdvertisementType getType() {
		return type;
	}

	public void setType(AdvertisementType type) {
		this.type = type;
	}
	
	@Column(name = "name", nullable = false, length = 45)
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "height")
	public Integer getHeight() {
		return this.height;
	}

	public void setHeight(Integer height) {
		this.height = height;
	}

	@Column(name = "width")
	public Integer getWidth() {
		return this.width;
	}

	public void setWidth(Integer width) {
		this.width = width;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.EAGER, mappedBy = "advertisement")
	public Set<AdvertisementContent> getAdvertisementContents() {
		return this.advertisementContents;
	}

	public void setAdvertisementContents(
			Set<AdvertisementContent> advertisementContents) {
		this.advertisementContents = advertisementContents;
	}

}
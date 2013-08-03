package com.tjxjh.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * AdvertisementContent entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "advertisement_content", catalog = "xiaojh")
public class AdvertisementContent implements java.io.Serializable {

	// Fields

	private Integer id;
	private Advertisement advertisement;
	private String contentPath;
	private String description;
	private String code;
	// Constructors

	/** default constructor */
	public AdvertisementContent() {
	}

	/** minimal constructor */
	public AdvertisementContent(Advertisement advertisement, String contentPath, String code) {
		this.advertisement = advertisement;
		this.contentPath = contentPath;
		this.code = code;
	}

	/** full constructor */
	public AdvertisementContent(Advertisement advertisement,
			String contentPath, String description, String code) {
		this.advertisement = advertisement;
		this.contentPath = contentPath;
		this.description = description;
		this.code = code;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "advertisement_id", nullable = false)
	public Advertisement getAdvertisement() {
		return this.advertisement;
	}

	public void setAdvertisement(Advertisement advertisement) {
		this.advertisement = advertisement;
	}

	@Column(name = "content_path", nullable = false)
	public String getContentPath() {
		return this.contentPath;
	}

	public void setContentPath(String contentPath) {
		this.contentPath = contentPath;
	}

	@Column(name = "description", length = 64)
	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	@Column(name = "code", length = 511)
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
}
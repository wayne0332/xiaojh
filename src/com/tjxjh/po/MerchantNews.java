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

import com.tjxjh.enumeration.TalkingUrlType;


/**
 * MerchantNews entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="merchant_news"
    ,catalog="xiaojh"
)

public class MerchantNews  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private Merchant merchant;
     private String tittle;
     private String text;
     private Timestamp datetime;
     private String url;
     private TalkingUrlType urlType;


    // Constructors

    /** default constructor */
    public MerchantNews() {
    }

	/** minimal constructor */
    public MerchantNews(Merchant merchant, String tittle, String text, Timestamp datetime) {
        this.merchant = merchant;
        this.tittle = tittle;
        this.text = text;
        this.datetime = datetime;
    }
    
    /** full constructor */
    public MerchantNews(Merchant merchant, String tittle, String text, Timestamp datetime, String url, TalkingUrlType urlType) {
        this.merchant = merchant;
        this.tittle = tittle;
        this.text = text;
        this.datetime = datetime;
        this.url = url;
        this.urlType = urlType;
    }

   
    // Property accessors
    @Id @GeneratedValue
    
    @Column(name="id", unique=true, nullable=false)

    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
	@ManyToOne(fetch=FetchType.LAZY)
        @JoinColumn(name="merchant_id", nullable=false)

    public Merchant getMerchant() {
        return this.merchant;
    }
    
    public void setMerchant(Merchant merchant) {
        this.merchant = merchant;
    }
    
    @Column(name="tittle", nullable=false, length=200)

    public String getTittle() {
        return this.tittle;
    }
    
    public void setTittle(String tittle) {
        this.tittle = tittle;
    }
    
    @Column(name="text", nullable=false, length=65535)

    public String getText() {
        return this.text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
    
    @Column(name="datetime", nullable=false, length=19, insertable=false)

    public Timestamp getDatetime() {
        return this.datetime;
    }
    
    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }
    
    @Column(name="url", length=500)

    public String getUrl() {
        return this.url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
    
    @Column(name="url_type", length=45)
    @Enumerated(EnumType.STRING)
    public TalkingUrlType getUrlType() {
        return this.urlType;
    }
    
    public void setUrlType(TalkingUrlType picture) {
        this.urlType = picture;
    }
   








}
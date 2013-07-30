package com.tjxjh.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;


/**
 * Advertisement entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="advertisement"
    ,catalog="xiaojh"
)

public class Advertisement  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String imgPath;
     private String type;
     private String name;
     private String text;


    // Constructors

    /** default constructor */
    public Advertisement() {
    }

	/** minimal constructor */
    public Advertisement(String imgPath, String type, String name) {
        this.imgPath = imgPath;
        this.type = type;
        this.name = name;
    }
    
    /** full constructor */
    public Advertisement(String imgPath, String type, String name, String text) {
        this.imgPath = imgPath;
        this.type = type;
        this.name = name;
        this.text = text;
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
    
    @Column(name="img_path", nullable=false, length=250)

    public String getImgPath() {
        return this.imgPath;
    }
    
    public void setImgPath(String imgPath) {
        this.imgPath = imgPath;
    }
    
    @Column(name="type", nullable=false, length=45)

    public String getType() {
        return this.type;
    }
    
    public void setType(String type) {
        this.type = type;
    }
    
    @Column(name="name", nullable=false, length=45)

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    @Column(name="text", length=300)

    public String getText() {
        return this.text;
    }
    
    public void setText(String text) {
        this.text = text;
    }
   








}
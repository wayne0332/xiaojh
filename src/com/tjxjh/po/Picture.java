package com.tjxjh.po;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


/**
 * Picture entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="picture"
    ,catalog="xiaojh"
)

public class Picture  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private User user;
     private String path;
     private Timestamp datetime;
     private String name;


    // Constructors

    /** default constructor */
    public Picture() {
    }

    
    /** full constructor */
    public Picture(User user, String path, Timestamp datetime,String name) {
        this.user = user;
        this.path = path;
        this.datetime = datetime;
        this.name=name;
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
        @JoinColumn(name="user_id", nullable=false)

    public User getUser() {
        return this.user;
    }
    
    public void setUser(User user) {
        this.user = user;
    }
    
    @Column(name="path", nullable=false, length=250)

    public String getPath() {
        return this.path;
    }
    
    public void setPath(String path) {
        this.path = path;
    }
    
    @Column(name="datetime", nullable=false, length=19, insertable=false)

    public Timestamp getDatetime() {
        return this.datetime;
    }
    
    public void setDatetime(Timestamp datetime) {
        this.datetime = datetime;
    }

    @Column(name="name", nullable=false, length=45)
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}
   








}
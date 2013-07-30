package com.tjxjh.po;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;


/**
 * School entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name="school"
    ,catalog="xiaojh"
, uniqueConstraints = @UniqueConstraint(columnNames="name")
)

public class School  implements java.io.Serializable {


    // Fields    

     private Integer id;
     private String name;
     private String logoPath;
     private Set<User> users = new HashSet<User>(0);
     private Set<Club> clubs = new HashSet<Club>(0);


    // Constructors

    /** default constructor */
    public School() {
    }

	/** minimal constructor */
    public School(String name, String logoPath) {
        this.name = name;
        this.logoPath = logoPath;
    }
    
    /** full constructor */
    public School(String name, String logoPath, Set<User> users, Set<Club> clubs) {
        this.name = name;
        this.logoPath = logoPath;
        this.users = users;
        this.clubs = clubs;
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
    
    @Column(name="name", unique=true, nullable=false, length=100)

    public String getName() {
        return this.name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    @Column(name="logo_path", nullable=false, length=250)

    public String getLogoPath() {
        return this.logoPath;
    }
    
    public void setLogoPath(String logoPath) {
        this.logoPath = logoPath;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="school")

    public Set<User> getUsers() {
        return this.users;
    }
    
    public void setUsers(Set<User> users) {
        this.users = users;
    }
@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.LAZY, mappedBy="school")

    public Set<Club> getClubs() {
        return this.clubs;
    }
    
    public void setClubs(Set<Club> clubs) {
        this.clubs = clubs;
    }
   








}
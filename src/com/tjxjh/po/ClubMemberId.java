package com.tjxjh.po;

import javax.persistence.Column;
import javax.persistence.Embeddable;


/**
 * ClubMemberId entity. @author MyEclipse Persistence Tools
 */
@Embeddable

public class ClubMemberId  implements java.io.Serializable {


    // Fields    

     private Integer clubId;
     private Integer userId;


    // Constructors

    /** default constructor */
    public ClubMemberId() {
    }

    
    /** full constructor */
    public ClubMemberId(Integer clubId, Integer userId) {
        this.clubId = clubId;
        this.userId = userId;
    }

   
    // Property accessors

    @Column(name="club_id", nullable=false)

    public Integer getClubId() {
        return this.clubId;
    }
    
    public void setClubId(Integer clubId) {
        this.clubId = clubId;
    }

    @Column(name="user_id", nullable=false)

    public Integer getUserId() {
        return this.userId;
    }
    
    public void setUserId(Integer userId) {
        this.userId = userId;
    }
   



   @Override
public boolean equals(Object other) {
         if ( (this == other ) ) return true;
		 if ( (other == null ) ) return false;
		 if ( !(other instanceof ClubMemberId) ) return false;
		 ClubMemberId castOther = ( ClubMemberId ) other; 
         
		 return ( (this.getClubId()==castOther.getClubId()) || ( this.getClubId()!=null && castOther.getClubId()!=null && this.getClubId().equals(castOther.getClubId()) ) )
 && ( (this.getUserId()==castOther.getUserId()) || ( this.getUserId()!=null && castOther.getUserId()!=null && this.getUserId().equals(castOther.getUserId()) ) );
   }
   
   @Override
public int hashCode() {
         int result = 17;
         
         result = 37 * result + ( getClubId() == null ? 0 : this.getClubId().hashCode() );
         result = 37 * result + ( getUserId() == null ? 0 : this.getUserId().hashCode() );
         return result;
   }   





}
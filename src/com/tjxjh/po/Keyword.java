package com.tjxjh.po;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Keyword entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "keyword", catalog = "xiaojh")
public class Keyword implements java.io.Serializable
{
	// Fields
	private String keyword;
	
	// Constructors
	/** default constructor */
	public Keyword()
	{}
	
	/** full constructor */
	public Keyword(String keyword)
	{
		this.keyword = keyword;
	}
	
	// Property accessors
	@Id
	@Column(name = "keyword", unique = true, nullable = false, length = 100)
	public String getKeyword()
	{
		return this.keyword;
	}
	
	public void setKeyword(String keyword)
	{
		this.keyword = keyword;
	}
	
	@Override
	public boolean equals(Object obj)
	{
		if(!super.equals(obj))
		{
			if(obj instanceof Keyword)
			{
				return keyword.equals(((Keyword) obj).getKeyword());
			}
			else if(obj instanceof String)
			{
				return keyword.equals(obj);
			}
			else
			{
				return false;
			}
		}
		else
		{
			return true;
		}
	}
	
	@Override
	public int hashCode()
	{
		return keyword.hashCode();
	}
}

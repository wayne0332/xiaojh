package com.tjxjh.action;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import com.tjxjh.keyword.KeywordService;

@ParentPackage("myPackage")
@Namespace("/")
public class KeywordAction extends BaseAction
{
	static final String DELETE_KEYWORD = "deleteKeyword";
	static final String ADD_KEYWORD = "addKeyword";
	static final String ALL_KEYWORD = "allKeyword";
	private static final long serialVersionUID = 5375305241607286447L;
	@Resource
	private KeywordService keywordService = null;
	private String keyword = null;
	
	@Action(value = ALL_KEYWORD, results = {@Result(name = SUCCESS, location = MANAGE
			+ ALL_KEYWORD + JSP)})
	public String allKeyword()
	{
		super.getRequestMap().put("keywords", keywordService.allKeyword());
		return SUCCESS;
	}
	
	@Action(value = ADD_KEYWORD, results = {@Result(name = SUCCESS, type = REDIRECT_ACTION, location = ALL_KEYWORD)})
	public String addKeyword()
	{
		keywordService.addKeyword(keyword);
		return SUCCESS;
	}
	
	@Action(value = DELETE_KEYWORD, results = {@Result(name = SUCCESS, type = REDIRECT_ACTION, location = ALL_KEYWORD)})
	public String deleteKeyword()
	{
		keywordService.deleteKeyword(keyword);
		return SUCCESS;
	}
	
	public void setKeywordService(KeywordService keywordService)
	{
		this.keywordService = keywordService;
	}
	
	public void setKeyword(String keyword)
	{
		this.keyword = keyword;
	}
}

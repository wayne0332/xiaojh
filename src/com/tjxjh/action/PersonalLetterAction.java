package com.tjxjh.action;

import java.io.UnsupportedEncodingException;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.annotation.Auth;
import com.tjxjh.auth.AuthEnum;
import com.tjxjh.po.PersonalLetter;
import com.tjxjh.po.User;
import com.tjxjh.service.PersonalLetterService;

@ParentPackage("myPackage")
@Namespace("/")
public class PersonalLetterAction extends BaseAction
{
	static final String DELETE_LETTER = "deleteLetter";
	static final String PERSONAL_LETTER = "personalLetter";
	static final String RECEIVED_LETTERS = "receivedLetters";
	static final String SEND_LETTER = "sendLetter";
	static final String PERSONAL_LETTER_INPUT = "personalLetterInput";
	private static final long serialVersionUID = 5274564529632569931L;
	private PersonalLetterService personalLetterService = null;
	private User targetUser = null;
	private PersonalLetter letter = null;
	private Page page = null;
	
	@Action(value = PERSONAL_LETTER_INPUT, results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART
					+ SEND_LETTER + JSP),
			@Result(name = INPUT, location = FOREPART + "error_500.jsp")})
	@Auth(auths = {AuthEnum.USER, AuthEnum.MERCHANT})
	public String personalLetterInput()
	{
		try
		{
			targetUser.setName(new String(targetUser.getName().getBytes(
					"ISO8859-1"), "UTF-8").toString());
		}
		catch(UnsupportedEncodingException e)
		{
			e.printStackTrace();
			return INPUT;
		}
		if(!isEmpty(String.valueOf(targetUser.getId()))
				&& !isEmpty(targetUser.getName()))
		{
			if(personalLetterService.exist(targetUser))
			{
				super.getRequestMap().put("targetUser", targetUser);
				return SUCCESS;
			}
		}
		return INPUT;
	}
	
	@Action(value = SEND_LETTER, results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "${#request.location}", params = {
					"type", "0"}),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = PERSONAL_LETTER_INPUT)})
	@Auth(auths = {AuthEnum.USER, AuthEnum.MERCHANT})
	public String sendLetter()
	{
		String location = null;
		if(currentUser() != null)
		{
			location = UserAction.MY_FOCUS;
		}
		else
		{
			location = PersonalLetterAction.RECEIVED_LETTERS;
		}
		getRequestMap().put("location", location);
		return super.successOrInput(personalLetterService.sendLetter(letter));
	}
	
	@Action(value = RECEIVED_LETTERS, results = {@Result(name = SUCCESS, location = FOREPART
			+ "receivedLetters.jsp")})
	@Auth(auths = {AuthEnum.USER, AuthEnum.MERCHANT})
	public String receivedLetters()
	{
		// super.getRequestMap().put("noReadCount",
		// currentUser().getReceiveLetterCount());
		User currentUser = personalLetterService
				.clearReceivedLettersCount(currentUserOrMerchant());
		if(page == null)
		{
			page = personalLetterService.receivedLettersPage(currentUser);
		}
		super.getRequestMap().put("receivedLetters",
				personalLetterService.receivedLetters(page, currentUser));
		return SUCCESS;
	}
	
	@Action(value = PERSONAL_LETTER, results = {@Result(name = SUCCESS, location = FOREPART
			+ PERSONAL_LETTER + JSP)})
	@Auth(auths = {AuthEnum.USER, AuthEnum.MERCHANT})
	public String personalLetter()
	{
		letter = personalLetterService.psersonalLetter(letter,
				currentUserOrMerchant());
		return SUCCESS;
	}
	
	@Action(value = DELETE_LETTER, results = {@Result(name = SUCCESS, type = REDIRECT_ACTION, location = RECEIVED_LETTERS)})
	@Auth(auths = {AuthEnum.USER, AuthEnum.MERCHANT})
	public String deleteLetter()
	{
		personalLetterService.delete(letter, super.currentUserOrMerchant());
		return SUCCESS;
	}
	
	private boolean isEmpty(String text)
	{
		return text == null || text.trim().equals("");
	}
	
	public void setPersonalLetterService(
			PersonalLetterService personalLetterService)
	{
		this.personalLetterService = personalLetterService;
	}
	
	public User getTargetUser()
	{
		return targetUser;
	}
	
	public void setTargetUser(User targetUser)
	{
		this.targetUser = targetUser;
	}
	
	public PersonalLetter getLetter()
	{
		return letter;
	}
	
	public void setLetter(PersonalLetter letter)
	{
		this.letter = letter;
	}
	
	public Page getPage()
	{
		return page;
	}
	
	public void setPage(Page page)
	{
		this.page = page;
	}
}

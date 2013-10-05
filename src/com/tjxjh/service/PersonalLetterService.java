package com.tjxjh.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.enumeration.PersonalLetterStatus;
import com.tjxjh.po.PersonalLetter;
import com.tjxjh.po.User;

@Service
public class PersonalLetterService extends BaseService
{
	private static final String COUNT_HQL = "select count(*) ";
	private static final String RECEIVED_LETTERS_HQL = "from PersonalLetter where userByTargetUserId.id=? order by datetime desc";
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean sendLetter(PersonalLetter letter)
	{
		letter.setStatus(PersonalLetterStatus.NO_READ);
		return this.save(letter);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public User clearReceivedLettersCount(User user)
	{
		try
		{
			user = dao.refresh(user);
			user.setReceiveLetterCount(0);
			return user;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return null;
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public PersonalLetter psersonalLetter(PersonalLetter letter, User user)
	{
		letter = dao.findById(PersonalLetter.class, letter.getId());
		if(letter.getUserByTargetUserId().getId().equals(user.getId()))
		{
			letter.setStatus(PersonalLetterStatus.HAD_READ);
			return letter;
		}
		else
		{
			return null;
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean delete(PersonalLetter letter, User receiveUser)
	{
		letter = dao.findById(PersonalLetter.class, letter.getId());
		if(letter != null)
		{
			if(letter.getUserByTargetUserId().getId()
					.equals(receiveUser.getId()))
			{
				return super.delete(letter);
			}
		}
		return false;
	}
	
	public Page receivedLettersPage(User user)
	{
		return dao.getPageByHql(COUNT_HQL + RECEIVED_LETTERS_HQL, user.getId());
	}
	
	@SuppressWarnings("unchecked")
	public List<PersonalLetter> receivedLetters(Page page, User user)
	{
		return (List<PersonalLetter>) dao.executeHql(page,
				RECEIVED_LETTERS_HQL, user.getId());
	}
}

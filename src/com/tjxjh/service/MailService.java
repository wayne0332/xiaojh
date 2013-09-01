package com.tjxjh.service;

import java.sql.Timestamp;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.enumeration.MailValidateType;
import com.tjxjh.enumeration.MerchantStatus;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.mail.SimpleMailSender;
import com.tjxjh.po.MailValidate;
import com.tjxjh.po.User;
import com.tjxjh.util.CodeUtil;
import com.tjxjh.util.MailUtil;

@Service
public class MailService extends BaseService
{
	private static final int DEFAULT_SERVER_PORT = 80;
	public static final int SECOND = 1000, MINUTE = 60 * SECOND,
			HOUR = 60 * MINUTE, DAY = 24 * HOUR;
	private final static int EFFECTIVE_TIME = DAY;
	private final static String EFFECTIVE_TIME_STRING = "1天";
	
	/** user的id和email不能空 */
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean sendRegisterLetter(User user)
	{
		if(sendLetter(user, "欢迎注册校江湖账号", MailValidateType.REGISTER_VALIDATE))
		{
			return true;
		}
		else
		{
			dao.delete(user);
			return false;
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	private boolean sendLetter(User user, String subject,
			MailValidateType mailValidateType)
	{
		if(user == null || user.getId() == null || user.getEmail() == null)
		{
			return false;
		}
		String code = getCode(user);
		MailValidate mailValidate = dao.findById(MailValidate.class, code);
		if(mailValidate != null && !mailValidate.equals(mailValidateType))
		{
			return false;
		}
		StringBuilder path = new StringBuilder(getServerPath()).append("/")
				.append(mailValidateType.getPath()).append("?code=")
				.append(code);
		if(SimpleMailSender.sendHtmlMail(MailUtil.defaultMailInfo(
				user.getEmail(),
				subject,
				new StringBuilder("点击链接完成").append(mailValidateType.getName())
						.append("(请在").append(EFFECTIVE_TIME_STRING)
						.append("内点击链接,否则链接将失效!)<br><a href='").append(path)
						.append("'>").append(path).append(code).append("</a>")
						.toString())))
		{
			if(mailValidate == null)
			{
				dao.persist(new MailValidate(code, user, mailValidateType));
			}
			else
			{
				mailValidate.setDatetime(new Timestamp(System
						.currentTimeMillis()));
			}
			return true;
		}
		else
		{
			return false;
		}
	}
	
	private StringBuilder getServerPath()
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		StringBuilder path = new StringBuilder("http://").append(request
				.getServerName());
		if(request.getServerPort() != DEFAULT_SERVER_PORT)
		{
			path.append(":").append(request.getServerPort());
		}
		return path.append(ServletActionContext.getServletContext()
				.getContextPath());
	}
	
	/** user的email不能空 */
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean sendFindUserPsdLetter(User user)
	{
		user = checkUserToSendLetter(user);
		return sendLetter(user, "请点击以修改消江湖账号密码",
				MailValidateType.CHANGE_USER_PASSWORD);
	}
	
	private User checkUserToSendLetter(User user)
	{
		user = super.getFistObjectOfList(dao.findByExample(user));
		if(user.getStatus() == UserStatus.VALIDATED)
		{
			return user;
		}
		else if(user.getStatus() == UserStatus.SYSTEM)
		{
			if((Long) dao
					.executeHql(
							"select count(*) from Merchant where status=? and user.id=?",
							MerchantStatus.PASSED, user.getId()).get(0) != 0)
			{
				return user;
			}
		}
		return null;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public User fromValidateEmail(String code)
	{
		User user = null;
		MailValidate validate = dao.findById(MailValidate.class, code);
		if(validate != null)
		{
			if(System.currentTimeMillis() - validate.getDatetime().getTime() < EFFECTIVE_TIME)
			{
				user = validate.getUser();
				if(user.getStatus() == UserStatus.NO_VALIDATE)
				{
					user.setStatus(UserStatus.VALIDATED);
				}
			}
			dao.delete(validate);
		}
		return user;
	}
	
	private String getCode(User user)
	{
		return CodeUtil.md5(String.valueOf(user.getEmail()));
	}
	
	public boolean isRegister(String email)
	{
		return ((Long) dao.executeHql(
				"select count(*) from User where email=?", email).get(0)) > 0;
	}
	
	public boolean checkEmail(String email)
	{
		int atIndex = -1;
		return (atIndex = email.indexOf("@")) > 0
				&& email.indexOf(".") > atIndex;
	}
}

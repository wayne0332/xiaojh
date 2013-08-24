package com.tjxjh.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.mail.SimpleMailSender;
import com.tjxjh.po.MailValidate;
import com.tjxjh.po.User;
import com.tjxjh.util.CodeUtil;
import com.tjxjh.util.MailUtil;

@Service
public class MailService extends BaseService
{
	public static final int SECOND = 1000, MINUTE = 60 * SECOND,
			HOUR = 60 * MINUTE, DAY = 24 * HOUR;
	private final static int EFFECTIVE_TIME = DAY;
	private final static String EFFECTIVE_TIME_STRING = "1天";
	private final static String REGISTER_VALIDATE_PATH = "http://cafebabe-pc:8080/xiaojh/registerValidate?code=";
	
	/** user的id和email都不能空 */
	@Transactional(propagation = Propagation.REQUIRED)
	public void sendRegisterLetter(User user)
	{
		Assert.isTrue(user != null && user.getId() != null
				&& user.getEmail() != null);
		String code = getCode(user);
		if(SimpleMailSender.sendHtmlMail(MailUtil.defaultMailInfo(
				user.getEmail(),
				"欢迎注册校江湖账号",
				new StringBuilder("点击链接完成注册(请在").append(EFFECTIVE_TIME_STRING)
						.append("内点击链接,否则链接将失效!)<br><a href='")
						.append(REGISTER_VALIDATE_PATH).append(code)
						.append("'>").append(REGISTER_VALIDATE_PATH)
						.append(code).append("</a>").toString())))
		{
			dao.persist(new MailValidate(code, user));
		}
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public User validateRegisterUser(String code)
	{
		User user = null;
		MailValidate validate = dao.findById(MailValidate.class, code);
		if(validate != null)
		{
			if(System.currentTimeMillis() - validate.getDatetime().getTime() < EFFECTIVE_TIME)
			{
				user = validate.getUser();
				user.setStatus(UserStatus.VALIDATED);
			}
			dao.delete(validate);
		}
		return user;
	}
	
	private String getCode(User user)
	{
		return CodeUtil.md5(String.valueOf(user.getId()
				+ System.currentTimeMillis()));
	}
}

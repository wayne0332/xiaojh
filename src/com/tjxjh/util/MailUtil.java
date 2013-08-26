package com.tjxjh.util;

import com.tjxjh.mail.MailInfo;

public class MailUtil
{
	private static final String USRE_PASSWORD = "d2F5bmUxMjM=";	//以后再去掉加密- -
	private static final String USER_NAME = "527519996@qq.com";
	private static final String MAIL_SERVER_PORT = "25";
	private static final String MAIL_SERVER_HOST = "smtp.qq.com";
	
	public static MailInfo defaultMailInfo(String targetAddress,
			String subject, String content)
	{
		return new MailInfo(MAIL_SERVER_HOST, MAIL_SERVER_PORT, targetAddress,
				USER_NAME, CodeUtil.decode(USRE_PASSWORD), subject, content);
	}
}

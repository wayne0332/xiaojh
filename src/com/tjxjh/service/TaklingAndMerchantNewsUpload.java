package com.tjxjh.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.tjxjh.enumeration.TalkingUrlType;
import com.tjxjh.po.MerchantNews;
import com.tjxjh.po.Talking;
import com.tjxjh.util.FileUtil;
import com.tjxjh.util.ImageCutAndZoom;
import com.tjxjh.util.StringUtil;

public class TaklingAndMerchantNewsUpload
{
	public static boolean upload(Talking talking, MerchantNews merchantNews,
			File uploadImage, String UPLOAD_IMAGE_PATH,
			String uploadImageFileName)
	{
		HttpServletRequest request = ServletActionContext.getRequest();
		if(uploadImage != null)
		{
			String urlType = FileUtil.allowfile(uploadImageFileName);
			if(urlType == null)
			{
				System.out
						.println("不支持的文件，允许上传的文件格式包括：.jpg .jpeg .png .flv .f4v .mp4");
				return false;
			}
			String imagePath = UPLOAD_IMAGE_PATH + uploadImageFileName;// 上传图片相对地址
			String savepath = "";
			if(urlType.equals(TalkingUrlType.PICTURE.toString()))
			{
				boolean flage = false;
				savepath = FileUtil.copyFile(uploadImage.getAbsolutePath(),
						imagePath);// 将图片上传至服务器
				flage = ImageCutAndZoom.zoom(ServletActionContext
						.getServletContext().getRealPath(savepath));
				if(savepath != null && flage == true)
				{
					// 系统根目录为tomcat 根目录，故需要添加网站更目录
					if(talking != null)
					{
						talking.setUrl(request.getContextPath() + savepath);
						talking.setUrlType(TalkingUrlType.PICTURE);
					}
					else if(merchantNews != null)
					{
						merchantNews.setUrl(request.getContextPath() + "/"
								+ savepath);
						merchantNews.setUrlType(TalkingUrlType.PICTURE);
					}
					else
					{
						return false;
					}
				}
				else
				{
					System.out.println("上传文件出错");
					return false;
				}
			}
			else
			{
				savepath = FileUtil.copyFile(uploadImage.getAbsolutePath(),
						imagePath);// 将视频上传至服务器
				if(savepath != null)
				{
					// 系统根目录为tomcat 根目录，故需要添加网站更目录
					String str = "<embed src='"
							+ request.getContextPath()
							+ "/video/ckplayer/ckplayer.swf?p=0&c=1&i="
							+ request.getContextPath()
							+ "/video/ckplayer/xiaojh.png' "
							+ "flashvars='f="
							+ request.getContextPath()
							+ savepath
							+ "' quality='high' width='480' height='400' align='middle' "
							+ "allowScriptAccess='always' allowFullscreen='true' type='application/x-shockwave-flash'></embed>";
					if(talking != null)
					{
						talking.setUrl(str);
						talking.setUrlType(TalkingUrlType.VIDEO);
					}
					else if(merchantNews != null)
					{
						merchantNews.setUrl(str);
						merchantNews.setUrlType(TalkingUrlType.VIDEO);
					}
					else
					{
						return false;
					}
				}
			}
		}
		else
		{
			if(talking.getUrl() != null && !talking.getUrl().equals(""))
			{
				TalkingUrlType type = FileUtil.testFileType(talking.getUrl());
				if(type != null)
				{
					talking.setUrlType(type);
				}
				else
				{
					System.out
							.println("无法识别的多媒体地址，允许上传的文件格式包括：.jpg .jpeg .png,及视频分享html代码。格式如：http://www.tjxjh.com/a.jpg 或 <embed ...></embed>视频连接");
					return false;
				}
			}
			else if(merchantNews!=null&&StringUtil.isNotEmpty(merchantNews.getUrl()))
			{
				TalkingUrlType type = FileUtil.testFileType(talking.getUrl());
				if(type != null)
				{
					merchantNews.setUrlType(type);
				}
				else
				{
					System.out
							.println("无法识别的多媒体地址，允许上传的文件格式包括：.jpg .jpeg .png,及视频分享html代码。格式如：http://www.tjxjh.com/a.jpg 或 <embed ...></embed>视频连接");
					return false;
				}
			}
		}
		return true;
	}
}

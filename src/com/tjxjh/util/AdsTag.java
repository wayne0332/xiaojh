package com.tjxjh.util;

import java.io.IOException;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import com.tjxjh.po.Advertisement;
import com.tjxjh.po.AdvertisementContent;

public class AdsTag extends TagSupport{
	private Integer adsId = null;
	private Integer contentId = null;
	@Override
	public int doStartTag() throws JspException {
		// TODO Auto-generated method stub
		int flag = super.doStartTag();
		StringBuffer sb = new StringBuffer();
		List<Advertisement> adsList = (List<Advertisement>)pageContext.getServletContext().getAttribute("adsList");
		Advertisement ads = null;
		for(Advertisement a:adsList){
			if(adsId.equals(a.getId())){
				ads = a;
			}			
		}
		Set<AdvertisementContent> contentSet = ads.getAdvertisementContents();
		AdvertisementContent contentArray[] = contentSet.toArray(new AdvertisementContent[contentSet.size()]);
		AdvertisementContent content = null;
		if(contentId!=null&&contentId!=0){
			for(AdvertisementContent c:contentArray){
				if(contentId.equals(c.getId())){
					content = c;
				}			
			}
		}else{
			content = contentArray[new Random().nextInt(contentSet.size())];
		}
		
		switch(ads.getType()){
		case IMG:
			sb.append("<a href='"+content.getCode()+"' ><img src='"+content.getContentPath().substring(1)+"' width='"+ads.getWidth()+"' height='"+ads.getHeight()+"'/></a>");
			break;
		case SWF:
			sb.append("<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' codebase='http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0' width='"+ads.getWidth()+"' height='"+ads.getHeight()+"' id='Column3D' >\n"
					+"<param name='movie' value='"+content.getContentPath().substring(1)+"' />\n"
					+"<param name='FlashVars' value='&dataURL=Data.xml'>\n"
					+"<param name='quality' value='high' />\n"
					+"<embed src='"+content.getContentPath().substring(1)+"' flashVars='&dataURL=Data.xml' quality='high' width='"+ads.getWidth()+"' height='"+ads.getHeight()+"' name='Column3D' type='application/x-shockwave-flash' pluginspage='http://www.macromedia.com/go/getflashplayer' />\n"
					+"</object>");
			break;
		case JS:
			sb.append("<div>\n");
			sb.append("<div class=js_imgs_block>\n");
			sb.append("<div id=slideshow_wrapper>\n");
			sb.append("<div id=slideshow_photo>\n");
			int i = 1;
			for(AdvertisementContent c:contentArray){
				sb.append("<a style='Z-INDEX: 1' href='"+c.getCode()+"'target='_blank' index='"+i+"'><IMG border=0 src='"+c.getContentPath().substring(1)+"'></a>\n");
				i++;
			}
			sb.append("</div>\n");
			sb.append("<div id=slideshow_footbar></div>\n");
			sb.append("</div>\n");
			sb.append("</div>\n");
			sb.append("</div>\n");
			sb.append("<div class=survey_block_index>\n" +
					"<div class=title_survey_block_index>\n" +
					"<UL class=scrollUl>\n" +
					"<a id=m01 class=sd01 href='javascript:void(0)'></a>\n" +
					"<a id=m02 class=sd02 href='javascript:void(0)'></a>\n" +
					"<a style='BACKGROUND-IMAGE: none' id=m03 class=sd03 href='javascript:void(0)'></a>\n" +
					"</UL>\n" +
					"</div>\n" +
					"</div>\n");  
			sb.append("</div>\n");
			break;
		}
		try {
			pageContext.getOut().print(sb.toString());
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return flag;
	}

	public Integer getAdsId() {
		return adsId;
	}

	public void setAdsId(Integer adsId) {
		this.adsId = adsId;
	}

	public Integer getContentId() {
		return contentId;
	}

	public void setContentId(Integer contentId) {
		this.contentId = contentId;
	}
}

package com.tjxjh.action;

import java.io.File;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.Advertisement;
import com.tjxjh.po.AdvertisementContent;
import com.tjxjh.service.AdService;
import com.tjxjh.util.FileUtil;

@ParentPackage("struts-default")
@Namespace("/")
public class AdsAction extends BaseAction{
	protected final static String UPLOAD_PATH="/upload/ads/";
	@Resource
	private AdService service = null;
	private Advertisement ads = null;
	private AdvertisementContent content = null;
	private List<Advertisement> adsList = null;
	private File uploadFile;
	private String uploadFileFileName;
	private int pageNum;
	private int adsId;
	private int contentId;
	private String type = null;
	private List<AdvertisementContent> contentList = null;
	@Action(value = "adsList", results = {
			@Result(name = SUCCESS, location = MANAGE + "adsList.jsp")})
	public String adsList(){
		Page page = new Page(pageNum*Page.getDefaultPageNumber()+1);
		page.setCurrentPage(pageNum);
		adsList = service.adList(page);
		return SUCCESS;
	}
	
	@Action(value = "addAds", results = {
			@Result(name = SUCCESS,type = REDIRECT_ACTION, location = "adsList",params = {"pageNum","1"})})
	public String addAds(){
		if(ads!=null&&ads.getName()!=null&&ads.getType()!=null&&ads.getHeight()!=null&&ads.getWidth()!=null){
			if(service.addAds(ads)){
				refreshApplication();
				return SUCCESS;
			}
		}
		return INPUT;
	}
	
	@Action(value = "removeAds", results = {
			@Result(name = SUCCESS,type = REDIRECT_ACTION, location = "adsList",params = {"pageNum","1"})})
	public String removeAds(){
		if(service.removeAds(adsId)){
			refreshApplication();
			return SUCCESS;
		}else{
			return INPUT;
		}
	}
	
	@Action(value = "contentList", results = {
			@Result(name = SUCCESS, location = MANAGE + "contentList.jsp")})
	public String contentList(){
		contentList = service.contentList(adsId);
		return SUCCESS;
	}
	
	@Action(value = "addContent", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "contentList",params={"adsId","${adsId}","type","${type}"})})
	public String addContent(){
		String fileType = null;
		if(uploadFile != null){
			fileType = FileUtil.allowfile(uploadFileFileName);
		}else{
			return INPUT;
		}
		if(fileType==null||(type.equals("SWF")&&!fileType.equals("VIDEO"))||((type.equals("JS")||type.equals("IMG"))&&fileType.equals("VIDEO"))){
			return INPUT;
		}
		String savePath = FileUtil.copyFile(uploadFile, UPLOAD_PATH+uploadFileFileName);
		content.setContentPath(savePath);
		if(service.addContent(content, adsId)){
			refreshApplication();
			return SUCCESS;
		}else{
			return INPUT;
		}
	}
	
	@Action(value = "removeContent", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION, location = "contentList",params={"adsId","${adsId}","type","${type}"})})
	public String removeContent(){
		if(adsId != 0&&(type.equals("SWF")||type.equals("IMG")||type.equals("JS"))){
			if(service.removeContent(contentId)){
				refreshApplication();
				return SUCCESS;
			}
		}
		return INPUT;
	}
	
	
	private void refreshApplication() {
		if(getApplicationMap().get("adsList")!=null){
			getApplicationMap().remove("adsList");
		}
		getApplicationMap().put("adsList",service.allAdsMap());
	}
	
	
	public void setService(AdService service) {
		this.service = service;
	}

	public Advertisement getAds() {
		return ads;
	}

	public void setAds(Advertisement ads) {
		this.ads = ads;
	}

	public List<Advertisement> getAdsList() {
		return adsList;
	}

	public void setAdsList(List<Advertisement> adsList) {
		this.adsList = adsList;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getAdsId() {
		return adsId;
	}

	public void setAdsId(int adsId) {
		this.adsId = adsId;
	}

	public AdvertisementContent getContent() {
		return content;
	}

	public void setContent(AdvertisementContent content) {
		this.content = content;
	}

	public int getContentId() {
		return contentId;
	}

	public void setContentId(int contentId) {
		this.contentId = contentId;
	}

	public List<AdvertisementContent> getContentList() {
		return contentList;
	}

	public void setContentList(List<AdvertisementContent> contentList) {
		this.contentList = contentList;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public File getUploadFile() {
		return uploadFile;
	}

	public void setUploadFile(File uploadFile) {
		this.uploadFile = uploadFile;
	}

	public String getUploadFileFileName() {
		return uploadFileFileName;
	}

	public void setUploadFileFileName(String uploadFileFileName) {
		this.uploadFileFileName = uploadFileFileName;
	}
	
}

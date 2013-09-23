package com.tjxjh.action;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.Picture;
import com.tjxjh.po.User;
import com.tjxjh.service.PictureService;
import com.tjxjh.service.UserService;
import com.tjxjh.util.Auth;
import com.tjxjh.util.FileUtil;
import com.tjxjh.util.ImageCutAndZoom;


@ParentPackage("struts-default")
@Namespace("/")
public class PictureAction extends BaseAction{
	protected final static String UPLOAD_IMAGE_PATH="/upload/images/";
	private static final long serialVersionUID = 1L;
	private File uploadImage;
	private String uploadImageFileName;// 文件名
	@Resource
	private PictureService pictureService = null;
	private Picture picture=new Picture();
	private String message;//提示信息
	private Page page;
	private Integer eachPageNumber=12;
	private Integer currentPage=1;
	private Integer totalPageNumber=0;
	User user=new User();
	private String actionName;
	private List<Picture> pics=new ArrayList<Picture>();
	/**
	 * 上传图片action
	 * 执行功能：上传图片，缩放，裁剪生成缩略图
	 * 
	 * 所有用户尚未从session中获取，直接关联到id为1的用户上
	 * @return
	 * @throws Exception
	 */
	@Action(value = "addPicture", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String addPicture(){
		String imagePath =UPLOAD_IMAGE_PATH+uploadImageFileName;//上传图片相对地址
		boolean flage=false;
		String savepath ="";
		String tempName=uploadImageFileName.substring(0,uploadImageFileName.lastIndexOf("."));
		if(tempName.length()>8){
			tempName.substring(0, 8);
		}
		picture.setName(tempName);
		savepath = FileUtil.copyFile(uploadImage.getAbsolutePath(),imagePath);//将图片上传至服务器
		flage = ImageCutAndZoom.cutAndZoom(ServletActionContext.getServletContext().getRealPath(savepath));
	    if (savepath!=null&&!savepath.equals("")&&flage==true)
		{
	    	String temppath=savepath.substring(0,savepath.lastIndexOf("/")+1)+"st_"+savepath.substring(savepath.lastIndexOf("/")+1);
	    	picture.setPath(temppath);
	    	picture.setUser(Auth.getUserFromSession());
	    	if(pictureService.add(picture)){
	    		message="提交成功";
				return SUCCESS;
	    	}
		}
    	//插入图片失败，删除上传的图片文件
    	FileUtil.delete(savepath);
    	message="提交失败";
		return SUCCESS;
	}
	/**
	 * 删除图片
	 * 执行功能：删除数据库记录，原图片及缩略图
	 * @return
	 * @throws Exception
	 */
	@Action(value = "deletePicture", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "success.jsp")})
	public String deletePicture(){
			user=Auth.getUserFromSession();
			picture=pictureService.findByHql(new Object[]{user.getId(),picture.getId()});
			if(picture==null)
			{
				message="删除失败！该文件不存在，或你正在非法删除数据";
				return SUCCESS;
			}
			pictureService.delete(picture);
	    	FileUtil.delete(picture.getPath());
	    	message="删除成功";
			return SUCCESS;
	}
	/**
	 * 分页获取图片
	 * 
	 * @return
	 * @throws Exception
	 */
	@Action(value = "findAllPicture", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "photos.jsp")})
	public String findAllPicture(){
		page=pictureService.getAllPageByHql(eachPageNumber,currentPage,totalPageNumber);
		pics=pictureService.findAllPictureByHql(page);
		actionName="findAllPicture";
		return SUCCESS;
	}
	
	/**
	 * 分页获取图片
	 * 
	 * @return
	 * @throws Exception
	 */
	@Action(value = "relativePicture", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "photos.jsp")})
	public String findRelativePicture(){
		page=pictureService.getRelativeByHql(eachPageNumber,currentPage,totalPageNumber);
		pics=pictureService.findRelativePictureByHql(page);
		actionName="relativePicture";
		return SUCCESS;
	}
	
	/**
	 * pre重命名图片
	 * @return
	 */
	
	@Action(value = "preUpdatePicture", results = {
			@Result(name = SUCCESS, location = BaseAction.FOREPART + "renamePhoto.jsp")})
	public String preUpdate(){
		user=Auth.getUserFromSession();
		picture=pictureService.findByHql(new Object[]{user.getId(),picture.getId()});
		if(picture==null)
		{
			message="操作失败！该文件不存在，或非法操作";
			return SUCCESS;
		}
		return SUCCESS;
	}
	
	/**
	 * 重命名图片
	 * @return
	 */
	
	@Action(value = "updatePicture", results = {
			@Result(name = SUCCESS, type = REDIRECT_ACTION,location = "findAllPicture")})
	public String update(){
		user=Auth.getUserFromSession();
		Picture temppicture=pictureService.findByHql(new Object[]{user.getId(),picture.getId()});
		if(temppicture==null){
			message="操作失败！该文件不存在，或非法操作";
			return SUCCESS;
		}
		temppicture.setName(picture.getName());
		pictureService.update(temppicture);
		message="重命名成功！";
		return SUCCESS;
	}
	
	
	public File getUploadImage() {
		return uploadImage;
	}
	public void setUploadImage(File uploadImage) {
		this.uploadImage = uploadImage;
	}

	public PictureService getPictureService() {
		return pictureService;
	}

	public void setPictureService(PictureService pictureService) {
		this.pictureService = pictureService;
	}
	public Picture getPicture() {
		return picture;
	}
	public void setPicture(Picture picture) {
		this.picture = picture;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public String getUploadImageFileName() {
		return uploadImageFileName;
	}
	public void setUploadImageFileName(String uploadImageFileName) {
		this.uploadImageFileName = uploadImageFileName;
	}
	public Page getPage() {
		return page;
	}
	public void setPage(Page page) {
		this.page = page;
	}
	public Integer getEachPageNumber() {
		return eachPageNumber;
	}
	public void setEachPageNumber(Integer eachPageNumber) {
		this.eachPageNumber = eachPageNumber;
	}
	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getTotalPageNumber() {
		return totalPageNumber;
	}
	public void setTotalPageNumber(Integer totalPageNumber) {
		this.totalPageNumber = totalPageNumber;
	}
	public List<Picture> getPics() {
		return pics;
	}
	public void setPics(List<Picture> pics) {
		this.pics = pics;
	}
	public String getActionName() {
		return actionName;
	}
	public void setActionName(String actionName) {
		this.actionName = actionName;
	}

}

package com.tjxjh.action;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.po.Club;
import com.tjxjh.po.ClubMember;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.User;
import com.tjxjh.pojo.SearchResult;
import com.tjxjh.service.ClubService;
import com.tjxjh.service.MerchantService;
import com.tjxjh.service.SearchService;
import com.tjxjh.service.UserService;

@ParentPackage("struts-default")
@Namespace("/")
public class SearchAction extends BaseAction{
	@Resource
	private SearchService searchService = null;
	@Resource
	private UserService userService = null;
	@Resource
	private ClubService clubService = null;
	@Resource
	private MerchantService merchantService = null;
	private String searchText = null;
	private SearchResult searchResult = null;
	private Map<Integer,User> userMap = null;
	private int pageNum;
	public static int USER = 0;
	public static int CLUB = 1;
	public static int MERCHANT = 2;
	public int type;
	@Action(value = "searchAll", results = {
			@Result(name = SUCCESS, location = FOREPART + "searchAll.jsp"),
			@Result(name = INPUT, location = "error_500.jsp")})
	public String SearchAll(){
		Page page = new Page(1);
		page.setCurrentPage(1);
		searchResult = searchService.searchAll(searchText, page);
		if(searchResult == null){
			return INPUT;
		}
		return SUCCESS;
	}
	
	@Action(value = "searchUser", results = {
			@Result(name = SUCCESS, location = FOREPART + "searchResult.jsp"),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = "error_500.jsp")})
	public String SearchUser(){
		Page page = new Page(pageNum*7+1);
		page.setCurrentPage(pageNum);
		if (searchText!=null){
			try {
				searchText= new String(searchText.getBytes("ISO-8859-1"), "UTF8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		User sessionUser = (User)getSessionMap().get("user");
		if(sessionUser!= null){
			Map<Integer,User> userMap = userService.getFocusUsers(sessionUser);
			getRequestMap().put("userMap", userMap);
		}
		searchResult = searchService.searchUser(searchText, page);
		if(searchResult == null){
			return INPUT;
		}
		setType(USER);
		return SUCCESS;
	}
	
	@Action(value = "searchClub", results = {
			@Result(name = SUCCESS, location = FOREPART + "searchResult.jsp"),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = "error_500.jsp")})
	public String SearchClub(){
		Page page = new Page(pageNum*7+1);
		page.setCurrentPage(pageNum);
		if (searchText!=null){
			try {
				searchText= new String(searchText.getBytes("ISO-8859-1"), "UTF8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		User sessionUser = (User)getSessionMap().get("user");
		Merchant sessionMerchant = (Merchant)getSessionMap().get("merchant");
		List<Club> clubList = null;
		if(sessionUser!= null){
			clubList = userService.getFocusList(Club.class,sessionUser);
		}else if(sessionMerchant != null){
			clubList = merchantService.getFocusList(Club.class,sessionMerchant);
		}
		List<Integer> checkList = new ArrayList<Integer>();
		for(Club c :clubList){
			checkList.add(c.getId());
		}
		getRequestMap().put("checkList", checkList);
		ClubMember clubMember = null;
		if((clubMember=(ClubMember)getSessionMap().get("clubMember"))!=null){
			Club club = new Club();
			club.setId(clubMember.getId().getClubId());
			List<Club> clubList2 = clubService.getFocusList(Club.class,club);
			List<Integer> clubCheckList = new ArrayList<Integer>();
			for(Club c :clubList2){
				clubCheckList.add(c.getId());
			}
			getRequestMap().put("clubCheckList", clubCheckList);
		}
		searchResult = searchService.searchClub(searchText, page);
		if(searchResult == null){
			return INPUT;
		}
		setType(CLUB);
		return SUCCESS;
	}

	@Action(value = "searchMerchant", results = {
			@Result(name = SUCCESS, location = FOREPART + "searchResult.jsp"),
			@Result(name = INPUT, type = REDIRECT_ACTION, location = "error_500.jsp")})
	public String SearchMerchant(){
		Page page = new Page(pageNum*7+1);
		page.setCurrentPage(pageNum);
		if (searchText!=null){
			try {
				searchText= new String(searchText.getBytes("ISO-8859-1"), "UTF8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		User sessionUser = (User)getSessionMap().get("user");
		Merchant sessionMerchant = (Merchant)getSessionMap().get("merchant");
		List<Merchant> merchantList = null;
		if(sessionUser != null){
			merchantList = userService.getFocusList(Merchant.class,sessionUser);			
		}else if(sessionMerchant != null){
			merchantList = merchantService.getFocusList(Merchant.class,sessionMerchant);
		}
		List<Integer> checkList = new ArrayList<Integer>();
		for(Merchant m :merchantList){
			checkList.add(m.getId());
		}
		getRequestMap().put("checkList", checkList);
		ClubMember clubMember = null;
		if((clubMember=(ClubMember)getSessionMap().get("clubMember"))!=null){
			Club club = new Club();
			club.setId(clubMember.getId().getClubId());
			List<Merchant> clubList2 = clubService.getFocusList(Merchant.class,club);
			List<Integer> clubCheckList = new ArrayList<Integer>();
			for(Merchant c :clubList2){
				clubCheckList.add(c.getId());
			}
			getRequestMap().put("clubCheckList", clubCheckList);
		}
		searchResult = searchService.searchMerchant(searchText, page);
		if(searchResult == null){
			return INPUT;
		}
		setType(MERCHANT);
		return SUCCESS;
	}
	@Action(value = "initSearch", results = {
			@Result(name = SUCCESS, location = FOREPART + "search.jsp")})
	public String initSearch(){
		return SUCCESS;
	}
	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public void setSearchService(SearchService searchService) {
		this.searchService = searchService;
	}

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public SearchResult getSearchResult() {
		return searchResult;
	}

	public void setSearchResult(SearchResult searchResult) {
		this.searchResult = searchResult;
	}

	public void setClubService(ClubService clubService) {
		this.clubService = clubService;
	}

	public void setMerchantService(MerchantService merchantService) {
		this.merchantService = merchantService;
	}
	
}

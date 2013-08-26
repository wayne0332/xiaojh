package com.tjxjh.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.autodao.pojo.Page;

import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.User;
import com.tjxjh.pojo.SearchResult;

@Service
public class SearchService extends BaseService2 {
	@Resource
	UserService userService = null;
	@Resource
	ClubService clubService = null;
	@Resource
	MerchantService merchantService = null;
	
	@Transactional(readOnly = true)
	public SearchResult searchAll(String text,Page pageInfo){
		SearchResult sr = new SearchResult();
		sr.setUserList(this.searchFromName(text, pageInfo,User.class));
		sr.setClubList(this.searchFromName(text, pageInfo,Club.class));
		sr.setMerchantList(this.searchFromName(text, pageInfo,Merchant.class));
		return sr;
	}
	
	@Transactional(readOnly = true)
	public SearchResult searchUser(String text,Page pageInfo){
		SearchResult sr = new SearchResult();
		Page page2 = new Page(pageInfo.getCurrentPage(),Page.getDefaultPageNumber(),this.countItemNum(text, User.class));
		sr.setPage(page2);
		List<User> list = this.searchFromName(text, page2,User.class);
		for(int i=0;i<list.size();i++){
			User u = list.get(i);
			if(u.getStatus()==UserStatus.SYSTEM||u.getStatus()==UserStatus.ADMIN){
				list.remove(i);
			}
		}
		sr.setUserList(list);
		return sr;
	}
	
	@Transactional(readOnly = true)
	public SearchResult searchClub(String text,Page pageInfo){
		SearchResult sr = new SearchResult();
		Page page2 = new Page(pageInfo.getCurrentPage(),Page.getDefaultPageNumber(),this.countItemNum(text, Club.class));
		sr.setPage(page2);
		sr.setClubList(this.searchFromName(text, page2,Club.class));
		return sr;
	}
	
	@Transactional(readOnly = true)
	public SearchResult searchMerchant(String text,Page pageInfo){
		SearchResult sr = new SearchResult();
		Page page2 = new Page(pageInfo.getCurrentPage(),Page.getDefaultPageNumber(),this.countItemNum(text, Merchant.class));
		sr.setPage(page2);
		sr.setMerchantList(this.searchFromName(text, page2,Merchant.class));
		return sr;
	}
}

package com.tjxjh.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.autodao.dao.BaseDao;
import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.po.ClubPost;
import com.tjxjh.po.ClubPostComment;
import com.tjxjh.pojo.ClubPostContent;
@Service
public class ClubPostService extends BaseService{
	@Resource
	private BaseDao dao = null;
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean addClubPost(ClubPost post){
		return save(post);
	}
	
	public List<ClubPost> allClubPost(Page page){
		String hql = "from ClubPost p order by p.datetime desc";
		List<ClubPost> list = (List<ClubPost>) dao.executeHql(page,hql);
		return list;
	}
	
	public List<ClubPost> clubPostList(int clubId,Page page){
		String hql = "from ClubPost p where p.club.id=? order by p.datetime desc";
		List<ClubPost> list = (List<ClubPost>) dao.executeHql(page,hql,clubId);
		return list;
	}
	
	public Page clubPostNum(int clubId,Page page){
		String hql = "select count(*) from ClubPost p where p.club.id=?";
		List<Long> countL = null;
		if(clubId==0){
			hql = "select count(*) from ClubPost";
			countL = (List<Long>)dao.executeHql(hql);
		}else{
			countL = (List<Long>)dao.executeHql(hql,clubId);
		}
		int itemNum = countL.get(0).intValue();
		return new Page(page.getCurrentPage(),Page.getDefaultPageNumber(),itemNum);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean deleteClubPost(ClubPost post){
		String hql = "delete from ClubPost p where p.id=?";
		int i = dao.executeUpdateHql(hql, post.getId());
		if(i==1){
			return true;
		}else{
			return false;
		}
	}
	public ClubPostContent clubPostContent(int postId,Page page){
		ClubPostContent clubPostContent = new ClubPostContent();
		String listHql = "from ClubPostComment c where c.clubPost.id=? order by c.datetime asc";
		String countHql = "select count(*) from ClubPostComment c where c.clubPost.id=?";
		clubPostContent.setClubPost(dao.findById(ClubPost.class, postId));
		clubPostContent.setCommentList((List<ClubPostComment>) dao.executeHql(page, listHql, postId));
		List<Long> countL = (List<Long>)dao.executeHql(countHql, postId);
		int count = countL.get(0).intValue();
		Page page2 = new Page(page.getCurrentPage(),page.getEachPageNumber(),count);
		clubPostContent.setPage(page2);
		return clubPostContent;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean addComment(ClubPostComment comment){
		return save(comment);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean deleteComment(ClubPostComment comment){
		String hql = "delete from ClubPostComment c where c.id=?";
		int i = dao.executeUpdateHql(hql, comment.getId());
		if(i==1){
			return true;
		}else{
			return false;
		}
	}
	
	@Override
	public void setDao(BaseDao dao) {
		this.dao = dao;
	}
}

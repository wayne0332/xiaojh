package com.tjxjh.service;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.autodao.dao.BaseDao;
import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.po.ActivityPost;
import com.tjxjh.po.ActivityPostComment;
import com.tjxjh.pojo.ActivityPostContent;

@Service
public class ActivityPostService extends BaseService{
	@Resource
	private BaseDao dao = null;
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean addActivityPost(ActivityPost post){
		return save(post);
	}
	
	public List<ActivityPost> allActivityPost(Page page){
		String hql = "from ActivityPost p order by p.datetime desc";
		List<ActivityPost> list = (List<ActivityPost>) dao.executeHql(page,hql);
		return list;
	}
	
	
	
	public List<ActivityPost> activityPostList(int activityId,Page page){
		String hql = "from ActivityPost p where p.onlineActivity.id=? order by p.datetime desc";
		List<ActivityPost> list = (List<ActivityPost>) dao.executeHql(page,hql,activityId);
		return list;
	}
	
	public Page activityPostNum(int activityId,Page page){
		String hql = "select count(*) from ActivityPost p where p.onlineActivity.id=?";
		List<Long> countL = null;
		if(activityId==0){
			hql = "select count(*) from ActivityPost";
			countL = (List<Long>)dao.executeHql(hql);
		}else{
			countL = (List<Long>)dao.executeHql(hql,activityId);
		}
		int itemNum = countL.get(0).intValue();
		return new Page(page.getCurrentPage(),Page.getDefaultPageNumber(),itemNum);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean deleteActivityPost(ActivityPost post){
		String hql = "delete from ActivityPost p where p.id=?";
		int i = dao.executeUpdateHql(hql, post.getId());
		if(i==1){
			return true;
		}else{
			return false;
		}
	}
	
	public ActivityPostContent activityPostContent(int postId,Page page){
		ActivityPostContent activityPostContent = new ActivityPostContent();
		String listHql = "from ActivityPostComment p where p.activityPost.id=? order by p.datetime asc";
		String countHql = "select count(*) from ActivityPostComment c where c.activityPost.id=?";
		activityPostContent.setActivityPost(dao.findById(ActivityPost.class, postId));
		activityPostContent.setCommentList((List<ActivityPostComment>) dao.executeHql(page, listHql, postId));
		List<Long> countL = (List<Long>)dao.executeHql(countHql, postId);
		int count = countL.get(0).intValue();
		Page page2 = new Page(page.getCurrentPage(),page.getEachPageNumber(),count);
		activityPostContent.setPage(page2);
		return activityPostContent;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean addComment(ActivityPostComment comment){
		return save(comment);
	}
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean deleteComment(ActivityPostComment comment){
		String hql = "delete from ActivityPostComment c where c.id=?";
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

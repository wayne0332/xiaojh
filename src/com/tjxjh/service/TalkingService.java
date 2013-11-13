package com.tjxjh.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.opensymphony.xwork2.ActionContext;
import com.tjxjh.enumeration.TalkingStatus;
import com.tjxjh.po.Club;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.ShareDetails;
import com.tjxjh.po.Talking;
import com.tjxjh.po.TalkingComment;
import com.tjxjh.po.User;
import com.tjxjh.pojo.IndexTalking;
import com.tjxjh.util.Auth;
import com.tjxjh.util.DeleteSource;
import com.tjxjh.util.GetRequsetResponse;
import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

@Service
public class TalkingService extends BaseService{
	Talking talking=new Talking();
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean add(Talking tak){
		try{
			tak.setStatus(TalkingStatus.SHARE);
			return super.save(tak);
		}catch (Exception e){
			System.out.println("TalkingService----------"+e);
			return false;
		}
	}
	public String getTalking(List<IndexTalking> taks){
		StringBuilder temp=new StringBuilder();
		for(IndexTalking tak:taks){
			Talking t=tak.getT();
			temp.append("<div id='"+t.getId()+"' class='user_dongtai_div cf w700 mt10 pt10 pb15'><div class='w60 h fl'>");
			temp.append("<img src='"+t.getUser().getPortraitPath()+"' class='w60 h60 fl shadow_l_10 radius_6' /></div>");
			temp.append("<div id='talking_detail_div' class='fr w610 mt5 mr15 user_talking_detail_div'>");
			temp.append("<a href='userHome?user.id="+t.getUser().getId()+"' target='_blank' class='f16 lh150 user_name_color'>");
			temp.append(t.getUser().getName()+"</a> <label class='fr w610 f14'>"+t.getText()+"</label>");
			
			if(t.getTalking()==null){
				temp.append("<div class='cf w610 mt5 fr of_h'>");
				if(t.getUrl()!=null&&!t.getUrl().trim().equals("")&&t.getUrlType().toString()=="PICTURE"){
					temp.append("<img src='"+t.getUrl()+"' class='maw400 mah300' />");
				}
				else if(t.getUrl()!=null&&!t.getUrl().trim().equals("")&&t.getUrlType().toString()=="VIDEO"){
					temp.append(t.getUrl().replace("400", "300").replace("480", "360"));
				}
				temp.append("</div>");
			}
			else if(t.getTalking()!=null){
				temp.append("<div class='p10 mt5 user_talking_share_div cb'>");
				temp.append("<a href='userHome?user.id="+t.getTalking().getUser().getId()+"' class='f12 user_name_color'>"+t.getTalking().getUser().getName()+"</a>");
				temp.append(t.getTalking().getText()+"<br />");
				if(t.getTalking().getUrl()!=null&&!t.getTalking().getUrl().trim().equals("")&&t.getTalking().getUrlType().toString()=="PICTURE"){
					temp.append("<img src='"+t.getTalking().getUrl()+"' class='maw400 mah300' />");
				}else if(t.getTalking().getUrl()!=null&&!t.getTalking().getUrl().trim().equals("")&&t.getTalking().getUrlType().toString()=="VIDEO"){
					temp.append(t.getTalking().getUrl().replace("400", "300").replace("480", "360"));
				}

				temp.append("</div>");
			}
			temp.append("</div><!-- like -->");
			
			temp.append("<div class='fr w610 mt5 mr15'>");
			int tepmpid=t.getUser().getId();
			if(tepmpid==Auth.getUserFromSession().getId()){
				temp.append("<a href='javascript:void(0);' onclick='deleteTalking("+t.getId()+");'>删除</a>");
				temp.append("<span id='zan"+t.getId()+"'>"); 
				if(t.getShareDetails()!=null){
					temp.append("<!-- like --><a><font style='color:#999999;'>赞("+t.getShareDetails().getPraiseCount()+")</font></a>");
				}else{
					temp.append("<a><font style='color:#999999;'>赞("+t.getTalking().getShareDetails().getPraiseCount()+")</font></a>");
				}
						
				temp.append("</span>");
				temp.append("<label>"+t.getDatetime().toString().substring(0,16)+"</label>");
				temp.append("<a><font style='color:#999999;'>分享");
				if(t.getShareDetails()!=null){
					temp.append("("+t.getShareDetails().getShareCount()+")</font></a>");
				}else{
					temp.append("("+t.getTalking().getShareDetails().getShareCount()+")</font></a>");
				}
			}else{
				temp.append("<span id='zan"+t.getId()+"'>");
				if(t.getShareDetails()!=null){
					temp.append("<!-- like --><a href='javascript:void(0);' onclick='zanTalking("+t.getId()+");'>赞("+t.getShareDetails().getPraiseCount()+")</a>");
				}
				else{
					temp.append("<a href='javascript:void(0);' onclick='zanTalking("+t.getId()+");'>赞("+t.getTalking().getShareDetails().getPraiseCount()+")</a>");
				}
				temp.append("</span>");
				temp.append("<label>"+t.getDatetime().toString().substring(0,16)+"</label>");
				if(t.getTalking()==null){
					temp.append("<a href='preShareTalking?talking.id="+t.getId()+"'>分享");
							if(t.getShareDetails()!=null){
								temp.append("("+t.getShareDetails().getShareCount()+")");
							}else{
								temp.append("("+t.getTalking().getShareDetails().getShareCount()+")");
							}
							temp.append("</a>");
				}else{
					temp.append("<a href='preShareTalking?talking.id="+t.getTalking().getId()+"&message="+t.getText()+"'>分享");
					if(t.getShareDetails()!=null){
						temp.append("("+t.getShareDetails().getShareCount()+")");
					}else{
						temp.append("("+t.getTalking().getShareDetails().getShareCount()+")");
					}
					temp.append("</a>");
				}
			}
			temp.append("<!-- 分割线 --><!-- 说说回复 -->");
			temp.append("<span id='tcs"+t.getId()+"'> <!-- 用于ajax动态更新说说 -->");
			for(TalkingComment tc:tak.getTcs()){
				temp.append("<div id='tc"+tc.getId()+"' class='user_pinglun_div w610 cb tc_detail'>");
				temp.append("<div class='w40 h40 mt5 mr10 fl '>");
				temp.append("<a href='userHome?user.id="+tc.getUser().getId()+"' target='_blank'>");
				temp.append("<img src='"+tc.getUser().getPortraitPath()+"' class='w40 h40 shadow_l_10 radius_6' /> </a></div>");
				temp.append("<div class='fl w560'><a href='userHome?user.id="+tc.getUser().getId()+"' target='_blank' class='f12 user_name_color'>");
				temp.append(tc.getUser().getName()+"</a> :"+tc.getText()+"<br />");
				temp.append("<div class='fl color_gray'>"+tc.getDatetime().toString().substring(5,16)+"&nbsp;&nbsp;&nbsp;</div>");
				temp.append("<a href='javascript:void(0);' onclick=\"huifu("+t.getId()+",'"+tc.getUser().getName()+"',"+tc.getUser().getId()+");\" class='f12 user_name_color'>回复</a>");
				int tepmpid2=tc.getUser().getId();
				if(tepmpid2==Auth.getUserFromSession().getId()){
					temp.append("<span class='delete_tc'> &nbsp;&nbsp;<a href='javascript:void(0);' onclick='deleteTalkingComment("+tc.getId()+");'");
					temp.append("class='f12 user_name_color'>删除</a> </span>");
				}
				temp.append("</div><div class='cb'></div></div>");
			}
			//userid
			temp.append("</span> <input type='hidden' id='user_id"+t.getId()+"' name='userid' value='0' />");
			temp.append("<textarea id='pl_t"+t.getId()+"' name='talkingComment.text' class='fr mt5 textarea color_gray' style='width:610px;'></textarea>");
			temp.append("<input type='button' class='submit fr' onclick='addTalkingComment("+t.getId()+");' value='评论' />");
			temp.append("<!-- End:说说回复 --></div><!-- like end --></div>");
		}
		return temp.toString();
	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public Talking delete(Talking tak){
		 tak.setStatus(TalkingStatus.DELETE);
		 if(tak.getOnlineActivities().size()==0&&tak.getActivities().size()==0){
			 DeleteSource.deleteVideo(tak.getUrl());
			 DeleteSource.delete(tak.getUrl());
		 }
		 return dao.merge(tak);
	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public Integer zan(Talking tak){
		try{
		 tak=findById(tak.getId());
		 ShareDetails ss=new ShareDetails();
		 ss=tak.getShareDetails();
		 if(ss==null){
			 ss=tak.getTalking().getShareDetails();
		 }
		 int i=ss.getPraiseCount();
		 ss.setPraiseCount(i+1);
		 dao.merge(tak);
		 return ss.getPraiseCount();
		}catch(Exception e){
			System.out.println("------------"+e);
			return -2;
		}
	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public Integer deletezan(Talking tak){
		try{
		 tak=findById(tak.getId());
		 ShareDetails ss=new ShareDetails();
		 ss=tak.getShareDetails();
		 if(ss==null){
			 ss=tak.getTalking().getShareDetails();
		 }
		 int i=ss.getPraiseCount();
		 ss.setPraiseCount(i-1);
		 dao.merge(tak);
		 return ss.getPraiseCount();
		}catch(Exception e){
			System.out.println("------------"+e);
			return -2;
		}
	}
	public Integer getZanCookie(Talking tak){
		HttpServletRequest request=GetRequsetResponse.getRequest();
		Cookie allCookie[]= request.getCookies();

		if(allCookie!=null&&allCookie.length!=0)
		 {
		     for(int i=0;i<allCookie.length;i++)
		     {
		          String keyname= allCookie[i].getName();
		          if(("zan"+tak.getId()).equals(keyname))
		          {
					  return -1;
		          }
		         
		      }
		 }
		return 0;
	}
	public void deleteZanCookie(Talking tak){
		HttpServletRequest request=GetRequsetResponse.getRequest();
		Cookie allCookie[]= request.getCookies();
		
		if(allCookie!=null&&allCookie.length!=0)
		 {
		     for(int i=0;i<allCookie.length;i++)
		     {
		          String keyname= allCookie[i].getName();
		          if(("zan"+tak.getId()).equals(keyname))
		          {
		        	  HttpServletResponse response=GetRequsetResponse.getResponse();
		        	  allCookie[i].setValue(null);
		        	  allCookie[i].setMaxAge(0);
		        	  response.addCookie(allCookie[i]);
		          }
		         
		      }
		 }
	}
	public void addZanCookie(Talking tak){
		Cookie myCookie=new Cookie("zan"+tak.getId(),"zan"+tak.getId());
		myCookie.setMaxAge(60*60*24*7);
		HttpServletResponse response=GetRequsetResponse.getResponse();
		response.addCookie(myCookie);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public Talking findById(Integer id){
		return dao.findById(Talking.class, id);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public Talking preShare(Integer talkingid,Integer userid){
		talking= dao.findById(Talking.class, talkingid);
		int shareUserId=talking.getUser().getId();//不用中间变量i,直接将获得的值放入表达式，将过的空值：talking.getUser().getId()有延迟，必须等到用的时候才查
		Talking origntalking=talking.getTalking();
		int orignShareUserID=-1;
		if(origntalking!=null){
			orignShareUserID=origntalking.getUser().getId();
		}
		if(userid==shareUserId)
		{
			return null;
		}else if(origntalking!=null&&orignShareUserID==userid)
		{
			return null;
		}
		else
		{
			return talking;
			
		}
	}
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public Talking findByHql(Object... params){
		@SuppressWarnings("unchecked")
		List<Talking> list=(List<Talking>) dao.executeHql("from Talking p where p.user.id=? and p.id=?", params);
		if(list.size()!=1)
		{
			return null;
		}
		else
		{
			return list.get(0);
		}
	}
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public List<Talking> findMyTalkingByHql(Object... params){
//		try{
//			@SuppressWarnings("unchecked")
//			List<Talking> list= (List<Talking>) dao.executeHql("from Talking t where t.user.id=? and t.status in ('NOSHARE','SHARE') order by datetime desc", params);
//			return list;
//		}catch (Exception e){
//			System.out.print("---------findMyTalkingByHql-----"+e);
//			return null;
//		}
//	}
//	
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public List<Talking> findAll(Page pageInfo){
//		return dao.findAll(Talking.class,pageInfo);
//	}
	
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public  Integer myTotalCount(Integer id){
//		try
//		{
//			return Integer.parseInt( dao.executeHql("select count(*) from Talking t where t.user.id=? and t.status in ('NOSHARE','SHARE')",id).get(0).toString());
//		}catch(Exception e)
//		{
//			System.out.println(e);
//			return 0;
//		}
//		
//	}
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public List<Talking> findAllTalkingByHql(){
//		try{
//			@SuppressWarnings("unchecked")
//			List<Talking> list= (List<Talking>) dao.executeHql("from Talking t where  t.status in ('NOSHARE','SHARE') order by datetime desc");
//			return list;
//		}catch (Exception e){
//			System.out.print("---------findMyTalkingByHql-----"+e);
//			return null;
//		}
//	}
//	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
//	public  Integer allTotalCount(){
//		try
//		{
//			return Integer.parseInt( dao.executeHql("select count(*) from Talking t where  t.status in ('NOSHARE','SHARE')").get(0).toString());
//		}catch(Exception e)
//		{
//			System.out.println(e);
//			return 0;
//		}
//		
//	}
	@Transactional (propagation = Propagation.REQUIRED) 
	public Talking update(Talking tak){
		return dao.merge(tak);
	}
	/**********************************所有说说***********************************************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getAllPageByHql(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page=dao.getPageByHql(eachPageNumber,
							"select count(*) from Talking t where  t.status in ('SHARE') ");
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------TalkingService--getAllPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Talking> findAllTalkingByHql(Page page)
	{
		if(page==null){
			return null;
		}
		return (List<Talking>) dao
				.executeHql(
						page,
						"from Talking t where  t.status in ('SHARE') order by datetime desc"
						);
	}
	/******************************End:所有说说***************************************************************************************/
	/******************************我的说说***************************************************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getMyPageByHql(User user,Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page= dao
					.getPageByHql(eachPageNumber,
							"select count(*) from Talking t where t.user.id=? and t.status in ('SHARE')",user.getId());
			page.setCurrentPage(currentPage);
			return page;
		}catch(Exception e){
			System.out.println("---------TalkingService--getMyPageByHql--------"+e);
			return null;
		}
	}
	
	@SuppressWarnings("unchecked")
	public List<Talking> findMyTalkingByHql(Page page,User  user)
	{
		if(page==null){
			return null;
		}
		return (List<Talking>) dao
				.executeHql(
						page,
						"from Talking t where t.user.id=? and t.status in ('SHARE') order by datetime desc",
						user.getId());
	}
	/******************************End:我的说说***************************************************************************************/
	/******************************我相关的说说***************************************************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page getRelativePageByHql(User user,Integer eachPageNumber,Integer currentPage,Integer totalPageNumber)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
		ArrayList<User> users=(ArrayList<User>) session.get("relativeUsers");
		
		String Hql="select count(*) from Talking t where t.status in ('SHARE') ";
		StringBuilder str3=new StringBuilder();
		for(User u:users){
			str3.append(u.getId()+",");
		}
		if(str3.length()>0){
			Hql=Hql+"and t.user.id in ("+str3.substring(0, str3.length()-1)+")";
		}
		try{
			Page page= dao.getPageByHql(eachPageNumber,Hql);
			page.setCurrentPage(currentPage);
			return page;
		}catch(Exception e){
			System.out.println("---------TalkingService--getMyPageByHql--------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Talking> findRelativeTalkingByHql(Page page,User  user)
	{
		if(page==null){
			return null;
		}
		ActionContext context = ActionContext.getContext();  
	    Map<String, Object> session = context.getSession();
		ArrayList<User> users=(ArrayList<User>) session.get("relativeUsers");
		
		String Hql="from Talking t where t.status in ('SHARE') ";
		StringBuilder str3=new StringBuilder();
		for(User u:users){
			str3.append(u.getId()+",");
		}
		if(str3.length()>0){
			Hql=Hql+"and t.user.id in ("+str3.substring(0, str3.length()-1)+") order by datetime desc";
		}
		System.out.println(Hql+"==========================");
		return (List<Talking>) dao
				.executeHql(
						page,Hql);
	}

}

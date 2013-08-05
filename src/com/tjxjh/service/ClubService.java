package com.tjxjh.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.autodao.pojo.Page;
import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.enumeration.ClubMemberRole;
import com.tjxjh.enumeration.ClubMemberSource;
import com.tjxjh.enumeration.ClubMemberStatus;
import com.tjxjh.enumeration.ClubStatus;
import com.tjxjh.enumeration.ClubType;
import com.tjxjh.enumeration.PersonalLetterStatus;
import com.tjxjh.enumeration.Sex;
import com.tjxjh.enumeration.UserStatus;
import com.tjxjh.po.Activity;
import com.tjxjh.po.Club;
import com.tjxjh.po.ClubMember;
import com.tjxjh.po.ClubMemberId;
import com.tjxjh.po.Merchant;
import com.tjxjh.po.PersonalLetter;
import com.tjxjh.po.School;
import com.tjxjh.po.User;

@Service
public class ClubService extends BaseService
{
	private static final String CLUBMEMBERS_WITHOUT_PROPRIETER_HQL = "from ClubMember where club.id=? and status=? and user.id<>?";
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean applyClub(Club club, User proprieterUser, File logo)
	{
		User user = new User(club.getSchool(), club.getSchool().getId() + "_"
				+ club.getName(), club.getName(), null, null, club.getName(),
				Sex.MAN, null, null, null, Calendar.getInstance().get(
						Calendar.YEAR), null, null, null, null, null, null,
				null, UserStatus.SYSTEM, null);
		dao.persist(user);
		club.setUser(user);
		club.setStatus(ClubStatus.NO_CHECK);
		UserService.savePortrait(club.getLogoPath(), logo, 280);
		club.setProprieter(proprieterUser);
		return super.save(club);
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean checkClub(Club club, boolean isPass)
	{
		club = dao.findById(Club.class, club.getId());
		if(isPass)
		{
			dao.executeUpdateHql(
					"update Club set status=?,memberNumber=? where id=?",
					ClubStatus.PASSED, club.getMemberNumber() + 1, club.getId());
			club.getClubMembers().add(
					new ClubMember(new ClubMemberId(club.getId(), club
							.getProprieter().getId()), null, null,
							ClubMemberSource.USER_TO_CLUB,
							ClubMemberStatus.PASSED, null,
							ClubMemberRole.PROPRIETER));
		}
		else
		{
			dao.executeUpdateHql("update Club set status=? where id=?",
					ClubStatus.NO_PASSED, club.getId());
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean addMember(Club club, User user, ClubMemberSource source)
	{
		ClubMember oldMember = null;
		if((oldMember = ((ClubMember) super.getFistObjectOfList(dao.executeHql(
				"from ClubMember where user.id=? and club.id=?", user.getId(),
				club.getId())))) == null)
		{
			dao.persist(new ClubMember(new ClubMemberId(club.getId(), user
					.getId()), null, null, source, ClubMemberStatus.NO_CHECK,
					null, ClubMemberRole.NORMAL));
			return true;
		}
		else
		{
			if(oldMember.getStatus() == ClubMemberStatus.DELETE)
			{
				oldMember.setStatus(ClubMemberStatus.NO_CHECK);
				oldMember.setSource(source);
				return true;
			}
		}
		return false;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean acceptInvited(User user, Club club)
	{
		ClubMember member = null;
		if((member = checkClubMember(user, club, ClubMemberStatus.NO_CHECK,
				null)) != null)
		{
			member.setStatus(ClubMemberStatus.PASSED);
			dao.executeUpdateHql(
					"update Club set memberNumber=memberNumber+1 where id=?",
					club.getId());
			dao.flush();
			return true;
		}
		return false;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean refuseInvited(User user, Club club)
	{
		ClubMember member = null;
		if((member = checkClubMember(user, club, ClubMemberStatus.NO_CHECK,
				null)) != null)
		{
			dao.delete(member);
			return true;
		}
		return false;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean deleteClubMember(User user, Club club, ClubMember manager)
	{
		ClubMember member = null;
		if((member = checkClubMember(user, club, ClubMemberStatus.PASSED, null)) != null)
		{
			if(member.getRole() != ClubMemberRole.PROPRIETER)
			{
				if(member.getRole() == ClubMemberRole.NORMAL
						|| manager.getRole() == ClubMemberRole.PROPRIETER)
				{
					dao.delete(member);
					manager = dao.refresh(manager);
					dao.persist(sendLetter(member.getUser(), manager.getUser(),
							"您已被管理员'" + manager.getUser().getName() + "'开除出'"
									+ manager.getClub().getName() + "'社团了."));
					return true;
				}
			}
		}
		return false;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean changeMemberRole(User user, ClubMember proprieter,
			ClubMemberRole oriRole, ClubMemberRole targetRole)
	{
		ClubMember member = null;
		if((member = checkClubMember(user, proprieter.getClub(),
				ClubMemberStatus.PASSED, oriRole)) != null)
		{
			member.setRole(targetRole);
			proprieter = dao.refresh(proprieter);
			dao.persist(sendLetter(member.getUser(), proprieter.getUser(),
					"您已被社长'" + proprieter.getUser().getName() + "'变为'"
							+ proprieter.getClub().getName() + "'社团的"
							+ targetRole.getName() + "了."));
			return true;
		}
		return false;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean changeProprieter(User user, ClubMember proprieter)
	{
		ClubMember member = null;
		if((member = checkClubMember(user, proprieter.getClub(),
				ClubMemberStatus.PASSED, null)) != null)
		{
			if(member.getRole() != ClubMemberRole.PROPRIETER)
			{
				member.setRole(ClubMemberRole.PROPRIETER);
				proprieter = dao.refresh(proprieter);
				proprieter.setRole(ClubMemberRole.MANAGER);
				dao.persist(sendLetter(member.getUser(), proprieter.getUser(),
						"您已成为'" + proprieter.getClub().getName() + "'社团的新社长了."));
				return true;
			}
		}
		return false;
	}
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean focusClub(ClubMember clubMember,Club targetClub){
		try{
			if(!exist(targetClub)){
				throw new Exception();
			}else{
				Club c = dao.findById(Club.class, targetClub.getId());
				Club sc = dao.findById(Club.class, clubMember.getId().getClubId());
				sc.getClubsForTargetClubId().add(c);
				dao.flush();
			}
		}
		catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean cancelFocusClub(ClubMember clubMember, Club targetClub){
		try{
			if(!exist(targetClub)){
				throw new Exception();
			}else{
				Club c = dao.findById(Club.class, targetClub.getId());
				Club sc = dao.findById(Club.class, clubMember.getId().getClubId());
				dao.refresh(sc).getClubsForTargetClubId().remove(c);
				dao.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean focusMerchant(ClubMember clubMember,Merchant merchant){
		try{
			if(!exist(merchant)){
				throw new Exception();
			}else{
				Merchant c = dao.findById(Merchant.class, merchant.getId());
				Club sc = dao.findById(Club.class, clubMember.getId().getClubId());
				sc.getFocusMerchants().add(c);
				dao.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean cancelFocusMerchant(ClubMember clubMember, Merchant merchant){
		try{
			if(!exist(merchant)){
				throw new Exception();
			}else{
				Merchant c = dao.findById(Merchant.class, merchant.getId());
				Club sc = dao.findById(Club.class, clubMember.getId().getClubId());
				dao.refresh(sc).getFocusMerchants().remove(c);
				dao.flush();
			}
		}catch(Exception e){
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public <T> List<T> getFocusList(Class objectClass, Club club)
	{
		List<T> list = new ArrayList<T>();
		Club c = dao.findById(Club.class, club.getId());
		Set<T> focusSet = null;
		if(objectClass == Club.class){
			focusSet = (Set<T>) c.getClubsForTargetClubId();
		}
		else if(objectClass == Merchant.class){
			focusSet = (Set<T>) c.getFocusMerchants();
		}
		Iterator<T> it = focusSet.iterator();
		while(it.hasNext())
		{
			list.add(it.next());
		}
		return list;
	}
	private PersonalLetter sendLetter(User target, User source, String text)
	{
		return new PersonalLetter(target, source, "社团通知", text,
				PersonalLetterStatus.NO_READ, null);
	}
	
	private ClubMember checkClubMember(User user, Club club,
			ClubMemberStatus status, ClubMemberRole role)
	{
		return super.getFistObjectOfList(dao.findByExample(clubOfUser(user,
				club, status, role)));
	}
	
	public int clubInvitedCount(User user)
	{
		return ((Long) dao.executeHql(
				"select count(*) from ClubMember where user.id=? and status=?",
				user.getId(), ClubMemberStatus.NO_CHECK).get(0)).intValue();
	}
	
	public int userRequestCount(Club club)
	{
		return ((Long) dao.executeHql(
				"select count(*) from ClubMember where club.id=? and status=?",
				club.getId(), ClubMemberStatus.NO_CHECK).get(0)).intValue();
	}
	
	public List<ClubMember> myInvited(User user)
	{
		return dao.findByExample(clubOfUser(user, null,
				ClubMemberStatus.NO_CHECK, null));
	}
	
	public List<ClubMember> clubRequest(Club club)
	{
		return dao.findByExample(clubOfUser(null, club,
				ClubMemberStatus.NO_CHECK, null));
	}
	
	public Club clubById(Club club)
	{
		return dao.findById(Club.class, club.getId());
	}
	
	public Page userClubsPage(User user)
	{
		return dao.getPageByExample(clubOfUser(user, null, null, null));
	}
	
	public List<ClubMember> userClubs(User user, Page page)
	{
		return dao.findByExample(clubOfUser(user, null, null, null), page);
	}
	
	public Page clubMembersPage(Club club)
	{
		return dao.getPageByExample(clubOfUser(null, club, null, null));
	}
	
	public List<ClubMember> clubMembers(Club club, Page page)
	{
		return dao.findByExample(clubOfUser(null, club, null, null), page);
	}
	
	public Map<Integer, ClubMember> clubMembersMap(Club club)
	{
		List<ClubMember> members = dao.findByExample(clubOfUser(null, club,
				null, null));
		Map<Integer, ClubMember> clubMembers = new HashMap<Integer, ClubMember>();
		for(ClubMember clubMember : members)
		{
			clubMembers.put(clubMember.getUser().getId(), clubMember);
		}
		return clubMembers;
	}
	
	public ClubMember userClub(User user, Club club)
	{
		return super.getFistObjectOfList(dao.findByExample(clubOfUser(user,
				club, null, null)));
	}
	
	private ClubMember clubOfUser(User user, Club club,
			ClubMemberStatus status, ClubMemberRole role)
	{
		return new ClubMember(null, user, club, null, status, null, role);
	}
	
	public boolean hadClub(String name, Integer schoolId)
	{
		return (Long) dao.executeHql(
				"select count(*) from Club where name=? and school.id=?", name,
				schoolId).get(0) > 0l;
	}
	
	public Page clubMembersWithoutProprieterpage(ClubMember proprieter)
	{
		return dao.getPageByHql("select count(*) "
				+ CLUBMEMBERS_WITHOUT_PROPRIETER_HQL, proprieter.getClub()
				.getId(), ClubStatus.PASSED, proprieter.getUser().getId());
	}
	
	@SuppressWarnings("unchecked")
	public List<ClubMember> clubMembersWithoutProprieter(ClubMember proprieter,
			Page page)
	{
		return (List<ClubMember>) dao.executeHql(page,
				CLUBMEMBERS_WITHOUT_PROPRIETER_HQL, proprieter.getClub()
						.getId(), ClubStatus.PASSED, proprieter.getUser()
						.getId());
	}
	@SuppressWarnings("unchecked")
	public List<Club> findHeatClubByHql()
	{
		Page page=Page.getPage(1, 10, 1);
		return (List<Club>) dao.executeHql(page,"from Club cl where cl.status='PASSED' order by popularity desc");
	}
	/**********************************************************查看某个学校的社团的，按热度排序*****************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page findSchoolClubPageByHet(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber,School school)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page=null;
			if(school!=null&&school.getId()!=null){
				page=dao.getPageByHql(eachPageNumber,"select count(*) from Club cl  where cl.status='PASSED' and cl.school.id=?",
						school.getId());
			}else{
				return null;
			}
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------findSchoolClubPageByHet---------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Club> findSchoolHeatClubByHql(School school,Page page)
	{
		return (List<Club>) dao.executeHql(page,"from Club cl where cl.status='PASSED' and cl.school.id=? order by popularity desc",school.getId());
	}
	/**********************************************************查看某个学校的某个类型的社团*****************************************************/
	@Transactional (propagation = Propagation.REQUIRED) 
	public Page findSchoolClubPageByType(Integer eachPageNumber,Integer currentPage,Integer totalPageNumber,School school,String type)
	{
		if(currentPage<=0){
			currentPage=1;
		}
		if(totalPageNumber!=0){
			return Page.getPage(currentPage, eachPageNumber, totalPageNumber);
		}
		try{
			Page page=null;
			if(school!=null&&school.getId()!=null){
				page=dao.getPageByHql(eachPageNumber,"select count(*) from Club cl  where cl.status='PASSED' and cl.type=? and cl.school.id=?",
						ClubType.valueOf(type),school.getId());
			}else{
				return null;
			}
			page.setCurrentPage(currentPage);
			return page;
		}catch (Exception e){
			System.out.println("---------findSchoolClubPageByType---------"+e);
			return null;
		}
	}
	@SuppressWarnings("unchecked")
	public List<Club> findSchoolClubByType(School school,String type,Page page)
	{
		return (List<Club>) dao.executeHql(page,"from Club cl where cl.status='PASSED' and cl.type=? and cl.school.id=? order by popularity desc",
				ClubType.valueOf(type),school.getId());
	}
	/**********************************************************查看某个学校的某个类型的社团*****************************************************/
}

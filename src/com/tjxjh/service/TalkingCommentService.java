package com.tjxjh.service;

import java.util.List;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import com.tjxjh.po.TalkingComment;
import cn.cafebabe.websupport.service.BaseService;

@Service
public class TalkingCommentService extends BaseService{
	
	@Transactional(propagation = Propagation.REQUIRED)
	public boolean add(TalkingComment tc,Integer userid){
		String temp=tc.getText();
		try{
		if(temp.trim().substring(0, 1).equals("@")){
			tc.setText("@<a class='f12 user_name_color' href='userHome?user.id="+userid+"' target='_blank'>"+temp.substring(temp.indexOf("@")+1, temp.indexOf(":"))+"</a>:"+temp.substring(temp.indexOf(":")+1));
			}
		}catch(Exception e){
			
		}
		return super.save(tc);
	}
	
	@Transactional (propagation = Propagation.REQUIRED) 
	public void delete(TalkingComment tc){
		 dao.delete(tc);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public TalkingComment findById(Integer id){
		return dao.findById(TalkingComment.class, id);
	}
	
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public List<TalkingComment> findByHql(Object... params){
		@SuppressWarnings("unchecked")
		List<TalkingComment> list=(List<TalkingComment>) dao.executeHql("from TalkingComment t where t.talking.id=?", params);
		return list;
	}
	@Transactional(readOnly = true, propagation=Propagation.SUPPORTS)   
	public TalkingComment findOneByHql(Object... params){
		@SuppressWarnings("unchecked")
		List<TalkingComment> list=(List<TalkingComment>) dao.executeHql("from TalkingComment t where t.id=? and t.user.id=?", params);
		if(list.size()==1){
			return list.get(0);
		}
		return null;
	}
	
	@Transactional (propagation = Propagation.REQUIRED) 
	public TalkingComment update(TalkingComment tc){
		return dao.merge(tc);
	}
	
}

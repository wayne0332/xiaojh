package com.tjxjh.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import cn.cafebabe.websupport.service.BaseService;

import com.tjxjh.keyword.KeywordScreening;
import com.tjxjh.keyword.KeywordService;
import com.tjxjh.po.Keyword;

@Service
@Scope(value = "singleton")
public class KeywordDbService extends BaseService implements KeywordService
{
	private KeywordScreening keywordScreening = null;
	
	@Override
	public List<String> allKeyword()
	{
		List<String> keywords = new ArrayList<String>();
		for(Keyword keyword : dao.findAll(Keyword.class))
		{
			keywords.add(keyword.getKeyword());
		}
		return keywords;
	}
	
	@Override
	public void rebuildKeywordScreening()
	{
		keywordScreening.rebuildKeywordMap(allKeyword());
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void deleteKeyword(String word)
	{
		// Keyword keyword = dao.findById(Keyword.class, word);
		// if(keyword != null)
		// {
		// dao.delete(keyword);
		// }
		dao.delete(new Keyword(word));
		rebuildKeywordScreening();
	}
	
	@Override
	@Transactional(propagation = Propagation.REQUIRED)
	public void addKeyword(String word)
	{
		dao.persist(new Keyword(word));
		rebuildKeywordScreening();
	}
	
	@Override
	public void setKeywordScreening(KeywordScreening keywordScreening)
	{
		this.keywordScreening = keywordScreening;
		rebuildKeywordScreening();
	}
}

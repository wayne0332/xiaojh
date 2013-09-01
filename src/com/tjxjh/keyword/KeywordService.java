package com.tjxjh.keyword;

import java.util.List;

public interface KeywordService
{
	public abstract List<String> allKeyword();
	
	abstract void rebuildKeywordScreening();
	
	public abstract void deleteKeyword(String word);
	
	public abstract void addKeyword(String word);
	
	abstract void setKeywordScreening(KeywordScreening keywordScreening);
}

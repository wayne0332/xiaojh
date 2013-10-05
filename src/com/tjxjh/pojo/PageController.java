package com.tjxjh.pojo;

import java.util.ArrayList;
import java.util.List;


public class PageController {

	private int currentPageIndex = 1; // 当前页号，外界传入
	private int countPerpage = 7; // 每页条数，外界可以设定
	private List pageList = null; // 分页集合
	private int pageCount = -1; // 总页数
	private int recordCount = -1; // 总记录条数
	private int prePageIndex = -1; // 上一页序号
	private int nextPageIndex = -1; // 下一页序号
	
	public PageController(){
	}
	
	public PageController(int countPerpage){
		this.countPerpage = countPerpage;
	}
	
	public PageController(int recordCount,int countPerpage){
		this(countPerpage);
		this.setRecordCount(recordCount);
	}
	
	public PageController(int recordCount,int currentPageIndex,int countPerpage){
		this(recordCount,countPerpage);
		this.setCurrentPageIndex(currentPageIndex);
	}
//	public void setResultList(ArrayList resultList) {
//		this.resultList = resultList;
//		recordCount = resultList.size();
//		pageCount = recordCount % countPerpage == 0 ? recordCount
//				/ countPerpage : recordCount / countPerpage + 1;
//	}

	public void setCurrentPageIndex(int currentPageIndex) { // 每当页数改变，都会调用这个函数，筛选代码可以写在这里
		this.currentPageIndex = currentPageIndex;
		if(pageCount != -1){
			this.prePageIndex = currentPageIndex-1>0?currentPageIndex-1:1;
			this.nextPageIndex = currentPageIndex+1<pageCount?currentPageIndex+1:pageCount;
		}
	}
	public void setRecordCount(int recordCount){
		this.recordCount = recordCount;
		if(recordCount!=0){			
			this.pageCount = recordCount%countPerpage==0?recordCount/countPerpage:recordCount/countPerpage+1;
		}else{
			this.pageCount = 1;
		}
		this.setCurrentPageIndex(this.currentPageIndex);
	}
	public void setPageList(List pageList) {
//		// 筛选工作
//		if (currentPageIndex > 0) {
//			if (resultList != null) {
//				if (recordCount > countPerpage) {
//					pageList = new ArrayList();
//					for (int i = (currentPageIndex - 1) * countPerpage; i < currentPageIndex
//							* countPerpage
//							&& i < recordCount; i++) {
//						pageList.add(resultList.get(i));
//					}
//				} else {
//					pageList = resultList;
//				}
//			} else {
//				throw new PageControlException("未设置结果集");
//			}
//		} else {
//			throw new PageControlException("未设置当前页");
//		}
		this.pageList = pageList;
	}

	public int getCurrentPageIndex() {
		return currentPageIndex;
	}

//	public void setCountPerpage(int countPerpage) {
//		this.countPerpage = countPerpage;
//	}

	public int getPageCount() {
		return pageCount;
	}

	public List getPageList() {
		return pageList;
	}

	public int getNextPageIndex() {
		return nextPageIndex;
	}

	public int getPrePageIndex() {
		return prePageIndex;
	}
	
	public int getRecordCount(){
		return recordCount;
	}
	public int getCountPerpage(){
		return countPerpage;
	}
	
}

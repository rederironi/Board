package com.example.demo.board.domain;

public class SearchCriteria extends Criteria{

	private String searchType = "";
	private String keyword = "";
	private String gubunSelect = "";
	 


	public String getSearchType() {
		return searchType;
	}



	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}



	public String getKeyword() {
		return keyword;
	}



	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}


	public String getGubunSelect() {
		return gubunSelect;
	}



	public void setGubunSelect(String gubunSelect) {
		this.gubunSelect = gubunSelect;
	}



	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword 
						+ ", gubunSelect=" + gubunSelect + "]";
	}
	
}
package com.kh.spring.manager.model.vo;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int startPage;	//페이징
	private int endPage;	//페이징
	
	private String searchType;	//검색
	private String keyword;	//검색
	
	public Criteria(String searchType, String keyword){	//페이징
		this.searchType = searchType;
		this.keyword = keyword;
	}
	
	public Criteria(int startPage, int endPage) {	//페이징
		this.startPage = startPage;
		this.endPage = endPage;
	}

}
package com.kh.spring.member.model.service;

import org.apache.ibatis.session.SqlSession;

import com.kh.spring.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member member);
	
	Member selectOneMember(String userId);

	int updateMember(Member member);

	int pwupdateMember(Member member);

	Member selectTwoMember(String userEmail);

	int deleteMember(String userId);

	int statusUpdate(String userId);

	int mnStatusUpdate(String userId);

}

package com.kh.spring.manager.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.manager.model.vo.Criteria;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.profile.model.vo.Profile;

@Mapper
public interface ManagerDao {

	
	// 체육관테이블
	int selectTotalRecord();

	List<Gym> selectGymList(RowBounds rowBounds);

	Gym selectOneGym(int gymNo);

	int mnGymUpdate(Gym gym);
	
	void updateGymUserId();
	
	
	// 회원테이블
	int selectTotalRecordMember();

	List<Member> selectMemberList(RowBounds rowBounds);

	Member selectOneMember(String userId);

	int mnMemberUpdate(Member member);

	Profile selectOneProfile(String userId);

	int mnProfileUpdate(Profile profile);

	int mnStatusUpdate(String userId);


	

}

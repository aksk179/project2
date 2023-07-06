package com.kh.spring.manager.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.manager.model.dao.ManagerDao;
import com.kh.spring.manager.model.vo.Criteria;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.profile.model.vo.Profile;

@Service
public class ManagerServiceImpl implements ManagerService {
	
	@Autowired
	public ManagerDao managerDao;

	@Override
	public int selectTotalRecord() {
		return managerDao.selectTotalRecord();
	}

	@Override
	public List<Gym> selectGymList(RowBounds rowBounds) {
		return managerDao.selectGymList(rowBounds);
	}
	
	@Override
	public Gym selectOneGym(int gymNo) {
		return managerDao.selectOneGym(gymNo);
	}

	@Override
	public int mnGymUpdate(Gym gym) {
		return managerDao.mnGymUpdate(gym);
	}

	@Override
	public List<Member> selectMemberList(RowBounds rowBounds) {
		return managerDao.selectMemberList(rowBounds);
	}

	@Override
	public int selectTotalRecordMember() {
		return managerDao.selectTotalRecordMember();
	}

	@Override
	public Member selectOneMember(String userId) {
		return managerDao.selectOneMember(userId);
	}

	@Override
	public int mnMemberUpdate(Member member) {
		return managerDao.mnMemberUpdate(member);
	}

	@Override
	public Profile selectOneProfile(String userId) {
		return managerDao.selectOneProfile(userId);
	}

	@Override
	public int mnProfileUpdate(Profile profile) {
		return managerDao.mnProfileUpdate(profile);
	}

	@Override
	public List<Criteria> mnMemberSearch(String searchType, String keyword) {
		return null;
	}




}

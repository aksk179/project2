package com.kh.spring.match.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;
import com.kh.spring.match.model.dao.MatchDao;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchInfo;
import com.kh.spring.match.model.vo.MatchInfoView;
import com.kh.spring.match.model.vo.MatchRegInfo;

@Service
public class MatchServiceImpl implements MatchService{

	@Autowired
	private MatchDao matchDao;

	@Override
	public List<MatchInfo> selectScheduleList(String matchDate) {
		System.out.println("ServiceImpl = selectScheduleList : " + matchDate);
		return matchDao.selectScheduleList(matchDate);
	}

	@Override
	public int registerMatch(Match match) {
		return matchDao.registerMatch(match);
	}

	@Override
	public Match selectMatch(Match match) {
		return matchDao.selectMatch(match);
	}

	@Override
	public int updateMatch(Match match) {
		return matchDao.updateMatch(match);
	}

	@Override
	public List<MatchInfo> selectMatchList(String userId, String matchDate) {
		return matchDao.selectMatchList(userId, matchDate);
	}

}

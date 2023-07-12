package com.kh.spring.match.model.service;

import java.util.List;

import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchInfo;
import com.kh.spring.match.model.vo.MatchInfoView;
import com.kh.spring.match.model.vo.MatchRegInfo;

public interface MatchService {

	List<MatchInfo> selectScheduleList(String matchDate);

	int registerMatch(Match match);

	Match selectMatch(Match match);

	int updateMatch(Match match);

	List<MatchInfo> selectMatchList(String userId, String matchDate);

	int deleteMatch(Schedule schedule);
}

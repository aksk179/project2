package com.kh.spring.match.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;
import com.kh.spring.match.model.vo.ChallengerList;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchInfo;
import com.kh.spring.match.model.vo.MatchInfoView;
import com.kh.spring.match.model.vo.MatchList;
import com.kh.spring.match.model.vo.MatchRegInfo;

@Mapper
public interface MatchDao {

	List<MatchInfo> selectScheduleList(String matchDate);

	int registerMatch(Match match);

	Match selectMatch(Match match);

	int updateMatch(Match match);

	List<MatchInfo> selectMatchList(@Param("userId")String userId, @Param("matchdate")String matchDate);

	int selectTotalRecordMatchList();

	List<MatchList> selectMatchingList(RowBounds rowBounds);

	List<MatchList> matchListFilterGender(String gender, RowBounds rowBounds);
	
	int selectTotalRecordMatchListGender(String gender);

	int selectTotalRecordMatchListLocation(String locations);

	List<MatchList> matchListFilterLocation(String locations, RowBounds rowBounds);

	int selectTotalRecordMatchListNick(String searchInput);

	List<MatchList> matchListFilterNick(String searchInput, RowBounds rowBounds);

	List<MatchList> matchListFilterDow(String dowString, RowBounds rowBounds);

	int selectTotalRecordMatchListDow(String dowString);
	
	int deleteMatch(Schedule schedule);
	
	int challengerInsertDecision(Match toCopyMatchData);

	Match toCopyMatchData(int no);

	int challengerInsertDecision4(Match toCopyMatchData);
	
	int challengerInsert(Match toCopyMatchData);

	List<MatchList> matchListReg(String userId1, RowBounds rowBounds);

	int selectTotalRecordMatchListReg(String userId1);

	List<MatchList> matchListChal(String userId2, RowBounds rowBounds);

	int selectTotalRecordMatchListChal(String userId2);

	int challengerUpdate(Match toCopyMatchData);

	int challengerInsertDecision2(Match toCopyMatchData);

	int challengerInsertDecision3(Match toCopyMatchData);

	List<ChallengerList> toChallengerList(MatchList matchListTmp);

	int regCancel(Match matchTmp);

	int chalCancel(Match toCancelMatchData);

	List<Match> selectListChal(String userId2);

	MatchList selectOneMatch(@Param("no")int no);
}

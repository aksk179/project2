package com.kh.spring.match.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;
import com.kh.spring.match.model.dao.MatchDao;
import com.kh.spring.match.model.vo.ChallengerList;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchInfo;
import com.kh.spring.match.model.vo.MatchInfoView;
import com.kh.spring.match.model.vo.MatchList;
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
		System.out.println("ServiceImpl = selectMatchList : " + matchDate);

		return matchDao.selectMatchList(userId, matchDate);
	}
	
	@Override
	public int selectTotalRecordMatchList() {
		return matchDao.selectTotalRecordMatchList();
	}

	@Override
	public List<MatchList> selectMatchingList(RowBounds rowBounds) {
		return matchDao.selectMatchingList(rowBounds);
	}

	@Override
	public List<MatchList> matchListFilterGender(String gender, RowBounds rowBounds) {
		return matchDao.matchListFilterGender(gender, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListGender(String gender) {
		return matchDao.selectTotalRecordMatchListGender(gender);
	}

	@Override
	public int selectTotalRecordMatchListLocation(String location) {
		return matchDao.selectTotalRecordMatchListLocation(location);
	}

	@Override
	public List<MatchList> matchListFilterLocation(String locations, RowBounds rowBounds) {
		return matchDao.matchListFilterLocation(locations, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListNick(String searchInput) {
		return matchDao.selectTotalRecordMatchListNick(searchInput);
	}

	@Override
	public List<MatchList> matchListFilterNick(String searchInput, RowBounds rowBounds) {
		return matchDao.matchListFilterNick(searchInput, rowBounds);
	}

	@Override
	public List<MatchList> matchListFilterDow(int dowInt, RowBounds rowBounds) {
		return matchDao.matchListFilterDow(dowInt, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListDow(int dowInt) {
		return matchDao.selectTotalRecordMatchListDow(dowInt);
	}

	@Override
	public int deleteMatch(Schedule schedule) {
		return matchDao.deleteMatch(schedule);
	}

	@Override
	public int challengerInsertDecision(Match toCopyMatchData) {
		return matchDao.challengerInsertDecision(toCopyMatchData);
	}

	@Override
	public Match toCopyMatchData(int no) {
		return matchDao.toCopyMatchData(no);
	}
	
	@Override
	public int challengerInsertDecision4(Match toCopyMatchData) {
		return matchDao.challengerInsertDecision4(toCopyMatchData);
	}
	
	@Override
	public int challengerInsert(Match toCopyMatchData) {
		return matchDao.challengerInsert(toCopyMatchData);
	}

	@Override
	public List<MatchList> matchListReg(String userId1, RowBounds rowBounds) {
		return matchDao.matchListReg(userId1, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListReg(String userId1) {
		return matchDao.selectTotalRecordMatchListReg(userId1);
	}

	@Override
	public List<MatchList> matchListChal(String userId2, RowBounds rowBounds) {
		return matchDao.matchListChal(userId2, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListChal(String userId2) {
		return matchDao.selectTotalRecordMatchListChal(userId2);
	}

	@Override
	public int challengerUpdate(Match toCopyMatchData) {
		return matchDao.challengerUpdate(toCopyMatchData);
	}

	@Override
	public int challengerInsertDecision2(Match toCopyMatchData) {
		return matchDao.challengerInsertDecision2(toCopyMatchData);
	}

	@Override
	public int challengerInsertDecision3(Match toCopyMatchData) {
		return matchDao.challengerInsertDecision3(toCopyMatchData);
	}

	@Override
	public List<ChallengerList> toChallengerList(MatchList matchListTmp) {
		return matchDao.toChallengerList(matchListTmp);
	}

	@Override
	public int regCancel(Match matchTmp) {
		return matchDao.regCancel(matchTmp);
	}

	@Override
	public int chalCancel(Match toCancelMatchData) {
		return matchDao.chalCancel(toCancelMatchData);
	}

	@Override
	public List<Match> selectListChal(String userId2) {
		return matchDao.selectListChal(userId2);
	}
	
	@Override
	public MatchList selectOneMatch(int no) {
		return matchDao.selectOneMatch(no);
	}

	@Override
	public int chalCancelUpdate(Match toCancelMatchData) {
		return matchDao.chalCancelUpdate(toCancelMatchData);
	}

	@Override
	public int challengerStatusDecision(Match toCancelMatchData) {
		return matchDao.challengerStatusDecision(toCancelMatchData);
	}

	@Override
	public int selectTotalRecordMatchListRegChal(String userId) {
		return matchDao.selectTotalRecordMatchListRegChal(userId);
	}

	@Override
	public List<MatchList> matchListRegChal(String userId, RowBounds rowBounds) {
		return matchDao.matchListRegChal(userId, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListWaitingRegPay(String userId3) {
		return matchDao.selectTotalRecordMatchListWaitingRegPay(userId3);
	}

	@Override
	public List<MatchList> myMatchWaitingRegPay(String userId3, RowBounds rowBounds) {
		return matchDao.myMatchWaitingRegPay(userId3, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListWaitingChalPay(String userId4) {
		return matchDao.selectTotalRecordMatchListWaitingChalPay(userId4);
	}
	
	@Override
	public List<MatchList> myMatchWaitingChalPay(String userId4, RowBounds rowBounds) {
		return matchDao.myMatchWaitingChalPay(userId4, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListAfterRegPay(String userId5) {
		return matchDao.selectTotalRecordMatchListAfterRegPay(userId5);
	}

	@Override
	public int selectTotalRecordMatchListAfterChalPay(String userId6) {
		return matchDao.selectTotalRecordMatchListAfterChalPay(userId6);
	}

	@Override
	public List<MatchList> myMatchAfterRegPay(String userId5, RowBounds rowBounds) {
		return matchDao.myMatchAfterRegPay(userId5, rowBounds);
	}

	@Override
	public List<MatchList> myMatchAfterChalPay(String userId6, RowBounds rowBounds) {
		return matchDao.myMatchAfterChalPay(userId6, rowBounds);
	}

	@Override
	public int selectTotalRecordMatchListAfterRegEnd(String userId7) {
		return matchDao.selectTotalRecordMatchListAfterRegEnd(userId7);
	}

	@Override
	public int selectTotalRecordMatchListAfterChalEnd(String userId8) {
		return matchDao.selectTotalRecordMatchListAfterChalEnd(userId8);
	}

	@Override
	public List<MatchList> myMatchAfterRegEnd(String userId7, RowBounds rowBounds) {
		return matchDao.myMatchAfterRegEnd(userId7, rowBounds);
	}

	@Override
	public List<MatchList> myMatchAfterChalEnd(String userId8, RowBounds rowBounds) {
		return matchDao.myMatchAfterChalEnd(userId8, rowBounds);
	}

	@Override
	public int selectTotalRecordMainListGender(String gender) {
		return matchDao.selectTotalRecordMainListGender(gender);
	}

	@Override
	public int selectTotalRecordMainListLocation(String locations) {
		return matchDao.selectTotalRecordMainListLocation(locations);
	}

	@Override
	public int selectTotalRecordMainListNick(String searchInput) {
		return matchDao.selectTotalRecordMainListNick(searchInput);
	}

	@Override
	public int selectTotalRecordMainListDow(int dowInt) {
		return matchDao.selectTotalRecordMainListDow(dowInt);
	}

	@Override
	public int selectTotalRecordMainListReg(String userId1) {
		return matchDao.selectTotalRecordMainListReg(userId1);
	}

	@Override
	public int selectTotalRecordMainListChal(String userId2) {
		return matchDao.selectTotalRecordMainListChal(userId2);
	}


	@Override
	public List<MatchList> mainListFilterGender(String gender, RowBounds rowBounds) {
		return matchDao.mainListFilterGender(gender, rowBounds);
	}

	@Override
	public List<MatchList> mainListFilterLocation(String locations, RowBounds rowBounds) {
		return matchDao.mainListFilterLocation(locations, rowBounds);
	}

	@Override
	public List<MatchList> mainListFilterNick(String searchInput, RowBounds rowBounds) {
		return matchDao.mainListFilterNick(searchInput, rowBounds);
	}

	@Override
	public List<MatchList> mainListFilterDow(int dowInt, RowBounds rowBounds) {
		return matchDao.mainListFilterDow(dowInt, rowBounds);
	}

	@Override
	public List<MatchList> mainListReg(String userId1, RowBounds rowBounds) {
		return matchDao.mainListReg(userId1, rowBounds);
	}

	@Override
	public List<MatchList> mainListChal(String userId2, RowBounds rowBounds) {
		return matchDao.mainListChal(userId2, rowBounds);
	}

	@Override
	public int selectTotalRecordMainListBeforeEnd() {
		return matchDao.selectTotalRecordMainListBeforeEnd();
	}

	@Override
	public int selectTotalRecordMainListAfterEnd() {
		return matchDao.selectTotalRecordMainListAfterEnd();
	}

	@Override
	public List<MatchList> mainListBeforeEnd(RowBounds rowBounds) {
		return matchDao.mainListBeforeEnd(rowBounds);
	}

	@Override
	public List<MatchList> mainListAfterEnd(RowBounds rowBounds) {
		return matchDao.mainListAfterEnd(rowBounds);
	}

	@Override
	public Match selectPayUser1(int no, String userId) {
		return matchDao.selectPayUser1(no, userId);
	}

	@Override
	public Match selectPayUser2(int no, String userId) {
		return matchDao.selectPayUser2(no, userId);
	}

	@Override
	public int updatePay1(Match match) {
		return matchDao.updatePay1(match);
	}

	@Override
	public int updatePay2(Match match) {
		return matchDao.updatePay2(match);
	}

	@Override
	public Match selectPayStatus(int no) {
		return matchDao.selectPayStatus(no);
	}

	@Override
	public List<Match> selectStatus0(Match match2) {
		return matchDao.selectStatus0(match2);
	}

	@Override
	public int updateMatch8(Match match4) {
		return matchDao.updateMatch8(match4);
	}

	@Override
	public Match selcUpdMatch(Match match) {
		return matchDao.selcUpdMatch(match);
	}

	@Override
	public int updateUser2Null(Match match) {
		return matchDao.updateUser2Null(match);
	}

}

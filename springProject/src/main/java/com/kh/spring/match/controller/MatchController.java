package com.kh.spring.match.controller;

import java.util.Date;
import java.util.HashMap;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.ListUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kh.spring.alarm.model.service.AlarmService;
import com.kh.spring.alarm.model.vo.Alarm;
import com.kh.spring.common.model.vo.PageInfo;
import com.kh.spring.common.template.Pagination;
import com.kh.spring.gym.model.service.GymService;
import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;
import com.kh.spring.match.model.service.MatchService;
import com.kh.spring.match.model.vo.ChallengerList;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchInfo;
import com.kh.spring.match.model.vo.MatchInfoView;
import com.kh.spring.match.model.vo.MatchList;
import com.kh.spring.match.model.vo.MatchRegInfo;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.service.MemberServiceImpl;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.profile.model.service.ProfileService;
import com.kh.spring.profile.model.vo.Profile;

@Controller
@RequestMapping("/match")
@SessionAttributes({"loginMember"})
public class MatchController {
	
	@Autowired
	private AlarmService alarmService;
	
	@Autowired
	private MatchService matchService;
	
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private MemberService memberSevice;
	
	@Autowired
	private GymService gymService;

	
	@GetMapping("/matchList.ma")
	public void matchList(@RequestParam(defaultValue="1") int nowPage, Model model,
			              @RequestParam(defaultValue="gender") String gender,
			              @RequestParam(defaultValue="loc") String locations,
			              @RequestParam(defaultValue="") String searchInput,
			              @RequestParam(defaultValue="8") int dowFromSelect,
			              @RequestParam(defaultValue="") String userId1,
			              @RequestParam(defaultValue="") String userId2) {
		int totalRecord = 0;
		int dowInt = 8;
		String filterType = null;
		String filterTypeValue = null;
		if(gender.equals("M") || gender.equals("F")) {
			totalRecord = matchService.selectTotalRecordMatchListGender(gender);
		} else if(locations.equals("서울") ||
				  locations.equals("경기") ||
				  locations.equals("충청") ||
				  locations.equals("대전") ||
				  locations.equals("강원") ||
				  locations.equals("경상") ||
				  locations.equals("대구") ||
				  locations.equals("부산") ||
				  locations.equals("전라") ||
				  locations.equals("광주") ||
				  locations.equals("제주")) {
			totalRecord = matchService.selectTotalRecordMatchListLocation(locations);
		} else if(!("".equals(searchInput))) {
			totalRecord = matchService.selectTotalRecordMatchListNick(searchInput);
		} else if(1<= dowFromSelect && dowFromSelect <=7) {
			if(dowFromSelect == 2) {
				dowInt = 2;
			} else if(dowFromSelect == 3) {
				dowInt = 3;
			} else if(dowFromSelect == 4) {
				dowInt = 4;
			} else if(dowFromSelect == 5) {
				dowInt = 5;
			} else if(dowFromSelect == 6) {
				dowInt = 6;
			} else if(dowFromSelect == 7) {
				dowInt = 7;
			} else {
				dowInt = 1;
			}
			totalRecord = matchService.selectTotalRecordMatchListDow(dowInt);
		} else if(!(userId1.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListReg(userId1);
		} else if(!(userId2.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListChal(userId2);
	    } else {
			totalRecord = matchService.selectTotalRecordMatchList();
		}
		
		int limit = 10;
		int offset = (nowPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<MatchList> matchList = null;
		
		if(gender.equals("M") || gender.equals("F")) {
			matchList = matchService.matchListFilterGender(gender, rowBounds);
			filterType = "gender";
			filterTypeValue = gender;
		} else if(locations.equals("서울") ||
				  locations.equals("경기") ||
				  locations.equals("충청") ||
				  locations.equals("대전") ||
				  locations.equals("강원") ||
				  locations.equals("경상") ||
				  locations.equals("대구") ||
				  locations.equals("부산") ||
				  locations.equals("전라") ||
				  locations.equals("광주") ||
				  locations.equals("제주")) {
			matchList = matchService.matchListFilterLocation(locations, rowBounds);
			filterType = "locations";
			filterTypeValue = locations;
		} else if(!("".equals(searchInput))) {
			matchList = matchService.matchListFilterNick(searchInput, rowBounds);
			filterType = "searchInput";
			filterTypeValue = searchInput;
		} else if(1<= dowFromSelect && dowFromSelect <=7) {
			if(dowFromSelect == 2) {
				dowInt = 2;
			} else if(dowFromSelect == 3) {
				dowInt = 3;
			} else if(dowFromSelect == 4) {
				dowInt = 4;
			} else if(dowFromSelect == 5) {
				dowInt = 5;
			} else if(dowFromSelect == 6) {
				dowInt = 6;
			} else if(dowFromSelect == 7) {
				dowInt = 7;
			} else {
				dowInt = 1;
			}
			
			matchList = matchService.matchListFilterDow(dowInt, rowBounds);
			filterType = "dowFromSelect";
			filterTypeValue = String.valueOf(dowFromSelect);
		} else if(!(userId1.equals(""))) {
			matchList = matchService.matchListReg(userId1, rowBounds);
			filterType = "userId1";
			filterTypeValue = userId1;
		} else if(!(userId2.equals(""))) {
			matchList = matchService.matchListChal(userId2, rowBounds);
			filterType = "userId2";
			filterTypeValue = userId2;
		} else {
		  matchList = matchService.selectMatchingList(rowBounds);
		}
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M월 dd일 E요일").withLocale(Locale.forLanguageTag("ko"));
		
		for(int i=0; i<matchList.size(); i++) {
			matchList.get(i).getMatchdate();
			LocalDateTime date = matchList.get(i).getMatchdate();
			matchList.get(i).setMatchdatestring(formatter.format(date));
			
			MatchList matchListTmp = matchList.get(i);
			
			List<ChallengerList> challengerMembers = matchService.toChallengerList(matchListTmp);
			
			
				for(int j=0; j<challengerMembers.size(); j++) {
				
					if(challengerMembers.get(j) != null) {
						if(matchList.get(i).getChallenger1() == null) {
							String ch1 = challengerMembers.get(j).getUserId2();
							matchList.get(i).setChallenger1(ch1);
						} else if(matchList.get(i).getChallenger2() == null) {
							matchList.get(i).setChallenger2(challengerMembers.get(j).getUserId2());
						} else if(matchList.get(i).getChallenger3() == null) {
							matchList.get(i).setChallenger3(challengerMembers.get(j).getUserId2());
						} else if(matchList.get(i).getChallenger4() == null) {
							matchList.get(i).setChallenger4(challengerMembers.get(j).getUserId2());
						} else if(matchList.get(i).getChallenger5() == null) {
							matchList.get(i).setChallenger5(challengerMembers.get(j).getUserId2());
						} else {
							model.addAttribute("msg", "신청자초과");
						}
					}
					
				}
		}
		
		model.addAttribute("matchList", matchList);
		model.addAttribute("pi", pi);
		model.addAttribute("filterType", filterType);
		model.addAttribute("filterTypeValue", filterTypeValue);
	}
	
	@GetMapping("/myMatch.ma")
	public void myMatch(@RequestParam(defaultValue="1") int nowPage, Model model,
						@RequestParam(defaultValue="") String userId1,
						@RequestParam(defaultValue="") String userId2,
						@RequestParam(defaultValue="") String userId,
						@RequestParam(defaultValue="") String userId3,
						@RequestParam(defaultValue="") String userId4,
						@RequestParam(defaultValue="") String userId5,
						@RequestParam(defaultValue="") String userId6,
						@RequestParam(defaultValue="") String userId7,
						@RequestParam(defaultValue="") String userId8) {
		int totalRecord = 0;
		String filterType = null;
		String filterTypeValue = null;
		
		if(!(userId1.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListReg(userId1);
		} else if(!(userId2.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListChal(userId2);
		} else if(!(userId3.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListWaitingRegPay(userId3);
		} else if(!(userId4.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListWaitingChalPay(userId4);
		} else if(!(userId5.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListAfterRegPay(userId5);
		} else if(!(userId6.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListAfterChalPay(userId6);
		} else if(!(userId7.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListAfterRegEnd(userId7);
		} else if(!(userId8.equals(""))) {
			totalRecord = matchService.selectTotalRecordMatchListAfterChalEnd(userId8);
		} else {
			totalRecord = matchService.selectTotalRecordMatchListReg(userId);
		}	
		
		
		int limit = 5;
		int offset = (nowPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<MatchList> myMatch = null;
		
		if(!(userId1.equals(""))) {
			myMatch = matchService.matchListReg(userId1, rowBounds);
			filterType = "userId1";
			filterTypeValue = userId1;
		} else if(!(userId2.equals(""))) {
			myMatch = matchService.matchListChal(userId2, rowBounds);
			filterType = "userId2";
			filterTypeValue = userId2;
		} else if(!(userId3.equals(""))) {
			myMatch = matchService.myMatchWaitingRegPay(userId3, rowBounds);
			filterType = "userId3";
			filterTypeValue = userId3;
		} else if(!(userId4.equals(""))) {
			myMatch = matchService.myMatchWaitingChalPay(userId4, rowBounds);
			filterType = "userId4";
			filterTypeValue = userId4;
		} else if(!(userId5.equals(""))) {
			myMatch = matchService.myMatchAfterRegPay(userId5, rowBounds);
			filterType = "userId5";
			filterTypeValue = userId5;
		} else if(!(userId6.equals(""))) {
			myMatch = matchService.myMatchAfterChalPay(userId6, rowBounds);
			filterType = "userId6";
			filterTypeValue = userId6;
		} else if(!(userId7.equals(""))) {
			myMatch = matchService.myMatchAfterRegEnd(userId7, rowBounds);
			filterType = "userId7";
			filterTypeValue = userId7;
		} else if(!(userId8.equals(""))) {
			myMatch = matchService.myMatchAfterChalEnd(userId8, rowBounds);
			filterType = "userId8";
			filterTypeValue = userId8;
		} else {
			myMatch = matchService.matchListReg(userId, rowBounds);
			filterType = "userId1";
			filterTypeValue = userId1;
		}
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M월 dd일 E요일").withLocale(Locale.forLanguageTag("ko"));
		
		for(int i=0; i<myMatch.size(); i++) {
			myMatch.get(i).getMatchdate();
		LocalDateTime date = myMatch.get(i).getMatchdate();
		myMatch.get(i).setMatchdatestring(formatter.format(date));
		
		MatchList myMatchTmp = myMatch.get(i);
		
		List<ChallengerList> challengerMembers = matchService.toChallengerList(myMatchTmp);
		Profile ch2 = null;
		
			for(int j=0; j<challengerMembers.size(); j++) {
				if(challengerMembers.get(j) != null) {
					if(myMatch.get(i).getChallenger1() == null) {
						String ch1 = challengerMembers.get(j).getUserId2();
						myMatch.get(i).setChallenger1(ch1);
					} else if(myMatch.get(i).getChallenger2() == null) {
						myMatch.get(i).setChallenger2(challengerMembers.get(j).getUserId2());
					} else if(myMatch.get(i).getChallenger3() == null) {
						myMatch.get(i).setChallenger3(challengerMembers.get(j).getUserId2());
					} else if(myMatch.get(i).getChallenger4() == null) {
						myMatch.get(i).setChallenger4(challengerMembers.get(j).getUserId2());
					} else if(myMatch.get(i).getChallenger5() == null) {
						myMatch.get(i).setChallenger5(challengerMembers.get(j).getUserId2());
					} else {
						model.addAttribute("msg", "신청자초과");
					}
				}
			}	
				
			if(myMatch.get(i).getChallenger1() != null) {
				myMatch.get(i).setChallenger1Nick(profileService.selectOneProfile(myMatch.get(i).getChallenger1()).getProNick());
				Match match = new Match();
				match.setUserId1(myMatch.get(i).getUserId1());
				match.setUserId2(myMatch.get(i).getChallenger1());
				match.setMatchNo(myMatch.get(i).getMatchNo());
				myMatch.get(i).setChallenger1No(matchService.selcUpdMatch(match).getNo());
			}
			if(myMatch.get(i).getChallenger2() != null) {
				myMatch.get(i).setChallenger2Nick(profileService.selectOneProfile(myMatch.get(i).getChallenger2()).getProNick());
				Match match = new Match();
				match.setUserId1(myMatch.get(i).getUserId1());
				match.setUserId2(myMatch.get(i).getChallenger1());
				match.setMatchNo(myMatch.get(i).getMatchNo());
				myMatch.get(i).setChallenger2No(matchService.selcUpdMatch(match).getNo());
			}
			if(myMatch.get(i).getChallenger3() != null) {
				myMatch.get(i).setChallenger3Nick(profileService.selectOneProfile(myMatch.get(i).getChallenger3()).getProNick());
				Match match = new Match();
				match.setUserId1(myMatch.get(i).getUserId1());
				match.setUserId2(myMatch.get(i).getChallenger1());
				match.setMatchNo(myMatch.get(i).getMatchNo());
				myMatch.get(i).setChallenger3No(matchService.selcUpdMatch(match).getNo());
			}
			if(myMatch.get(i).getChallenger4() != null) {
				myMatch.get(i).setChallenger4Nick(profileService.selectOneProfile(myMatch.get(i).getChallenger4()).getProNick());
				Match match = new Match();
				match.setUserId1(myMatch.get(i).getUserId1());
				match.setUserId2(myMatch.get(i).getChallenger1());
				match.setMatchNo(myMatch.get(i).getMatchNo());
				myMatch.get(i).setChallenger4No(matchService.selcUpdMatch(match).getNo());
			}
			if(myMatch.get(i).getChallenger5() != null) {
				myMatch.get(i).setChallenger5Nick(profileService.selectOneProfile(myMatch.get(i).getChallenger5()).getProNick());
				Match match = new Match();
				match.setUserId1(myMatch.get(i).getUserId1());
				match.setUserId2(myMatch.get(i).getChallenger1());
				match.setMatchNo(myMatch.get(i).getMatchNo());
				myMatch.get(i).setChallenger5No(matchService.selcUpdMatch(match).getNo());
			}
			
		}
		
		model.addAttribute("filterType", filterType);
		model.addAttribute("filterTypeValue", filterTypeValue);
		model.addAttribute("myMatch", myMatch);
		model.addAttribute("pi", pi);
	}
	
	@GetMapping("/mainList.ma")
	public void mainList(@RequestParam(defaultValue="1") int nowPage, Model model,
			              @RequestParam(defaultValue="loc") String locations,
			              @RequestParam(defaultValue="8") int dowFromSelect,
			              @RequestParam(defaultValue="") String userId1,
			              @RequestParam(defaultValue="") String userId2,
			              @RequestParam(defaultValue="") String before,
			              @RequestParam(defaultValue="") String after) {
		int totalRecord = 0;
		int dowInt = 8;
		String filterType = null;
		String filterTypeValue = null;
		if(locations.equals("서울") ||
				  locations.equals("경기") ||
				  locations.equals("충청") ||
				  locations.equals("대전") ||
				  locations.equals("강원") ||
				  locations.equals("경상") ||
				  locations.equals("대구") ||
				  locations.equals("부산") ||
				  locations.equals("전라") ||
				  locations.equals("광주") ||
				  locations.equals("제주")) {
			totalRecord = matchService.selectTotalRecordMainListLocation(locations);
		} else if(1<= dowFromSelect && dowFromSelect <=7) {
			if(dowFromSelect == 2) {
				dowInt = 2;
			} else if(dowFromSelect == 3) {
				dowInt = 3;
			} else if(dowFromSelect == 4) {
				dowInt = 4;
			} else if(dowFromSelect == 5) {
				dowInt = 5;
			} else if(dowFromSelect == 6) {
				dowInt = 6;
			} else if(dowFromSelect == 7) {
				dowInt = 7;
			} else {
				dowInt = 1;
			}
			totalRecord = matchService.selectTotalRecordMainListDow(dowInt);
		} else if(!(userId1.equals(""))) {
			totalRecord = matchService.selectTotalRecordMainListReg(userId1);
		} else if(!(userId2.equals(""))) {
			totalRecord = matchService.selectTotalRecordMainListChal(userId2);
		} else if(!(before.equals(""))) {
			totalRecord = matchService.selectTotalRecordMainListBeforeEnd();
	    } else if(!(after.equals(""))) {
	    	totalRecord = matchService.selectTotalRecordMainListAfterEnd();
	    } else {
	    	totalRecord = matchService.selectTotalRecordMainListBeforeEnd();
	    }
	    	
		int limit = 10;
		int offset = (nowPage - 1) * limit;
		RowBounds rowBounds = new RowBounds(offset, limit);
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<MatchList> matchList = null;
		
		if(locations.equals("서울") ||
				  locations.equals("경기") ||
				  locations.equals("충청") ||
				  locations.equals("대전") ||
				  locations.equals("강원") ||
				  locations.equals("경상") ||
				  locations.equals("대구") ||
				  locations.equals("부산") ||
				  locations.equals("전라") ||
				  locations.equals("광주") ||
				  locations.equals("제주")) {
			matchList = matchService.mainListFilterLocation(locations, rowBounds);
			filterType = "locations";
			filterTypeValue = locations;
		} else if(1<= dowFromSelect && dowFromSelect <=7) {
			if(dowFromSelect == 2) {
				dowInt = 2;
			} else if(dowFromSelect == 3) {
				dowInt = 3;
			} else if(dowFromSelect == 4) {
				dowInt = 4;
			} else if(dowFromSelect == 5) {
				dowInt = 5;
			} else if(dowFromSelect == 6) {
				dowInt = 6;
			} else if(dowFromSelect == 7) {
				dowInt = 7;
			} else {
				dowInt = 1;
			}
			
			matchList = matchService.mainListFilterDow(dowInt, rowBounds);
			filterType = "dowFromSelect";
			filterTypeValue = String.valueOf(dowFromSelect);
		} else if(!(userId1.equals(""))) {
			matchList = matchService.mainListReg(userId1, rowBounds);
			filterType = "userId1";
			filterTypeValue = userId1;
		} else if(!(userId2.equals(""))) {
			matchList = matchService.mainListChal(userId2, rowBounds);
			filterType = "userId2";
			filterTypeValue = userId2;
		} else if(!(before.equals(""))) {
			matchList = matchService.mainListBeforeEnd(rowBounds);
			filterType = "before";
			filterTypeValue = before;
		} else if(!(after.equals(""))) {
			matchList = matchService.mainListAfterEnd(rowBounds);
			filterType = "after";
			filterTypeValue = after;
		} else {
			matchList = matchService.mainListBeforeEnd(rowBounds);
			filterType = "before";
			filterTypeValue = before;
		}
		
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M월 dd일 E요일").withLocale(Locale.forLanguageTag("ko"));
		
		for(int i=0; i<matchList.size(); i++) {
			LocalDateTime date = matchList.get(i).getMatchdate();
			matchList.get(i).setMatchdatestring(formatter.format(date));
			Profile profile = profileService.selectOneProfile(matchList.get(i).getUserId2());
			String proNick2 = profile.getProNick();
			matchList.get(i).setProNick2(proNick2);
		}
		model.addAttribute("matchList", matchList);
		model.addAttribute("pi", pi);
		model.addAttribute("filterType", filterType);
		model.addAttribute("filterTypeValue", filterTypeValue);
	}
	
	@GetMapping("/challengerAdd.ma")
	public String challengerAdd(@RequestParam int no, @RequestParam String userId1, @RequestParam String userId2, @RequestParam String matchdateString, 
								@RequestParam String matchTime, @RequestParam String gymName, @RequestParam String proNick1, @RequestParam String matchNo, RedirectAttributes redirectAtt) {
			System.out.println("넘어온 값들 : " + no + userId1 + userId2 + matchdateString + matchTime + gymName + proNick1 + matchNo);
			// 로그인을 하고, 신청버튼을 누르면, 그 해당 매치의 시퀀스 번호, 신청자의 아이디가 들어온다.
			// 해당 매치의 시퀀스 번호는 무조건, 매치상태가 1이다(원조).
			// 해당 매치의 시퀀스 번호를 매개로 해서, 해당 매치 테이블의 모든 데이터를 복사해 온다.
			// 1번상태, 유저2가 널인 상태면, 원조 - 매치공통번호 - 유저1 - 널 - 무조건1(스테이터스)
			// 2번상태, 유저2가 있는 상태면, 원조 - 매치공통번호 - 유저1 - 유저2 - 무조건1(스테이터스)
		
			// 현재 데이터가 1번상태일땐, 업데이트를 해준다. 바로 데이터가 1번상태인지 검증하는 것이 디시전1이다.
			// 업데이트를 해주기 전에, 유저2를 넣어준 투업데이트매치데이터를 넣어서, 업데이트를 해준다.
			// 이제, 해당 매치 시퀀스 번호의 테이블 데이터는, 원조 - 매치공통번호 - 유저1 - 유저2 - 무조건1(스테이터스)
		
			// 현재 데이터가 2번상태이면서(디시전2), 해당 시퀀스의 번호에 해당하는 유저1 + 매치공통번호 조합의 수가 1개 ~ 4개에 해당 될때만(디시전3), 추가한다.
		    // 추가를 해주기 전에, 유저2와 스테이터스를 0으로 업데이트한 투인풋매치데이터를 준비시키고, 그것을 넣어준다.
		    // 해당 사항이 구축되려면, 디시전2와 디시전3와 디시전4가 참이어야 한다.
			// 디시전4는, 신청자의 아이디와, 중복되는 유저2를 가진, 해당 시퀀스 번호에 해당하는 유저1 + 매치공통번호 조합의 수가 0인지 확인하는 것. 
			// 이제, 해당 매치 시퀀스 번호의 테이블 데이터는, 원조 - 매치공통번호 - 유저1 - 유저2 - 무조건1(스테이터스)이며,
		    // 해당 시퀀스 번호에 해당하는 유저1 + 매치공통번호 조합의 수가 최대 5개까지 추가가 되는 것이다.
		    // 때문에 5개가 되었을땐, 디시전3를 통과하지 못하기 때문에 추가가 되지 못한다.
		
			Profile profile = profileService.selectOneProfile(userId2);
			String proNick2 = profile.getProNick();
			
			Alarm alarm = new Alarm();
			alarm.setReceiverId(userId1);
			alarm.setSenderId(userId2);
			
			String alarmMsg = proNick2 + "님이 " + gymName + " " + matchdateString + " " + matchTime + " 매치에 도전하였습니다. 수락하시겠습니까?";
			alarm.setAlarmMsg(alarmMsg);
			
			alarm.setReadYn("N");
			alarm.setAlarmStatus(2);
					
			System.out.println(alarm);
			
			Match toCopyMatchData = matchService.toCopyMatchData(no);
			int challengerInsertDecision = matchService.challengerInsertDecision(toCopyMatchData);
			int challengerInsertDecision2 = matchService.challengerInsertDecision2(toCopyMatchData);
			int challengerInsertDecision3 = matchService.challengerInsertDecision3(toCopyMatchData);
			
			Match toCheckDecision4 = matchService.toCopyMatchData(no);
			toCheckDecision4.setUserId2(userId2);
			int challengerInsertDecision4 = matchService.challengerInsertDecision4(toCheckDecision4);
			
			if(challengerInsertDecision == 1) {
				System.out.println("if문 들어왔어");
				Match toUpdateMatchData = matchService.toCopyMatchData(no);
				toUpdateMatchData.setUserId2(userId2);
				try {
					int result = matchService.challengerUpdate(toUpdateMatchData);
					System.out.println("match테이블 업데이트 성공");			
				
					Match match = new Match();
					match.setMatchNo(matchNo);
					match.setUserId1(userId1);
					match.setUserId2(userId2);
					System.out.println(match);
					
					Match match2 = new Match();
					match2 = matchService.selcUpdMatch(match);
					alarm.setNo(match2.getNo());
		               
					int result2 = alarmService.insertAlarm(alarm);
					System.out.println(result2);
					System.out.println("alarm테이블 insert 성공");
					redirectAtt.addFlashAttribute("msg", "도전 신청이 완료 되었습니다.");
				} catch(Exception e) {
					redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
				}
			} else if(challengerInsertDecision2 == 1) {
				System.out.println("else if문 들어왔어");
				if(1 <= challengerInsertDecision3 && challengerInsertDecision3 < 5) {
					System.out.println(challengerInsertDecision4);
					if(challengerInsertDecision4 == 0) {
						System.out.println("decision4 통과");
						Match toInputMatchData = matchService.toCopyMatchData(no);
						toInputMatchData.setUserId2(userId2);
						toInputMatchData.setMatchStatus(0);
						try {
							int result = matchService.challengerInsert(toInputMatchData);
							System.out.println("match테이블 인서트 성공");
							
							Match match = new Match();
							match.setMatchNo(matchNo);
							match.setUserId1(userId1);
							match.setUserId2(userId2);
							System.out.println(match);
							
							Match match2 = new Match();
							match2 = matchService.selcUpdMatch(match);
							alarm.setNo(match2.getNo());
							
							int result2 = alarmService.insertAlarm(alarm);
							System.out.println(result2);
							System.out.println("alarm테이블 insert 성공");
							redirectAtt.addFlashAttribute("msg", "도전 신청이 완료 되었습니다.");
						} catch(Exception e) {
							redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
						}
					} else {
						redirectAtt.addFlashAttribute("msg", "당신은 이미 이 매치에 도전 신청을 했습니다.");
					}
				} else {
					redirectAtt.addFlashAttribute("msg", "최대도전자 인원이 5명이라, 신청이 불가합니다.");
				}
			} 
		
		return "redirect:/match/matchList.ma?nowPage="+1;
	}
	
	@GetMapping("/regCancel.ma")
	public String regCancel(@RequestParam String matchNo, @RequestParam String userId1, RedirectAttributes redirectAtt, @RequestParam(defaultValue="") String from) {
		Match matchTmp = new Match();
		matchTmp.setMatchNo(matchNo);
		matchTmp.setUserId1(userId1);
		
		try {
			int result = matchService.regCancel(matchTmp);
			redirectAtt.addFlashAttribute("msg", "등록된 매치가 취소되었습니다.");
		} catch(Exception e) {
			redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
		}
		
		if(from.equals("myMatch")) {
			return "redirect:/match/myMatch.ma?nowPage="+1+"&userId="+userId1;
		} else {
			return "redirect:/match/matchList.ma?nowPage="+1;
		}
	}
	
	@GetMapping("/chalCancel.ma")
	public String chalCancel(@RequestParam int no, @RequestParam String userId2, RedirectAttributes redirectAtt, @RequestParam(defaultValue="") String from) {
			Match toCopyMatchData = matchService.toCopyMatchData(no);
			
			int challengerCancelDecision = matchService.challengerInsertDecision3(toCopyMatchData);
			
			if(1 <= challengerCancelDecision && challengerCancelDecision <= 5) {
				Match toCancelMatchData = matchService.toCopyMatchData(no);
				toCancelMatchData.setUserId2(userId2);
				int challengerCancelDecision2 = matchService.challengerStatusDecision(toCancelMatchData);
				
				if(challengerCancelDecision2 == 1) {
					try {
						int result = matchService.chalCancelUpdate(toCancelMatchData);
						redirectAtt.addFlashAttribute("msg", "매치에 신청된 도전이 취소되었습니다.");
					} catch(Exception e) {
						redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
					}
				} else {
					try {
						int result = matchService.chalCancel(toCancelMatchData);
						redirectAtt.addFlashAttribute("msg", "매치에 신청된 도전이 취소되었습니다.");
					} catch(Exception e) {
						redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
					}
				}
				
			} else {
				redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
			}
			if(from.equals("myMatch")) {
	
					return "redirect:/match/myMatch.ma?nowPage="+1+"&userId="+userId2;
				
			} else {
				return "redirect:/match/matchList.ma?nowPage="+1;
			}
	}
	
	
	
	@GetMapping("/chalCancelFromMe.ma")
	public String chalCancel(@RequestParam int no, @RequestParam String userId2, RedirectAttributes redirectAtt, @RequestParam(defaultValue="") String from, @RequestParam(defaultValue="") String loginUserId) {
			Match toCopyMatchData = matchService.toCopyMatchData(no);
			
			int challengerCancelDecision = matchService.challengerInsertDecision3(toCopyMatchData);
			
			if(1 <= challengerCancelDecision && challengerCancelDecision <= 5) {
				Match toCancelMatchData = matchService.toCopyMatchData(no);
				toCancelMatchData.setUserId2(userId2);
				int challengerCancelDecision2 = matchService.challengerStatusDecision(toCancelMatchData);
				
				if(challengerCancelDecision2 == 1) {
					try {
						int result = matchService.chalCancelUpdate(toCancelMatchData);
						redirectAtt.addFlashAttribute("msg", "매치에 신청된 도전이 취소되었습니다.");
					} catch(Exception e) {
						redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
					}
				} else {
					try {
						int result = matchService.chalCancel(toCancelMatchData);
						redirectAtt.addFlashAttribute("msg", "매치에 신청된 도전이 취소되었습니다.");
					} catch(Exception e) {
						redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
					}
				}
				
			} else {
				redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
			}
			if(from.equals("myMatch")) {
					return "redirect:/match/myMatch.ma?nowPage="+1+"&userId="+loginUserId;
				
			} else {
				return "redirect:/match/matchList.ma?nowPage="+1;
			}
	}
	
	
	

	@RequestMapping(value="/matchReg.ma", method = RequestMethod.GET)
	public String matchReg(HttpServletRequest request, HttpServletResponse response, HttpSession session, Model model) {	
		Member member = (Member) session.getAttribute("loginMember");
		String userId = member.getUserId();
		
		Member member2 = memberSevice.selectOneMember(userId);
		int userStatus = member2.getUserStatus();
		
		if(userStatus == 1) {
			response.setContentType("text/html; charset=UTF-8");
			 
			PrintWriter out;
			try {				
				out = response.getWriter();
				out.println("<script>alert('프로필 등록 후 이용해주세요.'); location.href='/spring/profile/profileEnroll.pr';</script>");				
				out.flush();
			} catch (IOException e) {
				e.printStackTrace();
			}		 
		} else {
			String matchDate = request.getParameter("day");
			if(matchDate == null || "".equals(matchDate)) {
				LocalDateTime today = LocalDateTime.now();
				System.out.println(today);
				matchDate = today.toLocalDate().toString();	
			}
			System.out.println("matchDate : " + matchDate);
			
			//matchdateList포맷용 ex.2023/07/05
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d(E)");
	
	
			
			//지도 옆에 보이는 매치 신청한 리스트 조회
			List<MatchInfo> insertScheduleList = matchService.selectMatchList(userId, matchDate);
			System.out.println("화면에 보이는 등록된 스케줄 : " + insertScheduleList);
	
			MatchInfoView infoView = new MatchInfoView();
			List<MatchInfoView> inSchedList = new ArrayList<MatchInfoView>();
			
			for(int i=0; i<insertScheduleList.size(); i++) {
				System.out.println(insertScheduleList.get(i));
				infoView = new MatchInfoView();
				
				String gNo = insertScheduleList.get(i).getGymNo();
				String name = insertScheduleList.get(i).getGymName();
				LocalDateTime date = insertScheduleList.get(i).getMatchdate();
				String tm = insertScheduleList.get(i).getMatchtime();
				String cd = insertScheduleList.get(i).getCode();
				int num = insertScheduleList.get(i).getNum();
				
				infoView.setGymNo(gNo);
				infoView.setGymName(name);
				infoView.setMatchdate(formatter.format(date));
				infoView.setMatchday(date);
				infoView.setTime(tm);
				infoView.setCode(cd);
				infoView.setNum(num);
				
				inSchedList.add(infoView);
			}
			System.out.println(inSchedList);
			
			model.addAttribute("inSchedList", inSchedList);		
			//////////////////////////////////////////////////////////////////////
			
			
			
			 
			
			Match match = new Match();
			//지도에 보여질 GYM, SCHEDULE 테이블 조인해서 조회하는 부분
			List<MatchInfo> scheduleList = matchService.selectScheduleList(matchDate);
			System.out.println("지도에 보이는 체육관 스케줄 : " + scheduleList);
			
			String tempGymNo = "0";
			String matchdate1 = "";
			LocalDateTime matchday1 = null;
			String time = "";
			
			List<String> matchdates = new ArrayList<String>();
			List<LocalDateTime> matchdays = new ArrayList<>();
			List<String> times = new ArrayList<String>();
			List<String> codes = new ArrayList<String>();
			List<String> nums = new ArrayList<String>();
			//MatchInfoView infoView = new MatchInfoView();
			List<MatchInfoView> markerOverlayList = new ArrayList<MatchInfoView>();
			
			for(int i=0; i<scheduleList.size(); i++) {
				System.out.println(scheduleList.get(i));
				String gymNo = scheduleList.get(i).getGymNo();
				String gymName = scheduleList.get(i).getGymName();
				String gymAddress = scheduleList.get(i).getGymAddress();
				String gymDetailAddress = scheduleList.get(i).getGymDetailAddress();
				LocalDateTime matchdate = scheduleList.get(i).getMatchdate();
				String matchtime = scheduleList.get(i).getMatchtime();
				String code = scheduleList.get(i).getCode();
				int numTemp = scheduleList.get(i).getNum();
				String num = Integer.toString(numTemp);
				
				//System.out.println("localdatetime : " + matchdate);
				Date dateTemp = java.sql.Timestamp.valueOf(matchdate);
				//System.out.println("date : " + dateTemp);
						
				if(!tempGymNo.equals(gymNo)) {
					if(!tempGymNo.equals("0")) {
						infoView.setMatchdateList(matchdates);
						infoView.setMatchdayList(matchdays);
						infoView.setMatchTimeList(times);
						infoView.setCodeList(codes);
						infoView.setNumList(nums);
						markerOverlayList.add(infoView);
						times = new ArrayList<String>();
						codes = new ArrayList<String>();
						nums = new ArrayList<String>();
					}
					infoView = new MatchInfoView();
					
					infoView.setGymNo(gymNo);
					infoView.setGymName(gymName);
					infoView.setGymAddress(gymAddress);
					infoView.setGymDetailAddress(gymDetailAddress);
					//System.out.println("matchdate : " + matchdate);
					
					matchdate1 = formatter.format(matchdate);
					matchday1 = matchdate;
					time = (matchtime.substring(0, 2) + ":" + matchtime.substring(2));
					
					matchdates.add(matchdate1);
					matchdays.add(matchday1);
					times.add(time);
					codes.add(code);
					nums.add(num);
	
					tempGymNo = gymNo;
				} else {
					matchdate1 = formatter.format(matchdate);
					matchday1 = matchdate;
					time = (matchtime.substring(0, 2) + ":" + matchtime.substring(2));
					//System.out.println("시간 : " + time);
					
					matchdates.add(matchdate1);
					matchdays.add(matchday1);
					times.add(time);
					codes.add(code);
					nums.add(num);
				}
			}
			if(!tempGymNo.equals("0")) {
				infoView.setMatchdateList(matchdates);
				infoView.setMatchdayList(matchdays);
				infoView.setMatchTimeList(times);
				infoView.setCodeList(codes);
				infoView.setNumList(nums);
				markerOverlayList.add(infoView);
				//System.out.println(markerOverlayList);
			}
	
	
			model.addAttribute("dateFilter", getDateList());
			model.addAttribute("markerOverlayList", markerOverlayList);
			}
		return "/match/matchReg";
	}
	
	@ResponseBody
	@RequestMapping(value="/register.do", method = RequestMethod.POST)
	public String registerMatch(@RequestBody List<MatchRegInfo> matchRegInfoList, HttpSession session, HttpServletResponse response) {
		System.out.println("registerMatch() =======================================");
		Match match = new Match();
		int result = 0;
		
		Gson gson = new Gson();
		 
        // Json key, value 추가
        JsonObject jsonObject = new JsonObject();		
		
		for(MatchRegInfo mri : matchRegInfoList) {		
			System.out.println(mri.toString());

			String matchNo = mri.getCode();
			int gymNo = mri.getGymNo();
			
			Member member = (Member) session.getAttribute("loginMember");
			String userId = member.getUserId();
			System.out.println(userId);
			System.out.println(mri.getGymNo());
			
			Member member2 = memberSevice.selectOneMember(userId);
			
			if(member2.getUserType().equals("coach")) {
				Gym gym = gymService.getGymByUserId(userId);
				System.out.println(gym.getGymNo());
			
				if(mri.getGymNo() == gym.getGymNo()) {
			        jsonObject.addProperty("result", "NOT_OK");
			        jsonObject.addProperty("msg", "규정 상 본인 체육관에서는 매치를 할 수 없습니다. 다른 체육관을 이용해주세요.");
				} else {
					String delYnCge = mri.getValue();
					System.out.println("mri에서 가져온 값 : " + matchNo + gymNo + delYnCge);
					int num = mri.getNum();
					
					match.setMatchNo(matchNo);
					match.setGymNo(gymNo);
					match.setUserId1(userId);
					match.setMatchStatus(1);
					match.setDelYn(delYnCge);
					match.setNum(num);
					Match matchOne = matchService.selectMatch(match);
					//System.out.println(matchOne);
					
					// 문자열
			        String dateStr = mri.getMatchday();
			 
			        // 포맷터
			        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
			        
			        // 문자열 -> Date
			        LocalDateTime date = LocalDateTime.parse(dateStr);
					
					//if(matchNo, gymNo, userId1 가 db에 없으면)
					//	insert
					//있으면
					//} else {
					//  update
					//}	       
					if(matchOne == null) {		
						match.setMatchdate(date);
						match.setMatchtime(mri.getMatchtime());
						match.setMatchStatus(1);
						match.setDelYn(mri.getValue());
						
						//System.out.println("insert문");
						result = matchService.registerMatch(match);
						
						if(result > 0) {
					        jsonObject.addProperty("result", "OK");
					        jsonObject.addProperty("msg", "등록되었습니다.");
				        } else {
					        jsonObject.addProperty("result", "NOT_OK");
					        jsonObject.addProperty("msg", "등록 실패했습니다.");
				        } 
					} else {
						//System.out.println("updat문");
		
						match.setDelYn(mri.getValue());				
						System.out.println(match);
						
						result = matchService.updateMatch(match);
						
						if(result > 0) {
					        jsonObject.addProperty("result", "OK");
					        jsonObject.addProperty("msg", "등록되었습니다.");
				        } else {
					        jsonObject.addProperty("result", "NOT_OK");
					        jsonObject.addProperty("msg", "등록 실패했습니다.");
				        } 
					} 	
				}
			} else {
				String delYnCge = mri.getValue();
				System.out.println("mri에서 가져온 값 : " + matchNo + gymNo + delYnCge);
				int num = mri.getNum();
				
				match.setMatchNo(matchNo);
				match.setGymNo(gymNo);
				match.setUserId1(userId);
				match.setMatchStatus(1);
				match.setDelYn(delYnCge);
				match.setNum(num);
				Match matchOne = matchService.selectMatch(match);
				//System.out.println(matchOne);
				
				// 문자열
		        String dateStr = mri.getMatchday();
		 
		        // 포맷터
		        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		        
		        // 문자열 -> Date
		        LocalDateTime date = LocalDateTime.parse(dateStr);
				
				//if(matchNo, gymNo, userId1 가 db에 없으면)
				//	insert
				//있으면
				//} else {
				//  update
				//}	       
				if(matchOne == null) {		
					match.setMatchdate(date);
					match.setMatchtime(mri.getMatchtime());
					match.setMatchStatus(1);
					match.setDelYn(mri.getValue());
					
					//System.out.println("insert문");
					result = matchService.registerMatch(match);
					
					if(result > 0) {
				        jsonObject.addProperty("result", "OK");
				        jsonObject.addProperty("msg", "등록되었습니다.");
			        } else {
				        jsonObject.addProperty("result", "NOT_OK");
				        jsonObject.addProperty("msg", "등록 실패했습니다.");
			        } 
				} else {
					//System.out.println("updat문");
	
					match.setDelYn(mri.getValue());				
					System.out.println(match);
					
					result = matchService.updateMatch(match);
					
					if(result > 0) {
				        jsonObject.addProperty("result", "OK");
				        jsonObject.addProperty("msg", "등록되었습니다.");
			        } else {
				        jsonObject.addProperty("result", "NOT_OK");
				        jsonObject.addProperty("msg", "등록 실패했습니다.");
			        } 
				} 	
			
			}
			
		}		
		// JsonObject를 Json 문자열로 변환
		String jsonStr = gson.toJson(jsonObject);
		
		// 생성된 Json 문자열 출력
		System.out.println(jsonStr); // {"name":"anna","id":1}

		return jsonStr;
	}	
	
	public List<HashMap<String, String>> getDateList() {
		
		List<HashMap<String, String>> result = new ArrayList<>();
		//오늘 날짜(요일) 구하기
		LocalDateTime today = LocalDateTime.now();
		String today2 = today.toLocalDate().toString();
		//System.out.println(today);
		DayOfWeek yoil = today.getDayOfWeek();
		//System.out.println(yoil);
		
		String[] yoils = new String[]{"일", "월", "화", "수", "목", "금", "토"};
		
		int yoilNum = yoil.getValue();
		//System.out.println(yoilNum);
				
		//그 주의 일요일 구하기
		LocalDateTime sunday = today.minusDays(yoilNum);
		//System.out.println(sunday);
		
		//+14일치 구하기
		for(int i=0; i<14; i++) {
			LocalDateTime date = sunday.plusDays(i);
			//System.out.println(date);
			
			DayOfWeek yoil2 = date.getDayOfWeek();
			int yoilNum2 = yoil2.getValue();
			//System.out.println(yoilNum2%7);
			
			String yoil3 = yoils[yoilNum2%7];
			
			LocalDate day = date.toLocalDate();
			String dayTemp = day.toString();
//			System.out.println(day);
//			System.out.println(dayTemp);
			
			String dateTemp = date.format(DateTimeFormatter.ofPattern("M/d"));
			//System.out.println(dateTemp);
			
			HashMap<String, String> yoilTemp = new HashMap<>();
			yoilTemp.put("date", dateTemp);
			yoilTemp.put("day", dayTemp);
			yoilTemp.put("yoil", yoil3);
			yoilTemp.put("today", today2);

			result.add(yoilTemp);
		}		
		System.out.println(result);
		
		return result;
	}
	
	@RequestMapping(value = "/phoneCheck", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { // 휴대폰 문자보내기
		int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);// 난수 생성

		MemberServiceImpl.certifiedPhoneNumber(userPhoneNumber, randomNumber);

		return Integer.toString(randomNumber);
	}
	
	///////////////////////////////////////////////////////////
	
	@GetMapping("/payment.ma")
	public String payment(@RequestParam int no, Model model) {
		model.addAttribute("no", no);
		return "match/pay";
	}
	
	@ResponseBody
    @RequestMapping(value = "/payment.ma", method = RequestMethod.POST)
    public String payment(@RequestBody Match match, HttpSession session) {
    	int no = match.getNo();
    	System.out.println(no);
    	
    	int u1ps = 0;
    	int u2ps = 0;
    	String userId1 = "";
    	String userId2 = "";
    	
    	Gson gson = new Gson();
		JsonObject jsonObject = new JsonObject();
		
		//1. user_id1이 나인지 user_id2가 나인지 확인
    	Member member = (Member) session.getAttribute("loginMember");
    	String userId = member.getUserId();
    	
    	// 1. no에 해당하는 payStatus 상태를 읽음
    	Match match5 = matchService.toCopyMatchData(no);
    	System.out.println(match5);
    	// 유저1,2 구하기
    	userId1 = match5.getUserId1();
    	userId2 = match5.getUserId2();
    	u1ps = match5.getUser1Paystatus();
    	u2ps = match5.getUser2Paystatus();
    	
    	Match match2 = new Match();
    	//2. user_id1이 나면 user1_pay, user1_paystatus update
    	if(userId.equals(userId1)) {	
    		System.out.println("USER1이랑 같아!");
    		// 2. 상태가 1이면 이미 결제되었습니다.를 return
    		if(u1ps == 1) {
    			jsonObject.addProperty("result", "PAY_OK");
    			jsonObject.addProperty("msg", "이미 결제 되었습니다.");
    			// 3. 상태가 1이 아니면 결제진행
    		} else if(u1ps == 0) {
    			jsonObject.addProperty("result", "PAY_NOT_OK");
    	        jsonObject.addProperty("no", no);
    		} 
    	//3. user_id2이 나면 user2_pay, user2_paystatus update
    	} else if (userId.equals(userId2)) {
    		System.out.println("user2이랑 같아!");
    		// 2. 상태가 1이면 이미 결제되었습니다.를 return
    		if(u2ps == 1) {
    			jsonObject.addProperty("result", "OK");
		        jsonObject.addProperty("msg", "이미 결제 되었습니다.");
    		} else if(u2ps == 0) {
    			jsonObject.addProperty("result", "PAY_NOT_OK");
    	        jsonObject.addProperty("no", no);
    		}
    	}
    	
    	// JsonObject를 Json 문자열로 변환
		String jsonStr = gson.toJson(jsonObject);             

		// 생성된 Json 문자열 출력
		System.out.println(jsonStr);
		
		return jsonStr;
    }
	
	
    @GetMapping("/p_bank.ma")
    public String p_bank(@RequestParam int no, Model model) {
    	model.addAttribute("no", no);
    	return "match/p_bank";
    }
    
    //결제
    @ResponseBody
    @RequestMapping(value = "/p_bankPay.ma", method = RequestMethod.POST)
    public String p_bankPay(HttpSession session, @RequestBody Match match2) {
    	System.out.println(match2.getNo());
    	int no = match2.getNo();
    	
    	int result = 0;
    	int u1ps = 0;
    	int u2ps = 0;
    	String userId1 = "";
    	String userId2 = "";
    	String userPay = "20,000원";
    	
    	Gson gson = new Gson();
		JsonObject jsonObject = new JsonObject();
		
    	//1. user_id1이 나인지 user_id2가 나인지 확인
    	Member member = (Member) session.getAttribute("loginMember");
    	String userId = member.getUserId();
    	
    	// 1. no에 해당하는 payStatus 상태를 읽음
    	Match match5 = matchService.toCopyMatchData(no);
    	System.out.println(match5);
    	// 유저1,2 구하기
    	userId1 = match5.getUserId1();
    	userId2 = match5.getUserId2();
    	u1ps = match5.getUser1Paystatus();
    	u2ps = match5.getUser2Paystatus();
    	
    	Match match = new Match();
    	//2. user_id1이 나면 user1_pay, user1_paystatus update
    	if(userId.equals(userId1)) {	
    		System.out.println("USER1이랑 같아!");
    		// 2. 상태가 1이면 이미 결제되었습니다.를 return
    		if(u1ps == 0) {
    			match.setNo(no);
    			match.setUser1Pay(userPay);
    			match.setUser1Paystatus(1);
    			match.setUserId1(userId);
    			
    			System.out.println(match);
    			result = matchService.updatePay1(match);
    			
    			if(result > 0) {
    				jsonObject.addProperty("result", "OK");
    		        jsonObject.addProperty("msg", "결제 되었습니다.");
    			} else {
    				jsonObject.addProperty("result", "NOT_OK");
    		        jsonObject.addProperty("msg", "다시 결제 시도해주세요.");
    			}
    		}

       	   	
		//3. user_id2이 나면 user2_pay, user2_paystatus update
    	} else if (userId.equals(userId2)) {
    		System.out.println("user2이랑 같아!");
    		// 2. 상태가 1이면 이미 결제되었습니다.를 return
    		if(u2ps == 0) {
    			match.setNo(no);
    			match.setUser2Pay(userPay);
    			match.setUser2Paystatus(1);
    			match.setUserId2(userId);
    			
    			System.out.println(match);
    			result = matchService.updatePay2(match);
    			
    			if(result > 0) {
    				jsonObject.addProperty("result", "OK");
    		        jsonObject.addProperty("msg", "결제 되었습니다.");
    			} else {
    				jsonObject.addProperty("result", "NOT_OK");
    		        jsonObject.addProperty("msg", "다시 결제 시도해주세요.");
    			}
    		}		
    	}

    	//4. user1_paystatus, user2_paystatus 둘 다 1이면 match_status 4로 업데이트
    	Match match3 = matchService.selectPayStatus(no);
    	int user1PayStatus = match3.getUser1Paystatus();
    	int user2PayStatus = match3.getUser2Paystatus();

    	if(user1PayStatus == 1 && user2PayStatus == 1) {
	    	match3.setNo(no);
	    	match3.setMatchStatus(4);
	    	match3.setUserId1(userId1);
	    	match3.setUserId2(userId2);
	    	
	    	System.out.println(match3);
    		result = matchService.updateMatch(match3);
    		
    		if(result > 0) {
				jsonObject.addProperty("result", "OK");
		        jsonObject.addProperty("msg", "결제 되었습니다.");
			} else {
				jsonObject.addProperty("result", "NOT_OK");
		        jsonObject.addProperty("msg", "다시 결제 시도해주세요.");
			}
    	}
    	
    	// JsonObject를 Json 문자열로 변환
		String jsonStr = gson.toJson(jsonObject);             
	
		// 생성된 Json 문자열 출력
		System.out.println(jsonStr);
		
		return jsonStr;
    }
    
    //환불
    @ResponseBody
    @RequestMapping(value = "/p_bankRefund.py", method = RequestMethod.POST)
    public String p_bankRefund(@RequestBody Match match, HttpSession session) {
    	int no = match.getNo();
    	System.out.println(no);
    	
    	int result = 0;
    	int u1ps = 0;
    	int u2ps = 0;
    	String userId1 = "";
    	String userId2 = "";
    	
    	Gson gson = new Gson();
		JsonObject jsonObject = new JsonObject();
		
		// 1. user_id1이 나인지 user_id2가 나인지 확인
    	Member member = (Member) session.getAttribute("loginMember");
    	String userId = member.getUserId();
    	
    	// 1. 내 매치인지 no로 조회
    	// 1. no에 해당하는 payStatus 상태를 읽음  	
		// 2. user_id1이 나면 user1_pay, user1_paystatus default로 update
		// 3. user_id2이 나면 user2_pay, user2_paystatus default로 update
    	// 4. user1_paystatus, user2_paystatus 둘 다 1이면 match_status 4로 업데이트

		// 1. no에 해당하는 payStatus 상태를 읽음
    	Match match2 = matchService.toCopyMatchData(no);
    	System.out.println(match2);
    	
    	// 유저1,2 구하기
    	userId1 = match2.getUserId1();
    	userId2 = match2.getUserId2();
    	u1ps = match2.getUser1Paystatus();
    	u2ps = match2.getUser2Paystatus();
    	
    	Match match3 = new Match();
    	//2. user_id1이 나면 user1_pay, user1_paystatus default로 update
    	if(userId.equals(userId1)) {	
    		System.out.println("USER1이랑 같아!");
    		// 2. 상태가 0이면 이미 환불되었습니다.를 return
    		if(u1ps == 0) {
    			jsonObject.addProperty("result", "PAY_OK");
    			jsonObject.addProperty("msg", "이미 환불 되었습니다.");
    			// 3. 상태가 0이 아니면 환불진행
    		} else if(u1ps == 1) {    			
    			match3.setNo(no);
    			match3.setUser1Pay("0");
    			match3.setUser1Paystatus(0);
    			match3.setUserId1(userId);
    			
    			System.out.println(match3);
    			result = matchService.updatePay1(match3);
    			
    			if(result > 0) {
    				jsonObject.addProperty("result", "PAY_OK");
    		        jsonObject.addProperty("msg", "환불 되었습니다.");
    			} else {
    				jsonObject.addProperty("result", "PAY_NOT_OK");
    		        jsonObject.addProperty("msg", "다시 환불 시도해주세요.");
    			}
    		} 
    	//3. user_id2이 나면 user2_pay, user2_paystatus default로 update
    	} else if (userId.equals(userId2)) {
    		System.out.println("user2이랑 같아!");
    		// 2. 상태가 1이면 이미 결제되었습니다.를 return
    		if(u2ps == 0) {
    			jsonObject.addProperty("result", "PAY_OK");
    			jsonObject.addProperty("msg", "이미 환불 되었습니다.");
    			// 3. 상태가 0이 아니면 환불진행
    		} else if(u2ps == 1) {
    			match3.setNo(no);
    			match3.setUser2Pay("0");
    			match3.setUser2Paystatus(0);
    			match3.setUserId2(userId);
    			
    			System.out.println(match3);
    			result = matchService.updatePay2(match3);
    			
    			if(result > 0) {
    				jsonObject.addProperty("result", "PAY_OK");
    		        jsonObject.addProperty("msg", "환불 되었습니다.");
    			} else {
    				jsonObject.addProperty("result", "PAY_NOT_OK");
    		        jsonObject.addProperty("msg", "다시 환불 시도해주세요.");
    			}
       		}
    	}

    	//4. user1_paystatus, user2_paystatus 둘 다 0이면 match_status 7로 업데이트
    	Match match4 = matchService.selectPayStatus(no);
    	int user1PayStatus = match4.getUser1Paystatus();
    	int user2PayStatus = match4.getUser2Paystatus();

    	if(user1PayStatus == 0 && user2PayStatus == 0) {
    		match4.setNo(no);
    		match4.setMatchStatus(7);
    		match4.setUserId1(userId1);
    		match4.setUserId2(userId2);
	    	
	    	System.out.println(match4);
    		result = matchService.updateMatch(match4);
    		
    		if(result > 0) {
				jsonObject.addProperty("result", "PAY_OK");
		        jsonObject.addProperty("msg", "환불 되었습니다.");
			} else {
				jsonObject.addProperty("result", "PAY_NOT_OK");
		        jsonObject.addProperty("msg", "다시 환불 시도해주세요.");
			}
    	}
    	
    	// JsonObject를 Json 문자열로 변환
		String jsonStr = gson.toJson(jsonObject);             
	
		// 생성된 Json 문자열 출력
		System.out.println(jsonStr);
		
		return jsonStr;
    }
	
	
    @GetMapping("/p_mobile.ma")
    public String p_mobile() {
        return "match/p_mobile";
    }
    
    @PostMapping("/p_mobilePass.ma")
    public String p_mobilePass(String userId, String userName, String userEmail, Model model) {      
    	return "redirect:/";
    }
}
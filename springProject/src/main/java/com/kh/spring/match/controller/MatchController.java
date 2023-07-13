package com.kh.spring.match.controller;

import java.util.Date;
import java.util.HashMap;
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
import javax.servlet.http.HttpSession;

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
import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;
import com.kh.spring.match.model.dao.MatchDao;
import com.kh.spring.match.model.service.MatchService;
import com.kh.spring.match.model.vo.ChallengerList;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchInfo;
import com.kh.spring.match.model.vo.MatchInfoView;
import com.kh.spring.match.model.vo.MatchList;
import com.kh.spring.match.model.vo.MatchRegInfo;
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
	private MatchDao matchDao;
	
	@GetMapping("/matchList.ma")
	public void matchList(@RequestParam(defaultValue="1") int nowPage, Model model,
			              @RequestParam(defaultValue="gender") String gender,
			              @RequestParam(defaultValue="loc") String locations,
			              @RequestParam(defaultValue="") String searchInput,
			              @RequestParam(defaultValue="dows") String dowFromSelect,
			              @RequestParam(defaultValue="") String userId1,
			              @RequestParam(defaultValue="") String userId2) {
		int totalRecord = 0;
		String dowString = null;
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
		} else if(dowFromSelect.equals("monday") ||
				  dowFromSelect.equals("tuesday") ||
				  dowFromSelect.equals("wednesday") ||
				  dowFromSelect.equals("thursday") ||
				  dowFromSelect.equals("friday") ||
				  dowFromSelect.equals("saturday") ||
				  dowFromSelect.equals("sunday")) {
			if(dowFromSelect.equals("monday")) {
				dowString = "monday";
			} else if(dowFromSelect.equals("tuesday")) {
				dowString = "tuesday";
			} else if(dowFromSelect.equals("wednesday")) {
				dowString = "wednesday";
			} else if(dowFromSelect.equals("thursday")) {
				dowString = "thursday";
			} else if(dowFromSelect.equals("friday")) {
				dowString = "friday";
			} else if(dowFromSelect.equals("saturday")) {
				dowString = "saturday";
			} else {
				dowString = "sunday";
			}
			
			totalRecord = matchService.selectTotalRecordMatchListDow(dowString);
		
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
		} else if(!("".equals(searchInput))) {
			matchList = matchService.matchListFilterNick(searchInput, rowBounds);
		} else if(dowFromSelect.equals("monday") ||
				  dowFromSelect.equals("tuesday") ||
				  dowFromSelect.equals("wednesday") ||
				  dowFromSelect.equals("thursday") ||
				  dowFromSelect.equals("friday") ||
				  dowFromSelect.equals("saturday") ||
				  dowFromSelect.equals("sunday")) {
			if(dowFromSelect.equals("monday")) {
				dowString = "monday";
			} else if(dowFromSelect.equals("tuesday")) {
				dowString = "tuesday";
			} else if(dowFromSelect.equals("wednesday")) {
				dowString = "wednesday";
			} else if(dowFromSelect.equals("thursday")) {
				dowString = "thursday";
			} else if(dowFromSelect.equals("friday")) {
				dowString = "friday";
			} else if(dowFromSelect.equals("saturday")) {
				dowString = "saturday";
			} else {
				dowString = "sunday";
			}
				matchList = matchService.matchListFilterDow(dowString, rowBounds);
		} else if(!(userId1.equals(""))) {
			matchList = matchService.matchListReg(userId1, rowBounds);
		} else if(!(userId2.equals(""))) {
			matchList = matchService.matchListChal(userId2, rowBounds);
		} else {
		  matchList = matchService.selectMatchingList(rowBounds);
		}
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M월 dd일 E요일").withLocale(Locale.forLanguageTag("ko"));
		
		for(int i=0; i<matchList.size(); i++) {
			System.out.print(matchList.size());
			matchList.get(i).getMatchdate();
			LocalDateTime date = matchList.get(i).getMatchdate();
			matchList.get(i).setMatchdatestring(formatter.format(date));
			
			MatchList matchListTmp = matchList.get(i);
			
			List<ChallengerList> challengerMembers = matchService.toChallengerList(matchListTmp);
			
			System.out.println(challengerMembers);
			
				for(int j=0; j<challengerMembers.size(); j++) {
				
					if(challengerMembers.get(j) != null) {
						System.out.println(challengerMembers.size());
						if(matchList.get(i).getChallenger1() == null) {
							String ch1 = challengerMembers.get(j).getUserId2();
							matchList.get(i).setChallenger1(ch1);
							System.out.println(matchList.get(i).getChallenger1());
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
			
			System.out.println(matchList.get(i).getChallenger1());
			System.out.println(matchList.get(i).getChallenger2());
			System.out.println(matchList.get(i).getChallenger3());
			System.out.println(matchList.get(i).getChallenger4());
			System.out.println(matchList.get(i).getChallenger5());
	
		}
		
		model.addAttribute("matchList", matchList);
		model.addAttribute("pi", pi);
	}
	
	@GetMapping("/challengerAdd.ma")
	public String challengerAdd(@RequestParam int no, @RequestParam String userId1, @RequestParam String userId2, @RequestParam String matchdateString, 
								@RequestParam String matchTime, @RequestParam String gymName, @RequestParam String proNick1, RedirectAttributes redirectAtt) {
			
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
			alarm.setNo(no);
			
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
					int result2 = alarmService.insertAlarm(alarm);
					System.out.println(result2);
					System.out.println("alarm테이블 insert 성공");
					redirectAtt.addFlashAttribute("challengeMsg", "도전 신청이 완료 되었습니다.");
				} catch(Exception e) {
					redirectAtt.addFlashAttribute("challengeMsg", "오류로 인해, 실패 했습니다.");
				}
			} else if(challengerInsertDecision2 == 1) {
				System.out.println("else if문 들어왔어");
				if(1 <= challengerInsertDecision3 && challengerInsertDecision3 < 5) {
					System.out.println(challengerInsertDecision4);
					if(challengerInsertDecision4 == 0) {
						Match toInputMatchData = matchService.toCopyMatchData(no);
						toInputMatchData.setUserId2(userId2);
						toInputMatchData.setMatchStatus(0);
						try {
							int result = matchService.challengerInsert(toInputMatchData);
							int result2 = alarmService.insertAlarm(alarm);
							redirectAtt.addFlashAttribute("challengeMsg", "도전 신청이 완료 되었습니다.");
						} catch(Exception e) {
							redirectAtt.addFlashAttribute("challengeMsg", "오류로 인해, 실패 했습니다.");
						}
					} else {
						redirectAtt.addFlashAttribute("challengeMsg", "당신은 이미 이 매치에 도전 신청을 했습니다.");
					}
				} else {
					redirectAtt.addFlashAttribute("challengeMsg", "최대도전자 인원이 5명이라, 신청이 불가합니다.");
				}
			} 
		
		return "redirect:/match/matchList.ma?nowPage="+1;
	}
	
	@GetMapping("/regCancel.ma")
	public String regCancel(@RequestParam String matchNo, @RequestParam String userId1, RedirectAttributes redirectAtt) {
		Match matchTmp = new Match();
		matchTmp.setMatchNo(matchNo);
		matchTmp.setUserId1(userId1);
		
		try {
			int result = matchService.regCancel(matchTmp);
			redirectAtt.addFlashAttribute("msg", "등록된 매치가 취소되었습니다.");
		} catch(Exception e) {
			redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
		}
		
		return "redirect:/match/matchList.ma?nowPage="+1;
	}
	
	@GetMapping("/chalCancel.ma")
	public String chalCancel(@RequestParam int no, @RequestParam String userId2, RedirectAttributes redirectAtt) {
			System.out.println("chal"+ no + userId2);
			Match toCopyMatchData = matchService.toCopyMatchData(no);
			System.out.println(toCopyMatchData);
			
			int challengerCancelDecision = matchService.challengerInsertDecision3(toCopyMatchData);
			System.out.println(challengerCancelDecision);
			
			if(2 <= challengerCancelDecision && challengerCancelDecision <= 5) {
				
				Match toCancelMatchData = matchService.toCopyMatchData(no);
				toCancelMatchData.setUserId2(userId2);
				System.out.println(toCancelMatchData);
				try {
					int result = matchService.chalCancel(toCancelMatchData);
					redirectAtt.addFlashAttribute("msg", "매치에 신청된 도전이 취소되었습니다.");
				} catch(Exception e) {
					redirectAtt.addFlashAttribute("msg", "오류로 인해, 실패 했습니다.");
				}
			}
			
			
			
		return "redirect:/match/matchList.ma?nowPage="+1;
	}
	
	
	
	
	

	@RequestMapping(value="/matchReg.ma", method = RequestMethod.GET)
	public String matchReg(HttpServletRequest request, HttpSession session, Model model) {	
		String matchDate = request.getParameter("day");
		if(matchDate == null || "".equals(matchDate)) {
			LocalDateTime today = LocalDateTime.now();
			System.out.println(today);
			matchDate = today.toLocalDate().toString();	
		}
		System.out.println("matchDate : " + matchDate);
		
		//matchdateList포맷용 ex.2023/07/05
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M/d(E)");

		Member member = (Member) session.getAttribute("loginMember");
		String userId = member.getUserId();
		
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
			
			infoView.setGymNo(gNo);
			infoView.setGymName(name);
			infoView.setMatchdate(formatter.format(date));
			infoView.setMatchday(date);
			infoView.setTime(tm);
			infoView.setCode(cd);
			
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
			
			//System.out.println("localdatetime : " + matchdate);
			Date dateTemp = java.sql.Timestamp.valueOf(matchdate);
			//System.out.println("date : " + dateTemp);
					
			if(!tempGymNo.equals(gymNo)) {
				if(!tempGymNo.equals("0")) {
					infoView.setMatchdateList(matchdates);
					infoView.setMatchdayList(matchdays);
					infoView.setMatchTimeList(times);
					infoView.setCodeList(codes);
					markerOverlayList.add(infoView);
					times = new ArrayList<String>();
					codes = new ArrayList<String>();
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
			}
		}
		if(!tempGymNo.equals("0")) {
			infoView.setMatchdateList(matchdates);
			infoView.setMatchdayList(matchdays);
			infoView.setMatchTimeList(times);
			infoView.setCodeList(codes);
			markerOverlayList.add(infoView);
			//System.out.println(markerOverlayList);
		}

		model.addAttribute("dateFilter", getDateList());
		model.addAttribute("markerOverlayList", markerOverlayList);

		return "/match/matchReg";
	}
	
	@ResponseBody
	@RequestMapping(value="/register.do", method = RequestMethod.POST)
	public String registerMatch(@RequestBody List<MatchRegInfo> matchRegInfoList, HttpSession session) {
		//System.out.println("registerMatch 들어옴");
		Match match = new Match();
		int result = 0;
		
		for(MatchRegInfo mri : matchRegInfoList) {		
			//System.out.println(mri.toString());

			String matchNo = mri.getCode();
			int gymNo = mri.getGymNo();
			
			Member member = (Member) session.getAttribute("loginMember");
			String userId = member.getUserId();
			
			String delYnCge = mri.getValue();
			System.out.println("mri에서 가져온 값 : " + matchNo + gymNo + delYnCge);
			
			match.setMatchNo(matchNo);
			match.setGymNo(gymNo);
			match.setUserId1(userId);
			match.setMatchStatus(1);
			match.setDelYn(delYnCge);
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
			} else {
				//System.out.println("updat문");

				match.setDelYn(mri.getValue());				
				System.out.println(match);
				
				result = matchService.updateMatch(match);
			}
		}		
		
		Gson gson = new Gson();
		 
        // Json key, value 추가
        JsonObject jsonObject = new JsonObject();
        if(result > 0) {
	        jsonObject.addProperty("result", "OK");
	        jsonObject.addProperty("msg", "등록되었습니다.");
        } else {
	        jsonObject.addProperty("result", "NOT_OK");
	        jsonObject.addProperty("msg", "등록 실패했습니다.");
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
	
}
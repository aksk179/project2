package com.kh.spring.alarm.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.kh.spring.alarm.model.service.AlarmService;
import com.kh.spring.alarm.model.vo.Alarm;
import com.kh.spring.match.model.service.MatchService;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchList;
import com.kh.spring.member.model.vo.Member;

@Controller
@RequestMapping("/alarm")
@SessionAttributes({"loginMember"})
public class AlarmController {
	
	@Autowired
	private AlarmService alarmService;
	
	@Autowired
	private MatchService matchService;
	
	@ResponseBody
	@RequestMapping(value="/checkAlarm.al", method = RequestMethod.POST)
	public int checkAlarm(HttpSession session) {
		
		Member member = (Member) session.getAttribute("loginMember");
		if(member == null) {			
			return 0;
		}
		
		String userId = member.getUserId();
		System.out.println(userId);
		
		int count = alarmService.checkAlarm(userId);
		System.out.println(count);
		
		return count;
	}
	
//	@RequestMapping(value="/readAlarm.al", method = RequestMethod.GET)
//	public String alarmPopup(HttpSession session, Model model) {
//		Gson gson = new Gson();
//		JSONArray jsonArr = new JSONArray(); 
//				
//		List<HashMap<String, String>> result = new ArrayList<>();
//		
//		Member member = (Member) session.getAttribute("loginMember");
//		String userId = member.getUserId();
//		System.out.println(userId);
//		
//		List<Alarm> readAlarmList = alarmService.readAlarmList(userId);
//		System.out.println(readAlarmList);
//		
//		model.addAttribute("readAlarmList", readAlarmList);
// 
//		return "/alarm/alarmPopup";
//	}

	@ResponseBody
	@RequestMapping(value="/read.al", method = RequestMethod.POST)
	public List<HashMap<String, String>> readAlarmList(HttpSession session, Model model) {
		Gson gson = new Gson();
				
		List<HashMap<String, String>> result = new ArrayList<>();
		
		Member member = (Member) session.getAttribute("loginMember");
		String userId = member.getUserId();
		System.out.println(userId);
		
		List<Alarm> readAlarmList = alarmService.readAlarmList(userId);
		System.out.println(readAlarmList);
		for(Alarm ar : readAlarmList) {
			int noTemp = ar.getAlarmNo();
			String alarmNo = Integer.toString(noTemp);
			
			String receiverId = ar.getReceiverId();
			String senderId = ar.getSenderId();
			String alarmMsg = ar.getAlarmMsg();
			String alarmTime = ar.getAlarmTime2();
			String readYn = ar.getReadYn();
			
			System.out.println("받은 사람, 보낸 사람 : " + receiverId + senderId);
			int staTemp = ar.getAlarmStatus();
			String alarmStatus = Integer.toString(staTemp);
			
			int noTemp2 = ar.getNo();
			String no = Integer.toString(noTemp2);
			
			HashMap<String, String> result2 = new HashMap<>();
			result2.put("alarmNo", alarmNo);
			result2.put("receiverId", receiverId);
			result2.put("senderId", senderId);
			result2.put("alarmMsg", alarmMsg);
			result2.put("alarmTime", alarmTime);
			result2.put("readYn", readYn);
			result2.put("alarmStatus", alarmStatus);
			result2.put("no", no);
			
			System.out.println("result2= " + result2);
			
			result.add(result2);			
			System.out.println("map은 " + result);
		}
		
		model.addAttribute("readAlarmList", result);
		
		String json = new Gson().toJson(result);
		System.out.println(json);			
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value="/readYnUpdate.al", method = RequestMethod.POST)
	public String readYnUpdate(@RequestBody List<Alarm> alarmList) {
		Gson gson = new Gson();
		int result = 0;
		
		for(Alarm al : alarmList) {
			result = alarmService.readYnUpdate(al);
			System.out.println("result : " + result);
		}
		
		JsonObject jsonObject = new JsonObject();
        if(result > 0) {
	        jsonObject.addProperty("result", "OK");
        } else {
	        jsonObject.addProperty("result", "NOT_OK");
        }        
 
        // JsonObject를 Json 문자열로 변환
        String jsonStr = gson.toJson(jsonObject);
 
        // 생성된 Json 문자열 출력
        System.out.println(jsonStr);
	
		return jsonStr;
	}
	
	@ResponseBody
	@RequestMapping(value="/acceptMatch.al", method = RequestMethod.POST)
	public String acceptMatch(HttpSession session, @RequestBody Alarm alarm, Model model) {
		System.out.println("accept매치 시작=========================================");
		// 1. matchNo에 해당하는 상태를 읽음
		// 2. 상태가 3이면 이미 수락되었습니다.를 return
		// 3. 상태가 3이 아니면 알람메시지+상태를 3으로 update
		// 4. 나머지 사람들은 알람메시지+상태를 8(거절 당한)으로 update
		System.out.println(alarm.getNo());
		
		Gson gson = new Gson();
		JsonObject jsonObject = new JsonObject();
		int result = 0;
		
		MatchList matchList = matchService.selectOneMatch(alarm.getNo());
		System.out.println(matchList);
		
		if(matchList != null) {		
			System.out.println("matchList.getNo : " + matchList.getNo());
			if(matchList.getMatchStatus() == 3) {
				jsonObject.addProperty("result", "OK");
		        jsonObject.addProperty("msg", "이미 수락 되었습니다.");
			} else if(matchList.getMatchStatus() == 6) {
				jsonObject.addProperty("result", "OK");
		        jsonObject.addProperty("msg", "이미 거절 되었습니다.");
			} else if(matchList.getMatchStatus() == 8) {
				jsonObject.addProperty("result", "OK");
		        jsonObject.addProperty("msg", "다른 매치가 성사되어 취소되었습니다.");
			} else {
				String userId1 = matchList.getUserId1();
				String userId2 = matchList.getUserId2();
				String proNick = matchList.getProNick();
				String proNick2 = matchList.getProNick2();
				String gymName = matchList.getGymName();
				
				LocalDateTime dateTemp = matchList.getMatchdate();
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M월 dd일 E요일").withLocale(Locale.forLanguageTag("ko"));
				String matchdateString = formatter.format(dateTemp);
				System.out.println(matchdateString);
				
				String matchTime = matchList.getMatchtime();
				int no2 = matchList.getNo();
				
				//receiver(매치 등록한 사람)한테는 sender(pronick2)의 이름으로 메시지 보내야 함
				//sender(매치 도전신청한 사람)한테는 receiver(pronick)의 이름으로 메시지 보내야 함
				Member member = (Member) session.getAttribute("loginMember");
				String userId = member.getUserId();
				
				//userId1이 userId2로부터 받음.
				String alarmMsg = proNick2 + "님과의 " + gymName + " " + matchdateString + " " + matchTime + " 매치가 성사되었습니다. 결제해주세요";
				Alarm alarm2 = new Alarm();
				alarm2.setReceiverId(userId1);
				alarm2.setSenderId(userId2);
				alarm2.setAlarmMsg(alarmMsg);
				alarm2.setReadYn("N");
				alarm2.setAlarmStatus(1);
				alarm2.setNo(alarm.getNo());
				result = alarmService.insertAlarm(alarm2);
				
				alarm2 = new Alarm();
				//userId2이 userId1로부터 받음.
				String alarmMsg2 = proNick + "님과의 " + gymName + " " + matchdateString + " " + matchTime + " 매치가 성사되었습니다. 결제해주세요";
				alarm2.setReceiverId(userId2);
				alarm2.setSenderId(userId1);
				alarm2.setAlarmMsg(alarmMsg2);
				alarm2.setReadYn("N");
				alarm2.setAlarmStatus(1);
				alarm2.setNo(alarm.getNo());
				result = alarmService.insertAlarm(alarm2);
				
				////////////////////////////////////////////////
				Match match = new Match();
				match.setNo(alarm.getNo());
				match.setMatchStatus(3);
				
				result = matchService.updateMatch(match);
				
				if(result > 0) {
			        jsonObject.addProperty("result", "OK");
			        jsonObject.addProperty("msg", "수락되었습니다.");
		        }	
				
				//나머지 사람들에게 메세지 보내고 상태 8로 update
				String matchNo = matchList.getMatchNo();
				Match match2 = new Match();
				match2.setMatchNo(matchNo);
				
				List<Match> match3 = matchService.selectStatus0(match2);
				System.out.println(match3);
				for(Match m : match3) {
					if(m.getMatchStatus() == 0 || m.getMatchStatus() == 1) {
						Match match4 = new Match();
						match4.setMatchNo(matchNo);
						match4.setUserId1(userId);
						result = matchService.updateMatch8(match4);
						System.out.println(result);
					}			
					
				}
			
				if(result > 0) {
			        jsonObject.addProperty("result", "OK");
			        jsonObject.addProperty("msg", "수락되었습니다.");
		        }				
			}
		} else {
	        jsonObject.addProperty("result", "NOT_OK");
	        jsonObject.addProperty("msg", "이미 취소된 매치입니다.");
        }             
 
        // JsonObject를 Json 문자열로 변환
        String jsonStr = gson.toJson(jsonObject);
 
        // 생성된 Json 문자열 출력
        System.out.println(jsonStr);
	
		return jsonStr;
	}
	
	@ResponseBody
	@RequestMapping(value="/rejectMatch.al", method = RequestMethod.POST)
	public String rejectMatch(HttpSession session, @RequestBody Alarm alarm, Model model) {
		System.out.println("reject매치 시작=========================================");
		// 1. matchNo에 해당하는 상태를 읽음
		// 2. 상태가 3이면 이미 수락되었습니다.를 return
		// 3. 상태가 6이면 이미 거절되었습니다.를 return
		// 4. 상태가 3이 아니면 알람메시지+상태를 6(매치취소)으로 update
		System.out.println(alarm.getNo());
		
		Gson gson = new Gson();
		JsonObject jsonObject = new JsonObject();
		int result = 0;
		
		MatchList matchList = matchService.selectOneMatch(alarm.getNo());
		System.out.println(matchList);
		
		if(matchList != null) {		
			System.out.println("matchList.getNo : " + matchList.getNo());
			if(matchList.getMatchStatus() == 3) {
				jsonObject.addProperty("result", "OK");
		        jsonObject.addProperty("msg", "이미 수락 되었습니다. 취소하시려면 내 경기 화면에서 해주세요");
			} else if(matchList.getMatchStatus() == 6 || matchList.getMatchStatus() == 8) {
				jsonObject.addProperty("result", "OK");
		        jsonObject.addProperty("msg", "이미 거절 되었습니다.");
			} else if(matchList.getMatchStatus() == 1) {		
				Match match = new Match();
				match.setUserId1(matchList.getUserId1());
				match.setMatchNo(matchList.getMatchNo());
				
				result = matchService.updateUser2Null(match);	
				
				////////////////////////////////////////////////////
				
				String userId1 = matchList.getUserId1();
				String userId2 = matchList.getUserId2();
				String proNick = matchList.getProNick();
				String proNick2 = matchList.getProNick2();
				String gymName = matchList.getGymName();
				
				LocalDateTime dateTemp = matchList.getMatchdate();
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M월 dd일 E요일").withLocale(Locale.forLanguageTag("ko"));
				String matchdateString = formatter.format(dateTemp);
				System.out.println(matchdateString);
				
				String matchTime = matchList.getMatchtime();
				int no2 = matchList.getNo();
				
				Alarm alarm2 = new Alarm();
				
				//userId2이 userId1로부터 받음.
				String alarmMsg2 = "죄송합니다. " + proNick + "님과의 " + gymName + " " + matchdateString + " " + matchTime + " 매치가 거절되었습니다.";
				alarm2.setReceiverId(userId2);
				alarm2.setSenderId(userId1);
				alarm2.setAlarmMsg(alarmMsg2);
				alarm2.setReadYn("N");
				alarm2.setAlarmStatus(0);
				alarm2.setNo(alarm.getNo());
				result = alarmService.insertAlarm(alarm2);
				
				if(result > 0) {
			        jsonObject.addProperty("result", "OK");
			        jsonObject.addProperty("msg", "거절되었습니다.");
		        }
			} else {
				String userId1 = matchList.getUserId1();
				String userId2 = matchList.getUserId2();
				String proNick = matchList.getProNick();
				String proNick2 = matchList.getProNick2();
				String gymName = matchList.getGymName();
				
				LocalDateTime dateTemp = matchList.getMatchdate();
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("M월 dd일 E요일").withLocale(Locale.forLanguageTag("ko"));
				String matchdateString = formatter.format(dateTemp);
				System.out.println(matchdateString);
				
				String matchTime = matchList.getMatchtime();
				int no2 = matchList.getNo();
				
				//receiver(매치 등록한 사람)한테는 sender(pronick2)의 이름으로 메시지 보내야 함
				//sender(매치 도전신청한 사람)한테는 receiver(pronick)의 이름으로 메시지 보내야 함
				Member member = (Member) session.getAttribute("loginMember");
				String userId = member.getUserId();
				
				Alarm alarm2 = new Alarm();
				
				//userId2이 userId1로부터 받음.
				String alarmMsg2 = "죄송합니다. " + proNick + "님과의 " + gymName + " " + matchdateString + " " + matchTime + " 매치가 거절되었습니다.";
				alarm2.setReceiverId(userId2);
				alarm2.setSenderId(userId1);
				alarm2.setAlarmMsg(alarmMsg2);
				alarm2.setReadYn("N");
				alarm2.setAlarmStatus(0);
				alarm2.setNo(alarm.getNo());
				result = alarmService.insertAlarm(alarm2);
				
				////////////////////////////////////////////////
				Match match = new Match();
				match.setNo(alarm.getNo());
				match.setMatchStatus(6);
				
				result = matchService.updateMatch(match);
			
				if(result > 0) {
			        jsonObject.addProperty("result", "OK");
			        jsonObject.addProperty("msg", "거절되었습니다.");
		        }				
			}
		} else {
	        jsonObject.addProperty("result", "NOT_OK");
	        jsonObject.addProperty("msg", "이미 취소된 매치입니다.");
        }                 
 
        // JsonObject를 Json 문자열로 변환
        String jsonStr = gson.toJson(jsonObject);
 
        // 생성된 Json 문자열 출력
        System.out.println(jsonStr);
	
		return jsonStr;
	}
}

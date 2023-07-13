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
	public String acceptMatch(HttpSession session, @RequestBody Alarm alarm) {
		System.out.println(alarm.getNo());
		
		Gson gson = new Gson();
		int result = 0;
		
		MatchList matchList = matchService.selectOneMatch(alarm.getNo());
		System.out.println(matchList);
		
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
		alarm.setReceiverId(userId1);
		alarm.setSenderId(userId2);
		alarm.setAlarmMsg(alarmMsg);
		alarm.setReadYn("N");
		alarm.setAlarmStatus(1);
		alarm.setNo(alarm.getNo());
		result = alarmService.insertAlarm(alarm);
		

		alarm = new Alarm();
		//userId2이 userId1로부터 받음.
		String alarmMsg2 = proNick + "님과의 " + gymName + " " + matchdateString + " " + matchTime + " 매치가 성사되었습니다. 결제해주세요";
		alarm.setReceiverId(userId2);
		alarm.setSenderId(userId1);
		alarm.setAlarmMsg(alarmMsg2);
		alarm.setReadYn("N");
		alarm.setAlarmStatus(1);
		alarm.setNo(alarm.getNo());
		result = alarmService.insertAlarm(alarm);
		
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
}

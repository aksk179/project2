package com.kh.spring.gym.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.alarm.model.service.AlarmService;
import com.kh.spring.alarm.model.vo.Alarm;
import com.kh.spring.alarm.model.vo.AlarmArg;
import com.kh.spring.common.model.vo.PageInfo;
import com.kh.spring.common.template.Pagination;
import com.kh.spring.gym.model.dao.GymDao;
import com.kh.spring.gym.model.service.GymService;
import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;
import com.kh.spring.match.model.service.MatchService;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchList;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.profile.model.service.ProfileService;
import com.kh.spring.profile.model.vo.Profile;

@Controller
@RequestMapping("/gym")
public class GymController {
	
	@Autowired
	private GymService gymService;
	
	@Autowired
	private MatchService matchService;
	
	@Autowired
	private ProfileService profileService;
	
	@Autowired
	private AlarmService alarmService;
	
	@Autowired
	private GymDao gymDao;
	
	@GetMapping("/joinEnroll.gym")
	public String joinEnroll() {
		return "/gym/joinEnroll";
	}
	
	@PostMapping("/joinEnrollForm.gym")
	public String joinEnrollForm(Gym gym, Model model) {
		int result = 0;
			try {
				result = gymService.insertJoin(gym);
				System.out.println(result);
				model.addAttribute("msg", "가맹신청이 등록되었습니다.");
			} catch (Exception e) {
				System.out.println(result);
				model.addAttribute("msg", "이미 가맹신청이 된 id인지, 전화번호와 사업자번호가 이미 등록된 것인지 확인하세요.");
			}
	
		return "/support/vincero";
	}

	// 체육관 메인페이지 
	@GetMapping("/gymMainPage.gym")
	public String gymMainPage(@RequestParam(defaultValue="1") int nowPage, HttpServletRequest request, Model model) {
		System.out.println("gymMainPage() ========================");
		HttpSession session = request.getSession();
		
		Member loginMemberInfo = (Member)session.getAttribute("loginMember");
		String userId = loginMemberInfo.getUserId();
		Gym gym = gymService.getGymByUserId(userId);
		System.out.println(gym);

		//페이징
		int totalRecord = gymService.selectTotalRecord(gym.getGymNo());
		int limit = 10;
		int offset = (nowPage - 1) * limit; 
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		
		List<MatchList> matchList = gymService.selectMyGymMatchList(gym.getGymNo(), rowBounds);
		System.out.println(matchList);
		
		model.addAttribute("gym", gym);
		model.addAttribute("matchList", matchList);
		model.addAttribute("pi", pi);
		
		return "gym/gymMainPage";
	}
	/*
	@GetMapping("/gymMainPage.gym")
	public String gymMainPage(String loginId, Model model) {
		Gym gym = gymService.loginGym(loginId);
		model.addAttribute("gym", gym);
		return "gym/gymMainPage";
	}

	@GetMapping("/gymMainPage.gym")
	public void gymMainPage(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		Member loginMemberInfo = (Member)session.getAttribute("loginMember");
		List<Gym> gymMainPage = gymDAO.getGymMainPageByUserId(loginMemberInfo.getUserId());
		model.addAttribute("gymMainPage", gymMainPage); 
	}
	*/

	
	// 내 체육관 정보보기 
	@GetMapping("/gymForm.gym")
	public String gymForm(int gymNo, Model model) {
		Gym gym = gymService.myGym(gymNo);
		model.addAttribute("gym", gym);
		return "gym/gymForm";
	}
	
	// 내 체육관 정보 가져오기(수정)
	@GetMapping("/gymUpdate.gym")
	public String selectMyGym(int gymNo, Model model) {
		Gym gym = gymService.selectMyGym(gymNo);
		model.addAttribute("gym", gym);
		return "gym/gymUpdate";
	}
	
	// 내 체육관 정보 보내기(수정)
	@PostMapping("/gymUpdate.gym")
	public String myGymUpdate(Gym gym, RedirectAttributes redirectAttr) {
		
		int result = gymService.myGymUpdate(gym);
		
		if (result > 0) {
			redirectAttr.addFlashAttribute("msg", "체육관 정보수정 완료");
		} else {
			redirectAttr.addFlashAttribute("msg", "체육관 정보수정 실패");
		}
		return "redirect:/gym/gymForm.gym?gymNo=" + gym.getGymNo();
	}
	
	@GetMapping("/gymCalendar.gym")
	public void gymCalendar() {}
	
	@GetMapping("/gymCalendarSelect.gym")
	public String gymCalendarSelect(@RequestParam String y, @RequestParam String m, Model model) {
		model.addAttribute("y", y);
		model.addAttribute("m", m);
		return "/gym/gymCalendar";
	}
	
	@GetMapping("/dayPage.gym")
	public String dayPage(@RequestParam String userId, @RequestParam String y, @RequestParam String m, @RequestParam String d, Model model) {
		int yi = Integer.parseInt(y);
		int mi = Integer.parseInt(m);
		int di = Integer.parseInt(d);
		String ymd = String.format("%04d%02d%02d", yi, mi, di);
		model.addAttribute("yi", yi);
		model.addAttribute("mi", mi);
		model.addAttribute("di", di);
		model.addAttribute("ymd", ymd);
		List<Schedule> codeList = gymService.selectCodeList(userId);
		ArrayList<String> timeList = new ArrayList<String>();
		for(int i=0; i<codeList.size(); i++) {
			String tmp = codeList.get(i).getCode().substring(codeList.get(i).getCode().length()-12, codeList.get(i).getCode().length());
			timeList.add(tmp);
		}
		model.addAttribute("timeList", timeList);
		return "/gym/gymCalendar";
	}
	
	@GetMapping("/gymView.gym")
	public void gymView() {}
	
	@GetMapping("/scheduleReg.gym")
	public String scheduleReg(@RequestParam String userId, @RequestParam String[] totalCodes, Model model) {
		System.out.println("scheduleReg() ============================");
		System.out.println(userId);
		String dateStr = "";
		String dateTime = "";
		//Date date = new Date();
		//LocalDateTime date = LocalDateTime.now();
		//System.out.println(date);
		int sum = 0;
		
		Gym gym = gymService.selectGymNo(userId);
		System.out.println(gym.getGymNo());
		int gymNo = gym.getGymNo();
		for(int i=0; i<totalCodes.length; i++) {
			Schedule schedule = new Schedule();
			schedule.setUserId(userId);
			schedule.setCode(totalCodes[i]);
			dateStr = totalCodes[i].substring(totalCodes[i].length()-12, totalCodes[i].length());
			System.out.println(dateStr);
			dateTime = totalCodes[i].substring(totalCodes[i].length()-4, totalCodes[i].length());
			System.out.println(dateTime);

			//SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
			

	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmm");
	        
	        // 문자열 -> Date
			int result = 0;
//			try {
//				date = LocalDateTime.parse(dateStr, formatter);
//				System.out.println(date);
//				date = formatter.parse(dateStr);
//			} catch (ParseException e) {
//				e.printStackTrace();
//			}
			schedule.setMatchDate(LocalDateTime.parse(dateStr, formatter));
			schedule.setMatchTime(dateTime);
			schedule.setGymNo(gymNo);
			System.out.println(schedule);
			
			try {
				result = gymService.insertSchedule(schedule);
				System.out.println(result);
				sum += result;
			} catch (Exception e) {
				sum += result;
				
			}
		}
		System.out.println(sum);
		
		if(sum==totalCodes.length) {
			model.addAttribute("msg", "일정이 등록되었습니다.");
		} else if(sum==0) {
			model.addAttribute("msg", "관장 id로 로그인이 되었는지, 이미 등록된 날이 아닌지 확인하세요.");
		} else {
			model.addAttribute("msg", "일정이 등록되었습니다.");
		}
		
		System.out.println(sum);
		System.out.println(totalCodes.length);
		return "/gym/gymCalendar";
	}
	
	@GetMapping("/scheduleDel.gym")
	public String scheduleDel(@RequestParam String userId, @RequestParam String[] totalCodes, Model model) {
		System.out.println("스케줄 삭제");
		System.out.println(Arrays.toString(totalCodes));
		System.out.println(userId);
		int sum = 0;
		int result = 0;
		int result2 = 0;
		String matchNo = "";
		
		//1. 화면에서 누른 시간에 해당하는 코드들 가져오기
		//2. 코드개수만큼 for문 돌면서 스케줄DB와 MATCH DB에 같은(해당 스케줄에 신청해놓은 사용자가 있는지) 행이 있는지 확인
		//3. 조회된 행이 없으면 스케줄 DB에서만 바로 삭제
		//4. 조회된 행이 있으면 MATCH_NO 이용해서 ALARM 에 쓰일 컬럼들 조회
		//5. 하는데 USER_ID2가 있으면 둘 다에게 "~님과의 ㅇㅇ매치가 취소" MSG 보내기
		//6.	  USER_ID2가 없으면 한 명한테만 "ㅇㅇ체육관에서 ㅇㅇ매치가 취소" MSG 보내기
		//7. 스케줄 삭제
		
		for(int i=0; i<totalCodes.length; i++) {
			Schedule schedule = new Schedule();
			schedule.setUserId(userId);
			schedule.setCode(totalCodes[i]);
			System.out.println(totalCodes[i]);
			
			List<Match> matchList = gymService.selectScheduleMatchList(schedule);
			System.out.println(matchList);
			
			if(matchList.size() == 0) {
				result = gymService.deleteSchedule(schedule);				
				//해당 스케줄에 신청해놓은 사용자가 있는지 확인(해당 스케줄의 code와 match테이블의 match_no 컬럼이 같을 때)
			} else {
				for(Match m : matchList) {
					matchNo = m.getMatchNo();

					List<AlarmArg> alarmArg = alarmService.selectAlarmArg(m);
					System.out.println(alarmArg);
					//System.out.println(alarmArg.get(0).getSenderId());
					
					for(int j=0; j<alarmArg.size(); j++) {	
						if(alarmArg.get(j).getSenderId() == null || "".equals(alarmArg.get(j).getSenderId())) {
							Alarm alarm = new Alarm();
							
							String receiverId = alarmArg.get(j).getReceiverId();
							String senderId = alarmArg.get(j).getSenderId();
							String gymName = alarmArg.get(j).getGymName();
							
							LocalDateTime dateTemp = alarmArg.get(j).getMatchdate();
							String date = dateTemp.format(DateTimeFormatter.ofPattern("M/d(E)"));
			 
							String time = alarmArg.get(j).getMatchtime();
							int no = alarmArg.get(j).getNo();
							String proNick1 = alarmArg.get(j).getProNick1();
							String proNick2 = alarmArg.get(j).getProNick2();

							String alarmMsg = "죄송합니다. " + gymName + " " + date + " " + time + " 일정이 취소되었습니다. 다른 매치에 도전해주세요."; 
							
							//체육관 이름으로 알람 보내기
							alarm.setReceiverId(receiverId);
							alarm.setSenderId(gymName);
							alarm.setAlarmMsg(alarmMsg);
							alarm.setReadYn("N"); 
							alarm.setAlarmStatus(0); 
							alarm.setNo(no);
							result2 = alarmService.insertAlarm(alarm);
						} else {
							Alarm alarm = new Alarm();
							
							String receiverId = alarmArg.get(j).getReceiverId();
							String senderId = alarmArg.get(j).getSenderId();
							String gymName = alarmArg.get(j).getGymName();
							
							LocalDateTime dateTemp = alarmArg.get(j).getMatchdate();
							String date = dateTemp.format(DateTimeFormatter.ofPattern("M/d(E)"));
			 
							String time = alarmArg.get(j).getMatchtime();
							int no = alarmArg.get(j).getNo();
							String proNick1 = alarmArg.get(j).getProNick1();
							String proNick2 = alarmArg.get(j).getProNick2();

							String alarmMsg = "죄송합니다. " + proNick2 + "님과의 " + gymName + " " + date + " " + time + " 일정이 취소되었습니다. 다른 매치에 도전해주세요."; 
							
							//user_id1, user_id2 둘 다 alarm 보내주기.
							alarm.setReceiverId(receiverId);
							alarm.setSenderId(gymName);
							alarm.setAlarmMsg(alarmMsg);
							alarm.setReadYn("N"); 
							alarm.setAlarmStatus(0); 
							alarm.setNo(no);
							result2 = alarmService.insertAlarm(alarm);
							
							alarm = new Alarm();
							
							alarmMsg = "죄송합니다. " + proNick1 + "님과의 " + gymName + " " + date + " " + time + " 일정이 취소되었습니다. 다른 매치에 도전해주세요."; 
							alarm.setReceiverId(senderId);
							alarm.setSenderId(gymName);
							alarm.setAlarmMsg(alarmMsg);
							alarm.setReadYn("N"); 
							alarm.setAlarmStatus(0); 
							alarm.setNo(no);
							result2 = alarmService.insertAlarm(alarm);
						}
					} 
				}
				//삭제
				result = gymService.deleteSchedule(schedule);
				System.out.println("result = " + result);

				sum += result;
				System.out.println("sum = " + sum);		
			}
		}//토탈 FOR문 끝
		if(sum==totalCodes.length) {
			model.addAttribute("msg", "일정이 취소되었습니다.");
		} 
		return "/gym/gymCalendar";
	}
}
package com.kh.spring.gym.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.gym.model.dao.GymDao;
import com.kh.spring.gym.model.service.GymService;
import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;

@Controller
@RequestMapping("/gym")
public class GymController {
	
	@Autowired
	private GymService gymService;
	
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

	@GetMapping("/gymMainPage.gym")
	public void gymMainPage() {}
	
	@GetMapping("/gymUpdateForm.gym")
	public void gymUpdateForm() {}
	
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
		System.out.println(Arrays.toString(totalCodes));
		System.out.println(userId);
		String dateStr = "";
		String dateTime = "";
		Date date = new Date();
		int sum = 0;
		for(int i=0; i<totalCodes.length; i++) {
			Schedule schedule = new Schedule();
			schedule.setUserId(userId);
			schedule.setCode(totalCodes[i]);
			dateStr = totalCodes[i].substring(totalCodes[i].length()-12, totalCodes[i].length());
			dateTime = totalCodes[i].substring(totalCodes[i].length()-4, totalCodes[i].length());
			SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmm");
			int result = 0;
			try {
				date = formatter.parse(dateStr);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			schedule.setMatchDate(date);
			schedule.setMatchTime(dateTime);
			
			try {
				result = gymService.insertSchedule(schedule);
				sum += result;
			} catch (Exception e) {
				sum += result;
				
			}
		}
		
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
		System.out.println(Arrays.toString(totalCodes));
		System.out.println(userId);
		int sum = 0;
		
		for(int i=0; i<totalCodes.length; i++) {
			Schedule schedule = new Schedule();
			schedule.setUserId(userId);
			schedule.setCode(totalCodes[i]);
			int result = gymService.deleteSchedule(schedule);
			sum += result;
		}
		if(sum==totalCodes.length) {
			model.addAttribute("msg", "일정이 취소되었습니다.");
		} 
		return "/gym/gymCalendar";
	}
}
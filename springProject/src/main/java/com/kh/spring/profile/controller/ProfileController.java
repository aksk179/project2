package com.kh.spring.profile.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.io.File;
import java.io.IOException;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.kh.spring.common.SpringUtils;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;
import com.kh.spring.profile.model.service.ProfileService;
import com.kh.spring.profile.model.vo.GameOver;
import com.kh.spring.profile.model.vo.Profile;

@Controller
/* @SessionAttributes({"loginMember"}) */
@RequestMapping("/profile")
public class ProfileController {

	@Autowired
	private ProfileService profileService;
	@Autowired
	private ServletContext application;
	@Autowired
	private MemberService memberService;

//	@RequestMapping("/profile/profileEnroll.pr")
//	public String enrollProfile(Model model) {
//	    // 프로필 등록 로직을 수행하고 등록 여부를 확인합니다.
//	    boolean isProfileRegistered = profileService.isProfileRegistered();
//
//	    // 모델에 isProfileRegistered 변수를 추가합니다.
//	    // JSP에서 사용할 수 있도록 모델에 설정됩니다.
//	    model.addAttribute("isProfileRegistered", isProfileRegistered);
//
//	    return "profileEnroll"; // 프로필 등록 페이지로 이동
//	}

	@GetMapping("/profileEnroll.pr")
	public void profileEnroll() {
	}
	
	/*
	@PostMapping("/profileEnroll.pr")
	public String profileEnroll(Profile profile, @ModelAttribute("loginMember") Member member, Model model, @RequestParam MultipartFile upFile) {
		String saveDirectory = application.getRealPath("/resources/upload/profile");
		if(upFile.getSize() > 0) {
			String originalFilename = upFile.getOriginalFilename();
			String changeFilename = SpringUtils.changeMultipartFile(upFile);
			
			File destFile = new File(saveDirectory, changeFilename);
			try {
				upFile.transferTo(destFile);		// 실제로 저장
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			profile.setOriginalFilename(originalFilename);
			profile.setChangeFilename(changeFilename);
			System.out.println("original="+originalFilename);
			System.out.println("change="+changeFilename);
		}

		int result = profileService.insertProfile(profile);			
		if (result == 1) {
			int result2 = memberService.statusUpdate(profile.getUserId());
			
			member.setUserStatus(2);
			model.addAttribute("loginMember", member);
			//model.addAttribute("proMember", member.getUserStatus());
		 }
		return "/member/loginPage";			
	}*/
	@PostMapping("/profileEnroll.pr")
	public String profileEnroll(Profile profile, @ModelAttribute("loginMember") Member member, Model model, @RequestParam MultipartFile upFile, HttpSession session) {
		String saveDirectory = application.getRealPath("/resources/upload/profile");
		if(upFile.getSize() > 0) {
			String originalFilename = upFile.getOriginalFilename();
			String changeFilename = SpringUtils.changeMultipartFile(upFile);
			
			File destFile = new File(saveDirectory, changeFilename);
			try {
				upFile.transferTo(destFile);		// 실제로 저장
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			profile.setOriginalFilename(originalFilename);
			profile.setChangeFilename(changeFilename);
			System.out.println("original="+originalFilename);
			System.out.println("change="+changeFilename);
		}

		int result = profileService.insertProfile(profile);			
		if (result == 1) {
			int result2 = memberService.statusUpdate(profile.getUserId());
			
			member.setUserStatus(2);
			session.setAttribute("loginMember", member);
			//model.addAttribute("proMember", member.getUserStatus());
		 }
		return "/member/loginPage";			
	}

	
	@GetMapping("/profileDetail.pr")
    public void profileDetail(String userId, Model model) {
		Profile profile = profileService.selectOneProfile(userId);
		model.addAttribute("profileMember", profile);		
    }
	
	@PostMapping("/profileUpdate.pr")
	public String memberUpdate(Profile profile, Model model, @RequestParam MultipartFile upFile, RedirectAttributes redirectAtt) {
		System.out.println(profile);
		String saveDirectory = application.getRealPath("/resources/upload/profile");
		if(upFile.getSize() > 0) {
			String originalFilename = upFile.getOriginalFilename();
			String changeFilename = SpringUtils.changeMultipartFile(upFile);
			
			File destFile = new File(saveDirectory, changeFilename);
			try {
				upFile.transferTo(destFile);		// 실제로 저장
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			profile.setOriginalFilename(originalFilename);
			profile.setChangeFilename(changeFilename);
			//System.out.println("original="+originalFilename);
			//System.out.println("change="+changeFilename);
		}
		//System.out.println(profile);
		int result = profileService.updateProfile(profile);

		if (result > 0) {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 성공");
		} else {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 실패");
		}

		return "redirect:/profile/profileInfo.pr?userId=" + profile.getUserId();
	}
	
	
	 @GetMapping("/profileInfo.pr") 
	  public String profileInfo(String userId, Model model) { 
	 
	  model.addAttribute("profileMember", profileService.selectOneProfile(userId)); 
	  return "redirect:/"; 
	  }
	 
	 
	 @RequestMapping("/nick.ch")
		public String nickCheckProfile(@RequestParam String proNick, Model model) {
			Profile profile = profileService.selectTwoProfile(proNick);			
			boolean available = profile == null;

			model.addAttribute("proNick", proNick);
			model.addAttribute("available", available);
			return "jsonView";
		}

//		@GetMapping("/checkNick.pr")
//		public String checkNick(@RequestParam String proNick, Model model) {
//			Profile profile = profileService.selectOneProfile(proNick);
//			boolean available = profile == null;
//
//			model.addAttribute("proNick", proNick);
//			model.addAttribute("available", available);
//			
//			return "jsonView";
//		}
//	@GetMapping("/profileInfo.pr")
//	public String profileInfo(Model model) {
//	    String userId = "userId";
//	    Profile profile = profileService.selectOneProfile(userId);
//	    System.out.println(profile);
//	    model.addAttribute("profileMember", profileService.selectOneProfile(userId));
//	    return "profileInfo"; // 리다이렉트가 아니라 해당 페이지로 바로 이동하도록 수정합니다.
//	}
	 
	 @RequestMapping(value = "/profileDetailTwice.pr", method = RequestMethod.GET)
	 public String profileDetailTwice(HttpServletRequest request, Model model) {
		 String userId1 = request.getParameter("userId1");
		 String userId2 = request.getParameter("userId2");
		 
		 Profile profile1 = profileService.selectOneProfile(userId1);
		 System.out.println(profile1);
		 
		 Profile profile2 = profileService.selectOneProfile(userId2);
		 System.out.println(profile2);
		 
		 model.addAttribute("profile1", profile1);
		 model.addAttribute("profile2", profile2);
		 
		 return "/profile/profileDetailTwice";
	 }
	 
	 @RequestMapping(value = "/gameOver.pr", method = RequestMethod.POST)
		public String gameOver(GameOver gameOver) {
			System.out.println("gameOver() =======================================");
			int result = 0;
			int w1 = 0, w2 = 0, w3 = 0, w4 = 0, warn1 = 0, warn2 = 0, warn3 = 0, warn4 = 0, win = 0, lose = 0;
			
			w1 = gameOver.getUser1Warn1();
			w2 = gameOver.getUser1Warn2();
			w3 = gameOver.getUser1Warn3();
			w4 = gameOver.getUser1Warn4();
			
			Profile profile = new Profile();
			profile = profileService.selectOneProfile(gameOver.getUserId1());

			warn1 = w1 + profile.getWarn1();
			warn2 = w2 + profile.getWarn2();
			warn3 = w3 + profile.getWarn3();
			warn4 = w4 + profile.getWarn4();
					
			String score1 = gameOver.getResultValue1();	
			System.out.println(score1);
			
			Profile profile1 = new Profile();
			profile1.setUserId(gameOver.getUserId1());
			profile1.setWarn1(warn1);
			profile1.setWarn2(warn2);
			profile1.setWarn3(warn3);
			profile1.setWarn4(warn4);			

			System.out.println(profile1);
			
			result = profileService.updateProfile(profile1);
			
			////////////////////////////////////////////////////
			w1 = gameOver.getUser2Warn1();
			w2 = gameOver.getUser2Warn2();
			w3 = gameOver.getUser2Warn3();
			w4 = gameOver.getUser2Warn4();
			
			profile = new Profile();
			profile = profileService.selectOneProfile(gameOver.getUserId2());

			warn1 = w1 + profile.getWarn1();
			warn2 = w2 + profile.getWarn2();
			warn3 = w3 + profile.getWarn3();
			warn4 = w4 + profile.getWarn4();
					
			String ggValue2 = gameOver.getResultValue2();	
			System.out.println(ggValue2);
			
			Profile profile2 = new Profile();
			profile2.setUserId(gameOver.getUserId2());
			profile2.setWarn1(warn1);
			profile2.setWarn2(warn2);
			profile2.setWarn3(warn3);
			profile2.setWarn4(warn4);
			
			profile2.setLose(lose);

			System.out.println(profile2);
			
			result = profileService.updateProfile(profile2);
			return "";
		}
}
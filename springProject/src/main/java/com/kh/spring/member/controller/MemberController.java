package com.kh.spring.member.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.spring.member.model.dao.MemberDao;
import com.kh.spring.member.model.service.MemberService;
import com.kh.spring.member.model.vo.Member;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Controller
@RequestMapping("/member")
@SessionAttributes({"loginMember"})
public class MemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Autowired
	private MemberDao memberDao;

//	@GetMapping("/memberEnroll.me")
//	public String memberEnroll() {
//		return "member/memberEnroll";
//	}
	@RequestMapping("/GoLoginPage.me")
	public String loginPage() {
		/* return "member/loginPage"; */
		return "member/loginPage";
	}

	@GetMapping("/memberEnroll.me")
	public void memberEnroll() {
	} // => /member/memberEnroll

	@PostMapping("/memberEnroll.me")
	public String memberEnroll(Member member) {
		System.out.println("userPass = " + member);

		// 비밀번호 암호화
		String rawPassword = member.getUserPw();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPw(encodedPassword);
//		System.out.println("changePass = " + member);

		int result = memberService.insertMember(member);
		return "redirect:/";
	}
	@GetMapping("/memberNewpw.me")
	public void memberNewpw() {
	} 
	@PostMapping("/memberNewpw.me")
	
	public String memberNewpw(Member member) {
//		System.out.println("userPass = " + member);

		// 비밀번호 암호화
		String rawPassword = member.getUserPw();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPw(encodedPassword);
//		System.out.println("changePass = " + member);

		int result = memberService.insertMember(member);
		return "redirect:/";
	}

	@RequestMapping(value = "/phoneCheck", method = RequestMethod.GET)
	@ResponseBody
	public String sendSMS(@RequestParam("phone") String userPhoneNumber) { // 휴대폰 문자보내기
		int randomNumber = (int) ((Math.random() * (9999 - 1000 + 1)) + 1000);// 난수 생성

		certifiedPhoneNumber(userPhoneNumber, randomNumber);

		return Integer.toString(randomNumber);
	}

	@RequestMapping("/id.ch")
	public String idCheckMember(HttpServletRequest request, Model model) {

		String userId = request.getParameter("ida");

		Member member = memberService.selectOneMember(userId);
	
		boolean available = member == null;

		model.addAttribute("userId", userId);
		model.addAttribute("available", available);
		return "jsonView";
	}

	@GetMapping("/checkId.do")
	public String checkId(@RequestParam String userId, Model model) {
		Member member = memberService.selectOneMember(userId);
		boolean available = member == null;

		model.addAttribute("userId", userId);
		model.addAttribute("available", available);

		return "jsonView";
	}

	@GetMapping("/memberLogin.me")
	public String memberLogin() {
		return "member/memberLogin";
	}

	@PostMapping("/memberLogin.me")
	public String memberLogin(String userId, String userPw, Model model, RedirectAttributes redirectAtt) {
//		System.out.println("userId = " + userId);
//		System.out.println("userPw = " + userPw);

		Member member = memberService.selectOneMember(userId);
//		System.out.println("member = " + member);
//		if(member != null) 
//			model.addAttribute("loginMember", member);

		// 인증
		if (member != null && passwordEncoder.matches(userPw, member.getUserPw())) {
			model.addAttribute("loginMember", member); // requestScope => sessionScope 바꾸기
		} else {
			redirectAtt.addFlashAttribute("msg", "아이디 또는 비밀번호가 맞지 않습니다.");
		}
		return "redirect:/";
	}

	@GetMapping("/memberLogout.me")
	public String memberLogout(SessionStatus status) {
		if (!status.isComplete())
			status.setComplete();

		return "redirect:/";
	}

	@GetMapping("/memberDetail.me")
	public void memberDetail() {                 
	}

	@PostMapping("/memberUpdate.me")
	public String memberUpdate(Member member, Model model, RedirectAttributes redirectAtt) {
		// pw암호화해서 member.userPwd에 넣기
		String rawPassword = member.getUserPw();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPw(encodedPassword);

		int result = memberService.updateMember(member);

		if (result > 0) {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 성공");
		} else {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 실패");
		}

		return "redirect:/member/memberInfo.me?userId=" + member.getUserId();
	}
	
	@PostMapping("/memberNewUpdate.me")
	public String memberNewUpdate(Member member, Model model, RedirectAttributes redirectAtt) {
		// pw암호화해서 member.userPwd에 넣기
		String rawPassword = member.getUserPw();
		String encodedPassword = passwordEncoder.encode(rawPassword);
		member.setUserPw(encodedPassword);

		int result = memberService.pwupdateMember(member);

		if (result > 0) {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 성공");
		} else {
			redirectAtt.addFlashAttribute("msg", "회원정보 수정 실패");
		}

		return "redirect:/member/memberIdInfo.me?userEmail=" + member.getUserEmail();
	}
	@GetMapping("/memberInfo.me")
	public String memberInfo(String userId, Model model) {
		model.addAttribute("loginMember", memberService.selectOneMember(userId));
		return "redirect:/";
	}
	@GetMapping("/memberSearchId.me")
	public void memberSearchId() {                 
	}
	@GetMapping("/checkEmail.do")
	public String checkEmail(@RequestParam String userEmail, Model model) {
		Member member = memberService.selectTwoMember(userEmail);
		boolean available = member == null;

		model.addAttribute("userEmail", userEmail);
		model.addAttribute("available", available);
		
		return "jsonView";
	}
	@GetMapping("/memberidInfo.me")
	public String memberidInfo(String userEmail, Model model) {
		model.addAttribute("loginMember", memberService.selectTwoMember(userEmail));
		return "redirect:/";
	}
	@GetMapping("/memberPersonalInfo.me")
	public void memberPersonalInfo() {                 
	}
	
	@GetMapping("/deleteMember.me")
	// 버튼을 통해 넘어왔기에 무조건 get post는 폼에서 post를 지정해줘야만 가능하다
	public ModelAndView removeMember(HttpSession session, ModelAndView mv) {

		Member member = (Member) session.getAttribute("loginMember");
		String userId = member.getUserId();
		System.out.println(userId);
			int result = memberService.deleteMember(userId);

			if (result == 1) {
				 session.invalidate();
				mv.setViewName("redirect:/");
			}
		return mv;
	}
	
	public static void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) {
		String api_key = "NCS0J517ENTAJPCL";
		String api_secret = "VGHOXITCN7OORJ13MWHQWHNT3YV45U8M";
		Message coolsms = new Message(api_key, api_secret);
		
		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", userPhoneNumber);    // 수신전화번호
		params.put("from", "01067527417");    // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		params.put("type", "SMS");
		params.put("text", "[TEST] 인증번호는" + "["+randomNumber+"]" + "입니다."); // 문자 내용 입력
		params.put("app_version", "test app 1.2"); // application name and version
		
			try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
			System.out.println(1);
			} catch (CoolsmsException e) {
				System.out.println(2);
			}	    
	}
	
	/*
	@GetMapping("/removeMember.me")
	public String removeMember(HttpSession session) {
	    Member member = (Member) session.getAttribute("loginMember");
	    String userId = member.getUserId();
	    System.out.println(userId);

	    try {
	        int result = memberService.removeMember(userId);

	        if (result == 1) {
	            session.invalidate(); // 세션 무효화
	            return "redirect:/";
	        }
	    } catch (Exception e) {
	        // 에러 처리
	        e.printStackTrace();
	    }

	    return "common/error";
	}
*/
}
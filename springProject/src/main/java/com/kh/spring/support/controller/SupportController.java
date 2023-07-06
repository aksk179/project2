package com.kh.spring.support.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;

import com.kh.spring.common.SpringUtils;
import com.kh.spring.common.model.vo.PageInfo;
import com.kh.spring.common.template.Pagination;
import com.kh.spring.support.model.service.SupportService;
import com.kh.spring.support.model.vo.Notice;
import com.kh.spring.support.model.vo.Question;

@Controller
@RequestMapping("/support")
public class SupportController {
	
	@Autowired
	private SupportService supportService;
	
	@Autowired
	private ServletContext application;
	
	@Autowired
	private ResourceLoader resourceLoader;
	
	@GetMapping("/support.su")
	public String support() {
		return "support/vincero";
	}
	
	@GetMapping("/noticeForm.su")
	public String noticeForm() {
		return "support/noticeForm";
	}
	
	@GetMapping("/noticeList.su")
	public void noticeList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = supportService.selectTotalRecordNotice();
		int limit = 10;
		int offset = (nowPage - 1) * limit; 
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<Notice> noticeList = supportService.selectNoticeList(rowBounds);
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("pi", pi);
	}
	
	@PostMapping("/noticeEnroll.su")
	public String noticeEnroll(Notice notice, @RequestParam MultipartFile upFile, Model model) {
		String saveDirectory = application.getRealPath("/resources/upload/notice");
		System.out.println(saveDirectory);
		int result = 0;
		if(upFile.getSize() > 0) {
			String originalFilename = upFile.getOriginalFilename();
			String changeFilename = SpringUtils.changeMultipartFile(upFile);
			
			File destFile = new File(saveDirectory, changeFilename);
			
			try {
				upFile.transferTo(destFile);	
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			notice.setOriginalFilename(originalFilename);
			notice.setChangeFilename(changeFilename);
		}
		try {
			result = supportService.insertNotice(notice);
			model.addAttribute("msg", "공지게시판에 등록되었습니다.");
		} catch (Exception e) {
			model.addAttribute("msg", "공지게시판 등록 실패.");
		}
		
		return "redirect:/support/noticeList.su?noticeNo=1";
	}
	
	@GetMapping("/noticeDetail.su")
	public String noticeDetail(@RequestParam int noticeNo, Model model) {
		int result = supportService.updateCountNotice(noticeNo);
		Notice notice = supportService.selectOneNotice(noticeNo);
		
		model.addAttribute("notice", notice);
		System.out.println(notice.getNoticeNo());
		return "/support/noticeDetail";
	}
	
	@ResponseBody
	@GetMapping("/fileDownloadNotice.su")
	public Resource fileDownloadNotice(@RequestParam int noticeNo, HttpServletResponse response) {
		Notice notice = supportService.selectOneNotice(noticeNo);
		
		String oFilename = notice.getOriginalFilename();
		String cFilename = notice.getChangeFilename();
		
		try {
			oFilename = new String(oFilename.getBytes("utf-8"), "iso-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
		
		String saveDirectory = application.getRealPath("/resources/upload/notice");
		File downFile = new File(saveDirectory, cFilename);
		
		String location = "file:" + downFile;
		Resource resource = resourceLoader.getResource(location);
		
		response.setContentType("application/octet-stream; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=" + oFilename);
		return resource;
	}
	
	@PostMapping("/noticeUpdate.su")
	public String noticeUpdate(Notice notice, @RequestParam MultipartFile upFile, Model model) {
		String saveDirectory = application.getRealPath("/resources/upload/notice");
		System.out.println(saveDirectory);
		int result = 0;
		if(upFile.getSize() > 0) {
			String originalFilename = upFile.getOriginalFilename();
			String changeFilename = SpringUtils.changeMultipartFile(upFile);
			
			File destFile = new File(saveDirectory, changeFilename);
			
			try {
				upFile.transferTo(destFile);	
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			notice.setOriginalFilename(originalFilename);
			notice.setChangeFilename(changeFilename);
		}
		
		System.out.println(notice.getNoticeNo());
		try {
			result = supportService.updateNotice(notice);
			System.out.println(result);
			model.addAttribute("msg", "공지게시글이 수정되었습니다.");
		} catch (Exception e) {
			model.addAttribute("msg", "공지게시판 수정 실패.");
		}
		return "redirect:/support/noticeList.su?noticeNo=1";
	}
	
	@GetMapping("/noticeDelete.su")
	public String noticeDelete(@RequestParam int noticeNo, Model model) {
		int result = 0;
		System.out.println(result);
		try {
			result = supportService.deleteNotice(noticeNo);
			model.addAttribute("msg", "공지게시글이 삭제되었습니다.");
			System.out.println(result);
		} catch (Exception e) {
			model.addAttribute("msg", "공지게시판 삭제 실패.");
		}
		
		return "redirect:/support/noticeList.su?noticeNo=1";
	}
	
	@GetMapping("/cusCenter.su")
	public String cusCenter() {
		return "/support/cusCenter";
	}
	
	@GetMapping("/publicEmergency.su")
	public String publicEmergency() {
		return "/support/publicEmergency";
	}
	
	@GetMapping("/questionForm.su")
	public String questionForm() {
		return "/support/questionForm";
	}
	
	@GetMapping("/questionAnswerForm.su")
	public String questionAnswerForm(@RequestParam int questionNo, Model model) {
		model.addAttribute("questionNoFromParent", questionNo);
		return "/support/questionAnswerForm";
	}
	
	@GetMapping("/questionList.su")
	public void questionList(@RequestParam(defaultValue="1") int nowPage, Model model) {
		int totalRecord = supportService.selectTotalRecordQuestion();
		int limit = 10;
		int offset = (nowPage - 1) * limit; 
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		PageInfo pi = Pagination.getPageInfo(totalRecord, nowPage, limit, 3);
		
		List<Question> questionList = supportService.selectQuestionList(rowBounds);
		model.addAttribute("questionList", questionList);
		model.addAttribute("pi", pi);
	}
	
	@PostMapping("/questionEnroll.su")
	public String questionEnroll(Question question, @RequestParam MultipartFile upFile, Model model) {
		String saveDirectory = application.getRealPath("/resources/upload/question");
		System.out.println(saveDirectory);
		int result = 0;
		if(upFile.getSize() > 0) {
			String originalFilename = upFile.getOriginalFilename();
			String changeFilename = SpringUtils.changeMultipartFile(upFile);
			
			File destFile = new File(saveDirectory, changeFilename);
			
			try {
				upFile.transferTo(destFile);	
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			question.setOriginalFilename(originalFilename);
			question.setChangeFilename(changeFilename);
		}
		try {
			result = supportService.insertQuestion(question);
			model.addAttribute("msg", "질문게시판에 등록되었습니다.");
		} catch (Exception e) {
			model.addAttribute("msg", "질문게시판 등록 실패.");
		}
		
		return "redirect:/support/questionList.su?questionNo=1";
	}
	
	@PostMapping("/questionAnswerEnroll.su")
	public String questionAnswerEnroll(Question question, Model model) {
		int result = 0;
		question.setQuestionStatus("1");
		question.setDepth(1);
		question.setOriginalFilename("null");
		question.setChangeFilename("null");
		
		System.out.println(question.toString());
		
		try {
			result = supportService.insertQuestionAnswer(question);
			model.addAttribute("msg", "답변이 등록되었습니다.");
			System.out.println(result);
		} catch (Exception e) {
			model.addAttribute("msg", "답변 등록 실패.");
			System.out.println(result);
		}
		
		return "redirect:/support/questionList.su?questionNo=1";
	}
	
	@GetMapping("/questionDetail.su")
	public String questionDetail(@RequestParam int questionNo, Model model) {
		int result = supportService.updateCountQuestion(questionNo);
		Question question = supportService.selectOneQuestion(questionNo);
		
		model.addAttribute("question", question);
		System.out.println(question.getQuestionNo());
		return "/support/questionDetail";
	}
	
	@ResponseBody
	@GetMapping("/fileDownloadQuestion.su")
	public Resource fileDownloadQuestion(@RequestParam int questionNo, HttpServletResponse response) {
		Question question = supportService.selectOneQuestion(questionNo);
		
		String oFilename = question.getOriginalFilename();
		String cFilename = question.getChangeFilename();
		
		try {
			oFilename = new String(oFilename.getBytes("utf-8"), "iso-8859-1");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
		
		String saveDirectory = application.getRealPath("/resources/upload/question");
		File downFile = new File(saveDirectory, cFilename);
		
		String location = "file:" + downFile;
		Resource resource = resourceLoader.getResource(location);
		
		response.setContentType("application/octet-stream; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=" + oFilename);
		return resource;
	}
	
	@PostMapping("/questionUpdate.su")
	public String questionUpdate(Question question, @RequestParam MultipartFile upFile, Model model
			) {
		String saveDirectory = application.getRealPath("/resources/upload/question");
		System.out.println(saveDirectory);
		int result = 0;
		if(upFile.getSize() > 0) {
			String originalFilename = upFile.getOriginalFilename();
			String changeFilename = SpringUtils.changeMultipartFile(upFile);
			
			File destFile = new File(saveDirectory, changeFilename);
			
			try {
				upFile.transferTo(destFile);	
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			
			question.setOriginalFilename(originalFilename);
			question.setChangeFilename(changeFilename);
		}
		
		System.out.println(question.getQuestionNo());
		try {
			result = supportService.updateQuestion(question);
			System.out.println(result);
			model.addAttribute("msg", "질문게시글이 수정되었습니다.");
		} catch (Exception e) {
			model.addAttribute("msg", "질문게시글 수정 실패.");
		}
		return "redirect:/support/questionList.su?questionNo=1";
	}
	
	@GetMapping("/questionDelete.su")
	public String questionDelete(@RequestParam int questionNo, Model model) {
		int result = 0;
		System.out.println(result);
		try {
			result = supportService.deleteQuestion(questionNo);
			model.addAttribute("msg", "질문게시글이 삭제되었습니다.");
			System.out.println(result);
		} catch (Exception e) {
			model.addAttribute("msg", "질문게시글 삭제 실패.");
		}
		
		return "redirect:/support/questionList.su?questionNo=1";
	}

		public static final String SERVICE_KEY = "BLSU8cfc7cUf5JHf21bnI4ONXtjvud7j03E79f2iMyz0MOYvAo1XsYCarIwuSkAZJkErTfpSa2cMp6hIZIqO1A%3D%3D";

		@ResponseBody
		@GetMapping(value="emergency.su", produces="text/xml; charset=utf-8")
		public String Emergency(String location) throws IOException {
			String url = "http://apis.data.go.kr/B552657/ErmctInfoInqireService/getEgytListInfoInqire";
			url += "?ServiceKey=" + SERVICE_KEY;
			url += "&Q0=" + URLEncoder.encode(location, "UTF-8");
			url += "&numOfRows=100";
			URL requestUrl = new URL(url);
			HttpURLConnection urlConnection = (HttpURLConnection)requestUrl.openConnection();
			urlConnection.setRequestMethod("GET");
			
			BufferedReader br = new BufferedReader(new InputStreamReader(urlConnection.getInputStream()));
			
			String responseText = "";
			String line;
			while((line = br.readLine()) != null) {
				responseText += line;
			}
			
			System.out.println(responseText);
			
			br.close();
			urlConnection.disconnect();
			
			return responseText;
		}
		

		

}
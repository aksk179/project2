package com.kh.spring.support.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
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
		int totalRecord = supportService.selectTotalRecord();
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
		
		return "redirect:/support/noticeList.su";
	}
	
	@GetMapping("/noticeDetail.su")
	public String noticeDetail(@RequestParam int noticeNo, Model model) {
		int result = supportService.updateCountNotice(noticeNo);
		
		Notice notice = supportService.selectOneNotice(noticeNo);
		
		model.addAttribute("notice", notice);
		
		return "/support/noticeDetail";
	}
	
	@ResponseBody
	@GetMapping("/fileDownload.su")
	public Resource fileDownload(@RequestParam int noticeNo, HttpServletResponse response) {
		Notice notice = supportService.selectOneNotice(noticeNo);
		
		String oFilename = notice.getOriginalFilename();
		String cFilename = notice.getChangeFilename();
		
		try {
			oFilename = new String(oFilename.getBytes("utf-8"), "iso-8859-1");		//톰캣기본인코딩 변환처리
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}	
		
		String saveDirectory = application.getRealPath("/resources/upload/board");
		File downFile = new File(saveDirectory, cFilename);
		
		// FileSystemResource에서 파일을 받을 때 - file:경로사용
		String location = "file:" + downFile;		// downfile절대경로
		Resource resource = resourceLoader.getResource(location);
		
		response.setContentType("application/octet-stream; charset=utf-8");
		response.addHeader("Content-Disposition", "attachment; filename=" + oFilename);
		return resource;
	}
}
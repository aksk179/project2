package com.kh.spring.ranking.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/ranking")
public class RankingController {
	
	@GetMapping("/rankingList.ra")
	public void rankingList() {
		
	}
}

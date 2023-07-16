package com.kh.spring.match.model.vo;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

//DB VO : 마커출력을 위한 스케줄+체육관 정보를 읽기 위한 VO

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MatchInfo {
	private int no;
	private String gymNo;
	private String gymName;
	private String gymAddress;
	private String gymDetailAddress;
	private LocalDateTime matchdate;
	private String matchtime;
	private String code;
	private int num;
}

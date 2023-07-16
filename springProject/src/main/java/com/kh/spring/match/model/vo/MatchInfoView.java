package com.kh.spring.match.model.vo;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

import lombok.Data;

//FRONT VO : 마커랑 오버레이 출력을 위한 VO 

@Data
public class MatchInfoView {
	private String gymNo;
	private String gymName;
	private String gymAddress;
	private String gymDetailAddress;
	private List<String> matchdateList;				//화면용 6/25(수)
	private List<LocalDateTime> matchdayList;		//DB용 2023-06-25T00:00
	private List<String> matchTimeList;
	private List<String> codeList;
	private List<String> numList;
	////////////////////화면에 보여줄 거
	private String matchdate;						//07/06(목)
	private LocalDateTime matchday;					//2023-07-06T00:00
	////////////////////
	private String time;
	private String code;
	private int num;
}
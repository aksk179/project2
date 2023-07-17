package com.kh.spring.match.model.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

//DB VO

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Match {
	private int no;
	private String matchNo;
	private int gymNo;
	private String userId1;
	private String userId2;
	private LocalDateTime matchdate;
	private String matchtime;
	private String score1;
	private String score2;
	private int matchStatus;
	private String delYn;
	private int num;
	private String user1Pay;
	private String user2Pay;
	private int user1Paystatus;
	private int user2Paystatus;
}

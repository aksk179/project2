package com.kh.spring.alarm.model.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AlarmArg {
	private String receiverId;
	private String senderId;
	private String gymName;
	private LocalDateTime matchdate;
	private String matchtime;
	private int no;
	private String proNick1;
	private String proNick2;
}

package com.kh.spring.alarm.model.vo;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Alarm {
	private int alarmNo;
	private String receiverId;
	private String senderId;
	private String alarmMsg;
	private LocalDateTime alarmTime;
	private String readYn;
	private int alarmStatus;
	private int no;
	/////////////////
	private String alarmTime2;
}

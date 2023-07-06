package com.kh.spring.gym.model.vo;

import java.time.LocalDateTime;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Schedule {
	private int num;
	private String code;
	private LocalDateTime matchDate;
	private String matchTime;
    private String userId;
    private int gymNo;
}

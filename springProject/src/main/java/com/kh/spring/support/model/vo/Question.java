package com.kh.spring.support.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Question {
	@NonNull
	private int questionNo;
	@NonNull
	private String questionTitle;
	@NonNull
	private String questionWriter;
	@NonNull
	private String content;
	private String originalFilename;
	private String changeFilename;
	private int count;
	private Date createDate;
	private String questionStatus;
	private int ref;
	private int depth;
}
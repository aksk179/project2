package com.kh.spring.profile.model.vo;

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
public class Profile {
	private String userId;
	private String proNick;
	private String originalFilename;
	private String changeFilename;
	private String proMajor;
	private String proLevel;
	private int proHeight;
	private int proWeight;
	private int win;
	private int lose;
	private String personal;
	private String note;
	private int warn1;
	private int warn2;
	private int warn3;
	private int warn4;

}
package com.kh.spring.member.model.vo;

import java.sql.Date;

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
public class Member {
	   private String userId;
	   private String userPw;   
	   private String userRnn;
	   private String userName;
	   private String userGender;
	   private String userEmail;
	   private String phone;
	   private String zipcode;
	   private String address;
	   private String detailaddress;
	   private String userType;
	   private int userStatus;
	   private int userControl;
	   private Date userRegdate;
	   private int userInfo;
	}
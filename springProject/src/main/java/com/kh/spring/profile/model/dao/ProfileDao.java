package com.kh.spring.profile.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kh.spring.member.model.vo.Member;
import com.kh.spring.profile.model.vo.Profile;

@Mapper
public interface ProfileDao {

	int profileEnroll(Profile profile);

	Profile profileUpdate(String userId);

	int updateProfile(Profile profile);
	
	Profile selectOneProfile(String userId);

	Profile selectTwoProfile(String proNick);

	int insertProfile(Profile profile);

	int getProfileCountByNickName(String proNick);


}

package com.kh.spring.profile.model.service;

import com.kh.spring.profile.model.vo.Profile;

public interface ProfileService {

	int profileEnroll(Profile profile);

	/* Profile profileUpdate(String userId); */

	boolean isProfileRegistered();

	int updateProfile(Profile profile);

	Profile selectOneProfile(String userId);
	
	Profile selectTwoProfile(String proNick);

	int insertProfile(Profile profile);

	boolean isNickNameDuplicate(String proNick);

}

package com.kh.spring.profile.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.profile.model.dao.ProfileDao;
import com.kh.spring.profile.model.vo.Profile;

@Service
public class ProfileServiceImpl implements ProfileService {

    @Autowired
    private ProfileDao profileDao;

    @Override
    public int insertProfile(Profile profile) {
        return profileDao.insertProfile(profile);
    }

    @Override
    public int profileEnroll(Profile profile) {
        return profileDao.profileEnroll(profile);
    }

    @Override
    public boolean isProfileRegistered() {
        return false;
    }

    @Override
    public int updateProfile(Profile profile) {
        return profileDao.updateProfile(profile);
    }
    
	@Override
	public Profile selectOneProfile(String userId) {
		return profileDao.selectOneProfile(userId);
	}
	
	@Override
	public Profile selectTwoProfile(String proNick) {
		return profileDao.selectTwoProfile(proNick);
	}

	@Override
	public boolean isNickNameDuplicate(String proNick) {
	    int count = profileDao.getProfileCountByNickName(proNick);
	    return count > 0;
	}
}

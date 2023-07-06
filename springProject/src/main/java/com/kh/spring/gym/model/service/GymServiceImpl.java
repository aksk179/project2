package com.kh.spring.gym.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.gym.model.dao.GymDao;
import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;

@Service
public class GymServiceImpl implements GymService {
	@Autowired
	private GymDao gymDao;
	
	@Override
	public int insertJoin(Gym gym) {
		return gymDao.insertJoin(gym);
	}

	@Override
	public int insertSchedule(Schedule schedule) {
		return gymDao.insertSchedule(schedule);
	}

	@Override
	public List<Schedule> selectCodeList(String userId) {
		return gymDao.selectCodeList(userId);
	}

	@Override
	public int deleteSchedule(Schedule schedule) {
		return gymDao.deleteSchedule(schedule);
	}

	@Override
	public Gym selectGymNo(String userId) {
		return gymDao.selectGymNo(userId);
	}

	@Override
	public Gym myGym(int gymNo) {
		return gymDao.myGym(gymNo);
	}

	@Override
	public Gym selectMyGym(int gymNo) {
		return gymDao.selectMyGym(gymNo);
	}

	@Override
	public int myGymUpdate(Gym gym) {
		return gymDao.myGymUpdate(gym);
	}

	@Override
	public Gym getGymByUserId(String userId) {
		return gymDao.getGymByUserId(userId);
	}


}
package com.kh.spring.gym.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;

public interface GymService {
	int insertJoin(Gym gym);

	int insertSchedule(Schedule schedule);

	List<Schedule> selectCodeList(String userId);

	int deleteSchedule(Schedule schedule);

	Gym selectGymNo(String userId);

	Gym myGym(int gymNo);

	Gym selectMyGym(int gymNo);

	int myGymUpdate(Gym gym);

	Gym getGymByUserId(String userId);

}
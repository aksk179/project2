package com.kh.spring.gym.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;

import com.kh.spring.alarm.model.vo.AlarmArg;
import com.kh.spring.gym.model.vo.Gym;
import com.kh.spring.gym.model.vo.Schedule;
import com.kh.spring.match.model.vo.Match;
import com.kh.spring.match.model.vo.MatchList;

@Mapper
public interface GymDao {
	int insertJoin(Gym gym);

	int insertSchedule(Schedule schedule);

	List<Schedule> selectCodeList(String userId);

	int deleteSchedule(Schedule schedule);

	Gym selectGymNo(String userId);

	Gym myGym(int gymNo);

	Gym selectMyGym(int gymNo);

	int myGymUpdate(Gym gym);

	Gym getGymByUserId(String userId);

	List<Match> selectScheduleMatchList(Schedule schedule);

	List<AlarmArg> selectScheduleDel(String matchNo);

	List<MatchList> selectMyGymMatchList(int gymNo, RowBounds rowBounds);

	int selectTotalRecord(int gymNo);
}
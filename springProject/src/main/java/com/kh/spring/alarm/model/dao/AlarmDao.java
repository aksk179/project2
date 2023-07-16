package com.kh.spring.alarm.model.dao;

import java.time.LocalDateTime;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.kh.spring.alarm.model.vo.Alarm;
import com.kh.spring.alarm.model.vo.AlarmArg;
import com.kh.spring.match.model.vo.Match;

@Mapper
public interface AlarmDao {

	int checkAlarm(@Param("receiverId")String userId);

	List<Alarm> readAlarmList(@Param("receiverId")String userId);

	int readYnUpdate(Alarm al);

	int insertAlarm(Alarm alarm);

	List<AlarmArg> selectAlarmArg(Match m);

}

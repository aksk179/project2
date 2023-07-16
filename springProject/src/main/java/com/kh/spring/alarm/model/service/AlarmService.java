package com.kh.spring.alarm.model.service;

import java.util.List;

import com.kh.spring.alarm.model.vo.Alarm;
import com.kh.spring.alarm.model.vo.AlarmArg;
import com.kh.spring.match.model.vo.Match;

public interface AlarmService {

	int checkAlarm(String userId);

	List<Alarm> readAlarmList(String userId);

	int readYnUpdate(Alarm al);

	int insertAlarm(Alarm alarm);

	List<AlarmArg> selectAlarmArg(Match m);

}

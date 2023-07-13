package com.kh.spring.alarm.model.service;

import java.util.List;

import com.kh.spring.alarm.model.vo.Alarm;

public interface AlarmService {

	int checkAlarm(String userId);

	List<Alarm> readAlarmList(String userId);

	int readYnUpdate(Alarm al);

	int insertAlarm(Alarm alarm);

}

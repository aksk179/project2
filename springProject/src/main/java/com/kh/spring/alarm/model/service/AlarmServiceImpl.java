package com.kh.spring.alarm.model.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.alarm.model.dao.AlarmDao;
import com.kh.spring.alarm.model.vo.Alarm;

@Service
public class AlarmServiceImpl implements AlarmService{
	
	@Autowired
	private AlarmDao alarmDao;

	@Override
	public int checkAlarm(String userId) {
		return alarmDao.checkAlarm(userId);
	}

	@Override
	public List<Alarm> readAlarmList(String userId) {
		return alarmDao.readAlarmList(userId);
	}

	@Override
	public int readYnUpdate(Alarm al) {
		return alarmDao.readYnUpdate(al);
	}
}

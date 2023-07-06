package com.kh.spring.member.model.service;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.member.model.dao.MemberDao;
import com.kh.spring.member.model.vo.Member;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;

	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	@Override
	public Member selectOneMember(String userId) {
		return memberDao.selectOneMember(userId);
	}

	@Override
	public Member selectTwoMember(String userEmail) {
		return memberDao.selectTwoMember(userEmail);
	}

	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}
	@Override
	public int pwupdateMember(Member member) {
		return memberDao.pwupdateMember(member);
	}
	
	
	@Override
	public int deleteMember(String userId) {
		return memberDao.deleteMember(userId);
	}

	@Override
	public int statusUpdate(String userId) {
        return memberDao.statusUpdate(userId);
	}
	
	@Override
	public int mnStatusUpdate(String userId) {
		return memberDao.mnStatusUpdate(userId);
	}
}

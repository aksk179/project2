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

	public static void certifiedPhoneNumber(String userPhoneNumber, int randomNumber) {
		String api_key = "NCS0J517ENTAJPCL";
		String api_secret = "VGHOXITCN7OORJ13MWHQWHNT3YV45U8M";
		Message coolsms = new Message(api_key, api_secret);

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", userPhoneNumber); // 수신전화번호
		params.put("from", "01067527417"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
		params.put("type", "SMS");
		params.put("text", "[TEST] 인증번호는" + "[" + randomNumber + "]" + "입니다."); // 문자 내용 입력
		params.put("app_version", "test app 1.2"); // application name and version

		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
			System.out.println(1);
		} catch (CoolsmsException e) {
			System.out.println(2);
		}
	}

	@Override
	public int deleteMember(String userId) {
		return memberDao.deleteMember(userId);
	}
	
	@Override
	   public int mnStatusUpdate(String userId) {
	      return memberDao.mnStatusUpdate(userId);
	   } 

	@Override
	public int statusUpdate(String userId) {
		return memberDao.statusUpdate(userId);
	}

	public interface MemberService {
		String findUserIdByEmail(String userEmail);
	}

	@Override
	public String findUserIdByEmail(String userEmail) {
		return memberDao.findUserIdByEmail(userEmail);
	}

}

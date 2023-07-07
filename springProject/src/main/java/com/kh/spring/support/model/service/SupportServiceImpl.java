package com.kh.spring.support.model.service;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.spring.support.model.dao.SupportDao;
import com.kh.spring.support.model.vo.Notice;
import com.kh.spring.support.model.vo.Question;

@Service
public class SupportServiceImpl implements SupportService{
	
	@Autowired
	private SupportDao supportDao;
	
	@Override
	public int selectTotalRecordNotice() {
		return supportDao.selectTotalRecordNotice();
	}

	@Override
	public List<Notice> selectNoticeList(RowBounds rowBounds) {
		return supportDao.selectNoticeList(rowBounds);
	}

	@Override
	public int insertNotice(Notice notice) {
		return supportDao.insertNotice(notice);
	}

	@Override
	public int updateCountNotice(int noticeNo) {
		return supportDao.updateCountNotice(noticeNo);
	}

	@Override
	public Notice selectOneNotice(int noticeNo) {
		return supportDao.selectOneNotice(noticeNo);
	}

	@Override
	public int updateNotice(Notice notice) {
		return supportDao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return supportDao.deleteNotice(noticeNo);
	}
	
	@Override
	public int selectTotalRecordQuestion() {
		return supportDao.selectTotalRecordQuestion();
	}

	@Override
	public List<Question> selectQuestionList(RowBounds rowBounds) {
		return supportDao.selectQuestionList(rowBounds);
	}

	@Override
	public int insertQuestion(Question question) {
		return supportDao.insertQuestion(question);
	}
	
	@Override
	public int updateCountQuestion(int questionNo) {
		return supportDao.updateCountQuestion(questionNo);
	}

	@Override
	public Question selectOneQuestion(int questionNo) {
		return supportDao.selectOneQuestion(questionNo);
	}

	@Override
	public int updateQuestion(Question question) {
		return supportDao.updateQuestion(question);
	}

	@Override
	public int deleteQuestion(int questionNo) {
		return supportDao.deleteQuestion(questionNo);
	}

	@Override
	public int insertQuestionAnswer(Question question) {
		return supportDao.insertQuestionAnswer(question);
	}

	@Override
	public int updateQuestionStatus(int ref) {
		return supportDao.updateQuestionStatus(ref);
	}
}

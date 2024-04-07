package com.ict.guestbook2.service;

import java.util.List;

import com.ict.guestbook2.dao.GuestBook2VO;

public interface GuestBook2Service {
	// 전체보기
	public List<GuestBook2VO> getGuestBook2List();
	
	// 삽입
	public int getGuestBook2Insert(GuestBook2VO vo);
	
	// 상세보기
	public GuestBook2VO getGuestBook2Detail(String idx);
	
	// 삭제
	public int getGuestBook2Delete(String idx);
	
	// 수정
	public int getGuestBook2Update(GuestBook2VO vo);
	
}

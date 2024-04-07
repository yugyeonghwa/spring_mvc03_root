package com.ict.guestbook2.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.guestbook2.dao.GuestBook2DAO;
import com.ict.guestbook2.dao.GuestBook2VO;

@Service
public class GuestBook2ServiceImpl implements GuestBook2Service {
	@Autowired
	private GuestBook2DAO guestBook2DAO;
	
	@Override
	public List<GuestBook2VO> getGuestBook2List() {
		return guestBook2DAO.getGuestBook2List();
	}

	@Override
	public int getGuestBook2Insert(GuestBook2VO vo) {
		return guestBook2DAO.getGuestBook2Insert(vo);
	}
	

	@Override
	public GuestBook2VO getGuestBook2Detail(String idx) {
		return guestBook2DAO.getGuestBook2Detail(idx);
	}

	@Override
	public int getGuestBook2Delete(String idx) {
		return 0;
	}

	@Override
	public int getGuestBook2Update(GuestBook2VO vo) {
		return 0;
	}

}

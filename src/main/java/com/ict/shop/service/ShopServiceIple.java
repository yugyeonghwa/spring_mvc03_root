package com.ict.shop.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ict.shop.dao.CartVO;
import com.ict.shop.dao.ShopDAO;
import com.ict.shop.dao.ShopVO;

@Service
public class ShopServiceIple implements ShopService{
	
	@Autowired
	private ShopDAO shopDAO;
	
	//	카테고리 상품 리스트 불러오기
	@Override
	public List<ShopVO> getShopList(String category) throws Exception {
		return shopDAO.getShopList(category);
	}

	@Override
	public ShopVO getShopDetail(String shop_idx) throws Exception {
		return shopDAO.getShopDetail(shop_idx);
	}

	@Override
	public CartVO getCartChk(String m_id, String p_num) {
		return shopDAO.getCartChk(m_id, p_num);
	}
	
	@Override
	public int getCartInsert(CartVO cavo) throws Exception {
		return shopDAO.getCartInsert(cavo);
	}
	
	@Override
	public int getCartUpdate(CartVO cavo) throws Exception {
		return shopDAO.getCartUpdate(cavo);
	}
	
	@Override
	public List<CartVO> getCartList(String m_id) throws Exception {
		return shopDAO.getCartList(m_id);
	}
	
	@Override
	public int getCartEdit(CartVO cavo) throws Exception {
		return shopDAO.getCartEdit(cavo);
	}

	@Override
	public int getCartDelete(String ca_idx) throws Exception {
		return shopDAO.getCartDelete(ca_idx);
	}

	@Override
	public int getProductInsert(ShopVO svo) throws Exception {
		return shopDAO.getProductInsert(svo);
	}
}

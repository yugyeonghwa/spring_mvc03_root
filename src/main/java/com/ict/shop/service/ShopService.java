package com.ict.shop.service;

import java.util.List;

import com.ict.shop.dao.CartVO;
import com.ict.shop.dao.ShopVO;

public interface ShopService {
	
	//	카테고리 상품 리스트
	public List<ShopVO> getShopList(String category) throws Exception;
	
	//	상품상세 보기	
	public ShopVO getShopDetail(String shop_idx) throws Exception;
	
	//	장바구니에 있는지 없는지 체크
	public CartVO getCartChk(String m_id, String p_num);
	
	//	회원 장바구니 리스트
	public List<CartVO> getCartList(String m_id) throws Exception;
	
	//	장바구니 추가
	public int getCartInsert(CartVO cavo) throws Exception;
	
	//	장바구니 추가시 수정
	public int getCartUpdate(CartVO cavo) throws Exception;
	
	//	장바구니 삭제
	public int getCartDelete(String ca_idx) throws Exception; 
	
	//	장바구니 수량 변경
	public int getCartEdit(CartVO cavo) throws Exception;
	
	public int getProductInsert(ShopVO svo) throws Exception;
	
	
}

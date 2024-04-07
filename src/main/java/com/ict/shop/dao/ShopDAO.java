package com.ict.shop.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ShopDAO {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public List<ShopVO> getShopList(String category) throws Exception {
		return sqlSessionTemplate.selectList("shop.shop_list", category);
	}

	public ShopVO getShopDetail(String shop_idx) throws Exception {
		return sqlSessionTemplate.selectOne("shop.shop_detail", shop_idx);
	}
	
	public CartVO getCartChk(String m_id, String p_num) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("m_id", m_id);
		map.put("p_num", p_num);
		return sqlSessionTemplate.selectOne("shop.cart_chk", map);
	}
	
	public int getCartInsert(CartVO cavo) throws Exception {
		return sqlSessionTemplate.insert("shop.cart_insert", cavo);
	}

	public int getCartUpdate(CartVO cavo) throws Exception {
		return sqlSessionTemplate.update("shop.cart_update", cavo);
	}

	public List<CartVO> getCartList(String m_id) throws Exception {
		return sqlSessionTemplate.selectList("shop.cart_list", m_id);
	}

	public int getCartEdit(CartVO cavo) throws Exception {
		return sqlSessionTemplate.update("shop.cart_edit", cavo);
	}
	
	public int getCartDelete(String ca_idx) throws Exception {
		return sqlSessionTemplate.delete("shop.cart_delete", ca_idx);
	}
	
	public int getProductInsert(ShopVO svo) throws Exception {
		return sqlSessionTemplate.insert("shop.product_insert", svo);
	}
	
}

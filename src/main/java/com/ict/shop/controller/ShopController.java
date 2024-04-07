package com.ict.shop.controller;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ict.common.Paging;
import com.ict.member.dao.MemberVO;
import com.ict.shop.dao.CartVO;
import com.ict.shop.dao.ShopVO;
import com.ict.shop.service.ShopService;
import com.jcraft.jsch.Session;

@Controller
public class ShopController {

	@Autowired
	private ShopService shopService;

	@GetMapping("shop_list.do")
	public ModelAndView getShopList(String category, HttpServletRequest request) {
		try {
			ModelAndView mv = new ModelAndView("shop/shop_list");
			// 맨처음 카테고리가 안들어올 때는
			if (category == null || category == "") {
				// 특정 카테고리를 넣어주자
				category = "ele002";
			}

			// DB 갔다오자
			List<ShopVO> shop_list = shopService.getShopList(category);
			if (shop_list != null) {
				mv.addObject("shop_list", shop_list);
				return mv;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("shop/error");
	}

	@GetMapping("shop_detail.do")
	public ModelAndView getShopDetail(String shop_idx) {
		try {
			ModelAndView mv = new ModelAndView("shop/shop_detail");

			ShopVO svo = shopService.getShopDetail(shop_idx);
			if (svo != null) {
				mv.addObject("svo", svo);
				return mv;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("shop/error");
	}

	@GetMapping("shop_addCart.do")
	public ModelAndView getAddCart(@ModelAttribute("shop_idx") String shop_idx, HttpSession session) {
		try {
			String loginChk = (String) session.getAttribute("loginChk");
			if (loginChk.equals("ok")) {
				ModelAndView mv = new ModelAndView("redirect:shop_detail.do");

				// 장바구니에 담을때 (찜도 같은 방식)
				// 로그인한 정보를 가져와서 사용자(m_id)가 누군지를 같이 보내줘야한다. (현재는 로그인 없으니 : park 으로)
				MemberVO mvo = (MemberVO) session.getAttribute("mvo2");
				String m_id = mvo.getM_id();

				// shop_idx 로 DB 에 가서 제품 정보를 가져오자
				ShopVO svo = shopService.getShopDetail(shop_idx);

				// 해당제품과 회원id 가 장바구니에 있는지 확인해야 된다.
				CartVO cavo = shopService.getCartChk(m_id, svo.getP_num());
				if (cavo == null) {
					// 장바구니에 정보가 없으면 장바구니에 추가
					CartVO cavo2 = new CartVO();
					cavo2.setP_num(svo.getP_num());
					cavo2.setP_name(svo.getP_name());
					cavo2.setP_price(String.valueOf(svo.getP_price()));
					cavo2.setP_saleprice(String.valueOf(svo.getP_saleprice()));
					cavo2.setM_id(m_id);
					// DB 갔다오자
					int result = shopService.getCartInsert(cavo2);
				} else {
					// 장바구니에 정보가 있으면 제품의 수량 1 증가
					int result = shopService.getCartUpdate(cavo);
				}
				return mv;
			} else {
				return new ModelAndView("member/login_error");
			}
		} catch (Exception e) {
			return new ModelAndView("member/login_error");
		}
	}

	@GetMapping("shop_showCart.do")
	public ModelAndView getCartList(HttpSession session) {
		try {
			String loginChk = (String) session.getAttribute("loginChk");
			if (loginChk == null) {
				return new ModelAndView("member/login_error");
			} else if (loginChk.equals("ok")) {
				ModelAndView mv = new ModelAndView("shop/cart_list");
				
				// 로그인한 정보를 가져와서 사용자id를 같이 가야 된다.
				MemberVO mvo = (MemberVO) session.getAttribute("mvo2");
				String m_id = mvo.getM_id();
				
				List<CartVO> cart_list = shopService.getCartList(m_id);
				if (cart_list != null) {
					mv.addObject("cart_list", cart_list);
					return mv;
				}
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("shop/error");
	}

	@PostMapping("cart_edit.do")
	public ModelAndView getCartEdit(CartVO cavo) {
		try {
			ModelAndView mv = new ModelAndView("redirect:shop_showCart.do");
			int result = shopService.getCartEdit(cavo);
			if (result > 0) {
				return mv;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("shop/error");
	}

	@GetMapping("shop_cart_delete.do")
	public ModelAndView getCartDelete(String cart_idx) {
		try {
			ModelAndView mv = new ModelAndView("redirect:shop_showCart.do");
			int result = shopService.getCartDelete(cart_idx);
			if (result > 0) {
				return mv;
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("shop/error");
	}
	
	@GetMapping("shop_product_insertForm.do")
	public ModelAndView getProductInsertForm() {
		return new ModelAndView("shop/product_insertForm");
	}
	
	@PostMapping("shop_product_insert.do")
	public ModelAndView getProductInsert(ShopVO svo, HttpServletRequest request) {
		try {
			String path = request.getSession().getServletContext().getRealPath("/resources/images");
			MultipartFile file_s = svo.getFile_s();
			MultipartFile file_l = svo.getFile_l();
			if (file_s.isEmpty()) {
				svo.setP_image_s("");
			} else {
				UUID uuid = UUID.randomUUID();
				String f_name = uuid.toString()+"_"+file_s.getOriginalFilename();
				svo.setP_image_s(f_name);
				
				byte[] in = file_s.getBytes();
				File out = new File(path, f_name);
				FileCopyUtils.copy(in, out);
			}
			
			if (file_l.isEmpty()) {
				svo.setP_image_l("");
			} else {
				UUID uuid = UUID.randomUUID();
				String f_name = uuid.toString()+"_"+file_l.getOriginalFilename();
				svo.setP_image_l(f_name);
				
				byte[] in = file_l.getBytes();
				File out = new File(path, f_name);
				FileCopyUtils.copy(in, out);
			}
			
			int result = shopService.getProductInsert(svo);
			if (result > 0) {
				return new ModelAndView("redirect:shop_list.do?category="+svo.getCategory());
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return new ModelAndView("shop/error");
	}

}

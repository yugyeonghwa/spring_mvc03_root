package com.ict.sns.naver;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.Gson;
import com.ict.sns.kakao.KakaoUserVO;

@RestController
public class NaverAjaxController2 {
	
	
	@RequestMapping(value = "naverUser2.do", produces = "text/plain; charset=utf-8")
	@ResponseBody
	public String memberChk(HttpSession session) {
		//	세션에 있는 access_token 을 가지고 사용자 정보를 가져올 수 있다.
		String access_token = (String) session.getAttribute("access_token");
		
		String apiURL = "https://openapi.naver.com/v1/nid/me";
		
		try {
			URL url = new URL(apiURL);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			// POST 요청
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);

			// 헤더 요청
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setRequestProperty("Authorization", "Bearer " + access_token);

			// 200 이면 성공과 같은 의미 (HttpURLConnection.HTTP_OK)
			int responseCode = conn.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

				String line = "";
				StringBuffer sb = new StringBuffer();
				while ((line = br.readLine()) != null) {
					sb.append(line);
				}
				
				String result = sb.toString();
				
				  Gson gson = new Gson(); // json 객체 => fromJson(변경될 json, 변경된 객체) 
				  NaverUserVO nvo = gson.fromJson(result, NaverUserVO.class);
				  
				  String naver_id = nvo.getResponse().getId();
				  String naver_nickname = nvo.getResponse().getNickname();
				  String naver_email = nvo.getResponse().getEmail();
				  String naver_mobile = nvo.getResponse().getMobile();
				  String naver_name = nvo.getResponse().getName();
				  String naver_profile_image = nvo.getResponse().getProfile_image();
				 
				// DB에 저장하기

				 return naver_id + "/" + naver_nickname + "/" + naver_email + "/" + naver_mobile + "/" + naver_name + "/" + naver_profile_image; 
			}
		} catch (Exception e) {
			System.out.println("연결 실패");
		}
		return null;
	}
}
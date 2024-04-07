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

@RestController
public class NaverAjaxController {
	
	
	@RequestMapping(value = "naverUser.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String memberChk(HttpSession session) {
		
		//	세션에 있는 access_token 을 가지고 사용자 정보를 가져올 수 있다.
		String access_token = (String) session.getAttribute("access_token");
		
		String apiURL = "https://openapi.naver.com/v1/nid/me";
		
		//	요청 : 엑세스 토큰 방식
		//	필수 - 헤더 (Authorization, Content-type)
		String header = "Bearer " + access_token;
		
		//	GET 방식으로
		Map<String, String> requestHeaders = new HashMap<String, String>();
		requestHeaders.put("Authorization", header);
							//	key			value
		
		String responseBody = naver_send(apiURL, requestHeaders, session);
		
		return responseBody;
	}
	
	public String naver_send(String apiURL, Map<String, String> requestHeaders, HttpSession session) {
		HttpURLConnection conn = null;
		try {
			URL url = new URL(apiURL);
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				conn.setRequestProperty(header.getKey(), header.getValue());
			}
			
			int responseCode = conn.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				return readBody(conn.getInputStream(), session);
			}else {
				return readBody(conn.getErrorStream(), session);
			}
			
		} catch (Exception e) {
			
		} finally {
			try {
				conn.disconnect();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		return null;
	}
	
	public String  readBody(InputStream body, HttpSession session) {
		try {
			BufferedReader br = new BufferedReader(new InputStreamReader(body));
			StringBuffer sb = new StringBuffer();
			String line = "";
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			
			session.setAttribute("loginChk", "ok");
			return sb.toString();
			
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}
	
}

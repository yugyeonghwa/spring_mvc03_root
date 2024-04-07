package com.ict.sns.kakao;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class KakaoAjaxController {
	
	@RequestMapping(value = "kakaoUser.do", produces = "application/json; charset=utf-8")
	@ResponseBody
	public String memberChk(HttpSession session) {
		
		//	세션에 있는 access_token 을 가지고 사용자 정보를 가져올 수 있다.
		String access_token = (String) session.getAttribute("access_token");
		
		//	사용자 정보 가져오기 가서 보자
		//	가야할 주소 : https://kapi.kakao.com/v2/user/me
		String apiURL = "https://kapi.kakao.com/v2/user/me";
		
		//	요청 : 엑세스 토큰 방식
		//	필수 - 헤더 (Authorization, Content-type)
		String header = "Bearer " + access_token;
		
		//	GET 방식으로
		Map<String, String> requestHeaders = new HashMap<String, String>();
		requestHeaders.put("Authorization", header);
							//	key			value
		
		String responseBody = kakao_send(apiURL, requestHeaders, session);
		
		return responseBody;
	}
	
	public String kakao_send(String apiURL, Map<String, String> requestHeaders, 
			HttpSession session) {
		
		HttpURLConnection conn = null;
		try {
			URL url = new URL(apiURL);
			conn = (HttpURLConnection) url.openConnection();
			
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			
			for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
				conn.setRequestProperty(header.getKey(), header.getValue());
			}
			
			//	200 이면 성공과 같은 의미 (HttpURLConnection.HTTP_OK)
			int responseCode = conn.getResponseCode();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				System.out.println("성공");
				return readBody(conn.getInputStream(), session); 
			}else {
				System.out.println("실패");
				return readBody(conn.getErrorStream(), session);
			}
			
		} catch (Exception e) {
			System.out.println("연결실패");
		} finally {
			try {
				//	접속 끊기
				conn.disconnect();
			} catch (Exception e2) {
			}
		}
		return null;
	}
	
	public String readBody(InputStream body, HttpSession session) {
		//	보내서 성공했으니 읽어라
		InputStreamReader isr = new InputStreamReader(body);
		try {
			BufferedReader br = new BufferedReader(isr);
			StringBuffer sb = new StringBuffer();
			String line = "";
			while ((line = br.readLine()) != null) {
				sb.append(line);
			}
			//	결과 보기
			//System.out.println(sb.toString());
			
			//	혹시 DB 에 저장하려면 여기서 DB 처리를 해줘야한다.
			//	또는 세션에 로그인 성공했다는 체크를 저장해주자.
			//	(세션을 계속 가져오고 넘겨줘야한다.)
			session.setAttribute("loginChk", "ok");
			
			return sb.toString();
			
		} catch (Exception e) {
			System.out.println("API 응답을 읽는데 실패");
		}
		return null;
	}
	
	
	
	
	
	
}

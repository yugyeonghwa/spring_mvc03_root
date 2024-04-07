<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function kakao_map01() {
		location.href="kakaomap01.do";
	}
	
	function kakao_map02() {
		location.href="kakaomap02.do";
	}
	
	function kakao_map03() {
		location.href="kakaomap03.do";
	}
	
	function kakao_map04() {
		location.href="kakaomap04.do";
	}
	
	function kakao_addr() {
		location.href="kakaoaddr.do";
	}
	
</script>
</head>
<body>
	
	<h1>SNS 로그인</h1>
	<hr>
<%-- 
		카카오 로그인
		1. https://developers.kakao.com/ 접속 로그인 하기
		
		2. 내 애플리케이션에서 애플리케이션 추가
			- REST API 키 복사 : 84f22c8078987862ac7f5051394c4959
			- 플랫폼 설정하기 : iOS, Android, Web 
				- Web 플랫폼 등록 : http://localhost:8090
							(원래는 https://도메인 , https://서버IP주소)
			- **Redirect URI 등록 
				- 활성화 설정 on 
				- 등록 : http://localhost:8090/kakaologin.do
			
		3. 문서 - 카카오 로그인 - 이해하기 (그림)
							- REST API - 리소스 다운로드 받기 (로그인 버튼 그림)
										(필요한 사진 resources/images 에 넣기)
		
		4. 카카오 로그인 요청 - 인가코드 받기 요청 (요청 - 쿼리 파라미터 - 확인!)
			
			1) GET 방식 => a 링크 
			
			2) 가야할 주소 => href = https://kauth.kakao.com/oauth/authorize
				
			3) 요청할때 가져가야할 쿼리파라미터
				(client_id, redirect_uri, response_type)
				
		5. 응답 - 토큰 받기 요청에 필요한 인가 코드를 받자 (code)
			
--%>	
	<!-- 카카오 로그인 -->
	<a href="https://kauth.kakao.com/oauth/authorize
	?client_id=056ecfd443420cd358feb588ea0449ec
	&redirect_uri=http://localhost:8090/kakaologin.do
	&response_type=code">
		<img src="resources/images/kakao_login.png">
	</a>
	
	<!-- 네이버 로그인 -->
	<a href="https://nid.naver.com/oauth2.0/authorize
	?response_type=code
	&client_id=LyIsBmodzGZFrv267acE
	&state=test
	&redirect_uri=http://localhost:8090/naver_login.do">
		<img src="resources/images/naver_login.png">
	</a>
	
	<hr>
	<button type="button" onclick="kakao_map01()">카카오 지도 연습 01</button>
	<button type="button" onclick="kakao_map02()">카카오 지도 연습 02</button>
	<button type="button" onclick="kakao_map03()">카카오 지도 연습 03</button>
	<button type="button" onclick="kakao_map04()">카카오 지도 연습 04</button>
	<button type="button" onclick="kakao_addr()">다음 주소 API</button>
	
	
</body>
</html>
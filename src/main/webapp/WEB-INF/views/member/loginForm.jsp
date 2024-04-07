<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="member_login.do" method="post" autocomplete="on">
		<fieldset style="width: 500px">
			  <legend style="font-weight: bold; font-size: 20px">로그인</legend>
		 	  <label >ID : <input type="text" name="m_id" ></label>
		      <label >PW : <input type="password" name="m_pw"></label>
		      <input type="submit" value="로그인" >
	    </fieldset>
	</form>
</body>
</html>
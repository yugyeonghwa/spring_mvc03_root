<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- summer note -->
<link rel="stylesheet" href="resources/css/summernote-lite.css">
<style type="text/css">
	#bbs table {
	    width:580px;
	    margin:0 auto;
	    margin-top:20px;
	    border:1px solid black;
	    border-collapse:collapse;
	    font-size:14px;
	    
	}
	
	#bbs table caption {
	    font-size:20px;
	    font-weight:bold;
	    margin-bottom:10px;
	}
	
	#bbs table th {
	    text-align:center;
	    border:1px solid black;
	    padding:4px 10px;
	}
	
	#bbs table td {
	    text-align:left;
	    border:1px solid black;
	    padding:4px 10px;
	}
	
	.no {width:15%}
	.subject {width:30%}
	.writer {width:20%}
	.reg {width:20%}
	.hit {width:15%}
	.title{background:lightsteelblue}
	.odd {background:silver}
	
	/* summernote toolbar 수정 */
	.note-btn-group{width: auto;}
	.note-toolbar{width: auto;}
</style>

<script type="text/javascript">
	function bbs_list(f) {
		f.action="bbs_list.do";
		f.submit();
	}
	
	function bbs_delete(f) {
		f.action="bbs_delete.do";
		f.submit();
	}

	function bbs_update(f) {
		f.action="bbs_update.do";
		f.submit();
	}
	
	function comment_insert(f) {
		f.action="comment_insert.do";
		f.submit();
	}
	
	function comment_delete(f) {
		f.action="comment_delete.do";
		f.submit();
	}
</script>
</head>
<body>
	<div id="bbs">
	<form method="post">
		<table>
			<caption>게시판 글쓰기</caption>
			<tbody>
				<tr>
					<th>제목:</th>
					<td>${bvo.subject}</td>
				</tr>
				<tr>
					<th>이름:</th>
					<td>${bvo.writer}</td>
				</tr>
				<tr>
					<th>내용:</th>
					<td>
						<%-- <pre>${bvo.content}</pre> --%>
						<textarea id="content" name="content" cols="50" rows="8">${bvo.content}</textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일:</th>
					<c:choose>
						<c:when test="${empty bvo.f_name}">
							<td><b>첨부파일없음</b></td>
						</c:when>
						<c:otherwise>
							<td><a href="bbs_down.do?f_name=${bvo.f_name}">
								<img src="/resources/upload/${bvo.f_name}" style="width: 100px"></a></td>
						</c:otherwise>
					</c:choose>
				</tr>
				
				<tr>
					<td colspan="2">
						<input type="hidden" name="b_idx" value="${bvo.b_idx}">
						<input type="hidden" name="cPage" value="${cPage}">
						<input type="button" value="수정" onclick="bbs_update(this.form)"/>
						<input type="button" value="삭제" onclick="bbs_delete(this.form)"/>
						<input type="button" value="목록" onclick="bbs_list(this.form)"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
	<br><br><br>
	<%-- 댓글 입력 --%>
	<div style="padding: 50px; width: 580px; margin: 0 auto;'">
		<form method="post">
			<fieldset>
				<p>이름 : <input type="text" name="writer"></p>
				<p>내용 <br>
					<textarea rows="4" cols="40" id="content" name="content"></textarea>
				</p>
				<input type="button" value="댓글저장" onclick="comment_insert(this.form)">
				<!-- 댓글 저장 시 어떤 원글의 댓글인지 저장해야 한다. -->
				<input type="hidden" name="b_idx" value="${bvo.b_idx}">
			</fieldset>		
		</form>
	</div>
	
	<%-- 댓글 출력 --%>
	<div style="display: table; margin: 0 auto;">
		<c:forEach var="k" items="${comm_list}">
			<div style="border: 1px solid #cc00cc; width: 400px; margin: 20px; padding: 20px;" >
				<form method="post">
					<p>이름 : ${k.writer}</p>
					<p>내용 : ${k.content}</p>
					<p>날짜 : ${k.write_date.substring(0,10)}</p>
					<!-- 실제는 로그인 성공 && 글쓴사람만 삭제할 수 있어야 한다. -->
					<input type="button" value="댓글삭제" onclick="comment_delete(this.form)">
					<input type="hidden" name="c_idx" value="${k.c_idx}">
					<input type="hidden" name="b_idx" value="${k.b_idx}">
				</form>
			</div>			
		</c:forEach>
	</div>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>	
<script src="resources/js/summernote-lite.js"></script>
<script src="resources/js/lang/summernote-ko-KR.js"></script>
<script type="text/javascript">
	$(function() {
		$("#content").summernote({
			lang: "ko-KR",								// 한글 설정
			height: 300,              		 			// 에디터 높이
			focus: true,               					// 에디터 로딩후 포커스를 맞출지 여부
			placeholder: '최대3000자까지 쓸 수 있습니다', 	// placeholder 설정
			callbacks : {
				onImageUpload :  function(files, editor){
					for (var i = 0; i < files.length; i++) {
						sendImage(files[i], editor);
					}
				}
			}
		});
		$('#content').summernote('disable');
	});
	
	function sendImage(file, editor) {
		var frm = new FormData();
		frm.append("s_file",file);
		$.ajax({
			url : "/saveImg.do",
			data : frm,
			type : "post",
			contentType : false,
			processData : false,
			dataType : "json"
		}).done(function(data) {
			var path = data.path;
			var fname = data.fname;
			$("#content").summernote("editor.insertImage",path+"/"+fname);
		});
	}
</script>	
</body>
</html>


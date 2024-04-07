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
tr {
		
	    text-align:center;
	    padding:4px 10px;
	    background-color: #F6F6F6;
	}
	
th {
		width:120px;
	    text-align:center;
	    padding:4px 10px;
	    background-color: #B2CCFF;
	}
	
	/* summernote toolbar 수정 */
	.note-btn-group{width: auto;}
	.note-toolbar{width: auto;}
</style>

<script type="text/javascript">
	function board_list(f) {
		f.action="board_list.do";
		f.submit();
	}

	function ans_write(f) {
		f.action="ans_write.do";
		f.submit();
	}

	function board_update(f) {
		f.action="board_update.do";
		f.submit();
	}

	function board_delete(f) {
		f.action="board_delete.do";
		f.submit();
	}
</script>
</head>
<body>
	<form method="post">
	
	<table width="700">
	<tbody>
	<tr>
		<th bgcolor="#B2EBF4">제목</th>
		<td>${bovo.title}</td>
	</tr>

	<tr>
		<th bgcolor="#B2EBF4">작성자</th>
		<td>${bovo.writer}</td>
	</tr>
	
	<tr>
		<th bgcolor="#B2EBF4">날짜</th>
		<td>${bovo.regdate.substring(0,10)}</td>
	</tr>
	
	<tr>
		<th bgcolor="#B2EBF4">내용</th>
		<td>
			<%-- <pre>${bovo.content}</pre> --%>
			<textarea rows="10" cols="60" id="content" name="content">${bovo.content}</textarea>
		</td>
	</tr>
	
	<tr>
		<th bgcolor="#B2EBF4">첨부파일</th>
		 <c:choose>
		 	<c:when test="${empty bovo.f_name}">
		 		<td><b>첨부파일없음</b></td>
		 	</c:when>
		 	<c:otherwise>
		 		<td>
		 			<a href="down.do?f_name=${bovo.f_name}"><img src="resources/upload/${bovo.f_name}" style="width: 80px;"></a>
		 		</td>
		 	</c:otherwise>
		 </c:choose>
	</tr>
	</tbody>
	<tfoot>
	<tr>
     <td colspan="2">
     	<input type="hidden" value="${bovo.bo_idx}" name="bo_idx">
     	<input type="hidden" value="${cPage}" name="cPage">
        <input type="button" value="목록" onclick="board_list(this.form)" />
        <input type="button" value="답글" onclick="ans_write(this.form)" />
        <input type="button" value="수정" onclick="board_update(this.form)" />
        <input type="button" value="삭제" onclick="board_delete(this.form)" />
     </td>
	</tr>
	</tfoot>
	</table>
	</form>
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>	
<script src="resources/js/summernote-lite.js"></script>
<script src="resources/js/lang/summernote-ko-KR.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
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
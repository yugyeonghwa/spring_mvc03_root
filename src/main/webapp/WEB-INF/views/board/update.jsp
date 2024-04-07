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

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js" crossorigin="anonymous"></script>
<script type="text/javascript">
	$(document).ready(function() {
		let pwdchk = "${pwdchk}";
		if (pwdchk == 'fail') {
			alert("비밀번호 틀림");
			return;
		}
	});
</script>

<script type="text/javascript">
	function board_list(f) {
		f.action="board_list.do";
		f.submit();
	}

	function board_update_ok(f) {
		for (var i = 0; i < f.elements.length; i++) {
			if (f.elements[i].value == "") {
				if (i == 3 || i == 4)
					continue;
				alert(f.elements[i].name + "를 입력하세요");
				f.elements[i].focus();
				return;//수행 중단
			}
		}
		f.action="board_update_ok.do?f_name=${bovo.f_name}";
		f.submit();
	}
</script>
</head>
<body>
	
	<form method="post" enctype="multipart/form-data">
		<table width="700">
		<tbody>
			<tr>
				<th>작성자</th>
				<td align="left"><input type="text" name="writer" value="${bovo.writer}"></td>
			</tr>
			<tr>
				<th>제목</th>
				<td align="left"> <input type="text" name="title" value="${bovo.title}"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td align="left"><textarea rows="10" cols="60" name="content">${bovo.content}</textarea>
				</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<c:choose>
					<c:when test="${empty bovo.f_name}">
						<td><input type="file" name="file"><b>이전파일없음</b></td>
							<input type="hidden" name="old_f_name" value="">
					</c:when>
					<c:otherwise>
						<td><input type="file" name="file"><b>${bovo.f_name}</b></td>
							<input type="hidden" name="old_f_name" value="${bovo.f_name}">
					</c:otherwise>
				</c:choose>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td align="left"><input type="password" name="pwd"></td>
			</tr>
			<tr>
				<td colspan="2">
				<input type="hidden" name="bo_idx" value="${bovo.bo_idx}">
				<input type="hidden" name="cPage" value="${cPage}">
				<input type="button" value="목록" onclick="board_list(this.form)" /> 
				<input type="button" value="수정" onclick="board_update_ok(this.form)" /> 
				<input type="reset" value="취소" />
				</td>
			</tr>
            </tbody>
		</table>
	</form>
<script src="resources/js/summernote-lite.js"></script>
    	<script src="resources/js/lang/summernote-ko-KR.js"></script>
    	<script type="text/javascript">
    	$(function(){
    		$('#content').summernote({
    			lang : 'ko-KR',
    			height : 300,
    			focus : true,
    			callbacks : {
    				onImageUpload :  function(files, editor){
    					for (var i = 0; i < files.length; i++) {
							sendImage(files[i], editor);
						}
    				}
    			}
			});
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
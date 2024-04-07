<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	function bbs_write_ok(f) {
		f.action="bbs_write_ok.do";
		f.submit();
	}
	
	function bbs_list(f) {
		// location.href="bbs_list.do" 도 가능
		f.action="bbs_list.do";
		f.submit();
	}
</script>
</head>
<body>
	<div id="bbs">
	<form method="post" encType="multipart/form-data">
		<table summary="게시판 글쓰기">
			<caption>게시판 글쓰기</caption>
			<tbody>
				<tr>
					<th>제목:</th>
					<td><input type="text" name="subject" size="45"/></td>
				</tr>
				<tr>
					<th>이름:</th>
					<td><input type="text" name="writer" size="12"/></td>
				</tr>
				<tr>
					<th>내용:</th>
					<td><textarea id="content" name="content" cols="50" rows="8"></textarea></td>
				</tr>
				<tr>
					<th>첨부파일:</th>
					<td><input type="file" name="file_name"/></td>
				</tr>
				<tr>
					<th>비밀번호:</th>
					<td><input type="password" name="pwd" size="12"/></td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="button" value="보내기" onclick="bbs_write_ok(this.form)"/>
						<input type="reset" value="다시"/>
						<input type="button" value="목록" onclick="bbs_list(this.form)"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
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
			placeholder: '최대3000자까지 쓸 수 있습니다',		// placeholder 설정
			callbacks: {
				onImgeUpload : function(files, editor) {
					for (var i = 0; i < files.length; i++) {
						sendImage(files[i], editor)						
					}
				}
			}
		});
	});
	
	function sendImage(file, editor) {
		let frm = new FormData();
		frm.addpend("s_file", file);
		$.ajax({
			url : "saveImg.do",
			data : frm,
			method : "post",
			contentType : false,
			processData : false,
			cache : false,
			dataType : "json"
			// success 와 같음
		}).done(function(data) {
			let path = data.path;
			let fname = data.fname;
			$("#content").summernote("editor.insertImage", path+"/"+fname);
		});
	}
</script>
</body>
</html>


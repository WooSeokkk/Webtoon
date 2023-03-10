<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin_page</title>

<script>

	function send(f){
		
		const title= f.title.value;
		const author = f.author.value;
		const genre = f.genre.value;
		const info = f.info.value;
		const epipath = f.epipath.value;
		const author_idx = 0;
		
		//유효성 체크
		if(title == ''){
		alert("제목은 필수 입니다.");
		return;
		}
		
		f.action="mainToon_insert.do";
		f.method="post";
		f.submit();
		
	}

</script>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
	<link rel="stylesheet" href="/webtoon/resources/css/common.css">
	
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Yeon+Sung&display=swap"
	rel="stylesheet">

</head>
<body>

<div id="total_wrap">


<div id="first">
			<!-- if 문을 위해 var에 check_login 값 설정 -->

			<h1 id="main_title">
				<a href='mainToon.do'> <img
					src="/webtoon/resources/thumbnail/korea_logo.jpg" /> <span>코리아
						웹툰</span>
				</a>
			</h1>


<!-- if 문을 위해 var에 check_login 값 설정 -->
	<c:set var="id" value="${sessionScope.id}" />
<div id="header">
	<c:choose>
		<c:when test="${id eq 'admin' }">
						<input id="logout_btn" type="button" value="로그아웃"
							onclick="location.href='logout.do'">
						<input id="admin_btn" type="button" value="관리자 페이지"
							onclick="location.href='admin_form.do'">
						<input id="Mypage_btn" type="button" value="My 페이지"
							onclick="location.href='Mypage'">
					</c:when>

					<c:when test="${id ne null }">
						<input id="logout_btn" type="button" value="로그아웃"
							onclick="location.href='logout.do'">
						<input id="Mypage_btn" type="button" value="My 페이지"
							onclick="location.href='Mypage'">
					</c:when>

					<c:otherwise>
						<input id="login_btn" type="button" value="로그인"
							onclick="location.href='login_form'">
						<input id="sign_up_btn" type="button" value="회원가입"
							onclick="location.href='sign_up_form'">
					</c:otherwise>
	</c:choose>
</div>
	
	</div>
		
		<hr>
		
		<h1  style="width: 300px; margin: 0 auto;">새 메인웹툰 추가</h1>
 		<!-- if 문을 위해 var에 check_login 값 설정 -->
 	<form method="post" enctype="multipart/form-data">
 	
 		<table border="1" align="center">
		
			<tr>
				<th>작품제목</th>
				<td><input name="title"></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input name="author">
				<!--<input type="number" name="author_idx" >0</td>-->
			</tr>
			<tr>
				<th>파일 이름</th>
				<td><input name="epipath" placeholder="썸네일 파일 이름과 같게"></td>
			</tr>
			<tr>
				<th>장르</th>
				<td>
					<select name="genre">
	
					    <option value="genre_1"  selected> 액션
					
					    <option value="genre_2"> 개그
					
					    <option value="genre_3"> 판타지
	
					</select>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="10" cols="60" name="info"></textarea>
				</td>
			</tr>
			
			<tr>
				<th>썸네일 첨부</th>
				<td><input type="file" name="photo"></td>
			</tr>
			<tr>
				<td style="text-align:center;">
					<input type="button" value="웹툰 업로드" onclick="send(this.form)">
					<input type="button" value="메인화면" onclick="location.href = 'mainToon.do'">
				</td>
			</tr>
			 		
 		</table>
 	
 	</form>
 </div>	
 					<!-- 부트스트랩 JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
		crossorigin="anonymous"></script>
 	
</body>
</html>
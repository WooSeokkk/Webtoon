<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>북마크</title>

<script src="/webtoon/resources/js/httpRequest.js"></script>


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet" href="/webtoon/resources/css/common.css">
<link rel="stylesheet" href="/webtoon/resources/css/myPage.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&family=Yeon+Sung&display=swap"
	rel="stylesheet">


<script>

	// '즐겨찾기 삭제' 버튼 클릭시 호출
	function send(f){
		
		var ref = f.webtoon_idx.value;
		var user_id = f.user_id.value;
		
		var url = "addBookmark.do";
		var param = "ref="+ref+
					"&user_id="+user_id;

		sendRequest( url, param, resultFn, "POST");
	
		alert("삭제되었습니다.");
		window.location.reload();
	}
	
	function resultFn(){
			
			if( xhr.readyState == 4 && xhr.status == 200 ){
				
				var bookmark = xhr.responseText;
				
				if( bookmark == 'no'){
					return;
				}
				
			}
			
			
	}
</script>
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

		<div id="page_name" style="text-align: center; margin: 20px 0;">
			<h1 style="margin: 50px 0;">즐겨찾기</h1>
		</div>
		<div class="container text-center tab_2">
			<div class="row">
				<c:forEach var="bm" items="${bm}">
					<div class="col-4 mt_box">
						<div class="wrap">
							<a href="show?idx=${ bm.webtoon_idx }"> <!-- 첨부된 이미지가 있는 경우에만 img태그를 보여주자! -->
								<c:if test="${bm.filename ne 'no_file'}">
									<img src="/webtoon/resources/upload/${bm.filename}"
										width="100%" class="box-con" />
								</c:if>

								<p style="font-size: 1.5em; font-weight: bold;">
									<span class="author">${ bm.author }</span>&nbsp;/&nbsp; <span
										class="title">${ bm.title }</span>
								</p>
							</a>
							<form>
								<input type="hidden" name="user_id" value="${user}"> <input
									type="hidden" name="webtoon_idx" value="${bm.webtoon_idx}">
								<input type="button" value="즐겨찾기 삭제" onclick="send(this.form);" >
							</form>
						</div>
					</div>
				</c:forEach>
			</div>
			<input type="button" value="홈으로" onclick="location.href='list.do'" style="margin-top:30px; width:100px;">
		</div>



		<!-- 부트스트랩 JS -->
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
			integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
			crossorigin="anonymous"></script>


	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="/webtoon/resources/css/sign_up_email.css">
<!-- Ajax사용을 위한 js를 추가 -->
<script src="/webtoon/resources/js/httpRequest.js"></script>
<!-- 이메일을 합치기 위해 끌어오는 jquery문 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>


<script>
	var check = false;
	function send(f) {
		var id = f.id.value;
		var pwd = f.pwd.value;
		var name = f.name.value;
		var user_email = f.user_email.value;
		var email_address = f.email_address.value;
		const email = user_email + '@' + email_address;
		if (check == false) {
			alert("아이디 중복체크를 하세요");
			return;
		}
		if (id == '') {
			alert("아이디를 입력하세요");
			return;
		}
		if (pwd == '') {
			alert("비밀번호를 입력하세요");
			return;
		}
		if (name == '') {
			alert("이름은 필수입니다.");
			return;
		}
		if (user_email == '' || email_address == '') {
			alert("이메일은 필수입니다.");
			return;
		}
		//Ajax로 ID와 PWD를 전달
		var url = "sign_check.do";
		var param = "id=" + id + "&pwd=" + pwd + "&name=" + name + "&email="
				+ email;
		sendRequest(url, param, resultFn, "POST");
	}
	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			//"{'result':'clear'}"
			var data = xhr.responseText;
			//서버에서 넘어온 데이터를 실제 JSON형식으로 변환
			var json = (new Function('return'+data))();
			if (json.result == 'no_id') {
				alert("아이디가 존재하지 않습니다");
				return;
			} else if (json.result == 'no_pwd') {
				alert("비밀번호 불일치");
				return;
			}
			location.href = "certifiacion_form";
		}
	}
	function dupli_check(f) {
		var id = f.id.value;
		if (id == '') {
			alert("아이디를 입력하세요");
			return;
		}
		//Ajax로 ID와 PWD를 전달
		var url = "login_check.do";
		var param = "id=" + id;
		sendRequest(url, param, resultFn2, "POST");
	}
	function resultFn2() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			//"{'result':'clear'}"
			var data = xhr.responseText;
			//서버에서 넘어온 데이터를 실제 JSON형식으로 변환
			var json = (new Function('return' + data))();
			if (json.result == 'no_pwd') {
				alert("아이디가 존재합니다.");
				check = false;
				return;
			} else {
				alert("이용가능한 아이디입니다.");
				check = true;
				document.getElementById('idBox').readOnly = true;
				return;
			}
		}
	}
</script>
</head>
<body>
<h2 id="sign_up_email_title" style= "font-size:50px; color:#2B2B2B;text-align:center;">이메일 인증</h2>

	<form id="sign_up_email">
		<table>
			<tr>
				<td><input id="idBox" name="id"class="text-field" placeholder="아이디"></td>
				<td><input type="button" value="중복체크"
					onclick="dupli_check(this.form)"></td>
			</tr>

			<tr>
				<td><input type="password" name="pwd"class="text-field" placeholder="비밀번호"></td>
			</tr>

			<tr>
				<td><input name="name"class="text-field" placeholder="이름"></td>
			</tr>

			<tr>
				<td><input type="text" class="text-field" placeholder="e-mail" name="user_email" required><span>@</span>
					<input type="text" class="text-field" name="email_address" list="user_email_address">
					<datalist id="user_email_address">
						<option value="naver.com"></option>
						<option value="daum.com"></option>
						<option value="google.com"></option>
						<option value="직접입력"></option>
					</datalist> <input type="hidden" name="email" value=""></td>
			</tr>


			<tr>
				<td colspan="2" align="center"><input type="button"
					value="회원가입"  id=join_btn onclick="send(this.form);" /></td>
			</tr>
		</table>
	</form>
</body>
</html>
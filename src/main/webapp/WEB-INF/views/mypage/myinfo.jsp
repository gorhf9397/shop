<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<style>
section {
	width: 500px;
	height: 500px;
	margin: auto;
	position:relative;
}

section h2 {
	margin-top: 90px;
}

section #aa {
	width: 120px;
	height: 30px;
	display: inline-block;
}

section div {
	font-size: 15px;
	margin-top: 17px;
}

section input[type=button] {
	width: 158px;
	height: 46px;
	border: 1px solid #D941C5;
	background: #D941C5;
	color: white;
	font-size: 20px;
}

section #pwdform {
	position:absolute;
	left:150px;
	top:20px;
	visibility:hidden;
	width:200px;
	height:250px;
	background:white;
	border:1px solid lightgreen;
	text-align:center;
}
</style>
<script>
	function change_pwd() {
		document.getElementById("pwdform").style.visibility="visible";
	}
	var pchk=0;
	function check_pwd(pwd2) { // 바꿀비밀번호의 2개가 일치하는지 체크
		var pwd=document.pchg.pwd.value;
		if(pwd==pwd2) {
			document.getElementById("pmsg").innerText="비밀번호가 일치합니다";
			document.getElementById("pmsg").style.color="blue";
			pchk=1;
		} else {
			document.getElementById("pmsg").innerText="비밀번호가 틀립니다";
			document.getElementById("pmsg").style.color="red";
			pchk=0;
		}
	}
	//비밀번호 변경 버튼이 클릭되었을때 체크해야 될 내용
	//1.기존 비밀번호의 입력여부 =>빈칸체크
	//2.새 비밀번호가 1자 이상	=>빈칸체크
	//3.새 비밀번호 2개가 같은지
	function check(my) {
		if(my.prepwd.value.trim().length == 0) {
			alert("기존 비밀번호를 입력하세요");
			return false;
		} else if(my.pwd.value.trim().length == 0) {
			alert("새 비밀번호를 입력하세요")
			return false;
		}else if(pchk == 0) {
			alert("비밀번호는 일치하여야 합니다");
			return false;	
		}else {
			return true;
		}
	}
</script>
</head>
<body>
	<section>
		<h2 align="center">회원정보</h2>
		<div>
			<span id="aa">아이디</span> ${mvo.userid}
		</div>
		<div>
			<span id="aa">이름</span> ${mvo.name}
		</div>
		<div>
			<span id="aa">우편번호</span> ${mvo.zip}
		</div>
		<div>
			<span id="aa">주소</span> ${mvo.juso} ${mvo.juso_etc}
		</div>
		<div>
			<span id="aa">전화</span> ${mvo.phone}
		</div>
		<div>
			<span id="aa">이메일</span> ${mvo.email}
		</div>
		<div align="center">
			<input type="button" value="정보수정" onclick="location='myinfo_edit'">
			<input type="button" value="비밀번호 변경" onclick="change_pwd()">
			<input type="button" value="회원탈퇴" onclick="location='member_out'">
		</div>
		<div id="pwdform"> <!-- 비밀번호 변경 폼 -->
			<form name="pchg" method="post" action="change_pwd" onsubmit="return check(this)">
				<h3>비밀번호 변경</h3>
				<div><input type="password" name="prepwd" placeholder="이전 비밀번호"></div>
				<div><input type="password" name="pwd" placeholder="변경 비밀번호"></div>
				<div><input type="password" name="pwd2" placeholder="변경 비밀번호 롹인" onkeyup="check_pwd(this.value)"></div>
				<div id="pmsg" style="font-size:12px;]"></div>
				<div><input type="submit" value="비밀번호변경"></div>
			</form>
		</div>
	</section>
</body>
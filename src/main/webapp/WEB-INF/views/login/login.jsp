<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<head>
<style>
section {
	width: 1000px;
	height: 600px;
	margin: auto;
	text-align: center;
}

section input[type=text] {
	width: 300px;
	height: 40px;
	border: 1px solid black;
}

section h2 {
	margin-top:80px;
}

section div {
	margin-top: 15px;
}

section #usearch {
	width: 140px;
	height: 46px;
	margin-top:10px;
	border: 1px solid black;
	background: black;
	color: white;
}

section #psearch {
	width: 140px;
	height: 46px;
	margin-top:10px;
	border: 1px solid black;
	background: black;
	color: white;
}

section input[type=password] {
	width: 300px;
	height: 40px;
	border: 1px solid black;
}

section input[type=submit] , input[type=button]{
	width: 308px;
	height: 46px;
	border: 1px solid black;
	background: black;
	color: white;
}

#userid_search,#pwd_search {
	display:none;
}
</style>
<script>
	function view_us() {
		document.getElementById("pwd_search").style.display="none";
		document.getElementById("view_pwd").innerText="";
		document.pwd_search.userid.value="";
		document.pwd_search.name.value="";
		document.pwd_search.email.value="";
		document.getElementById("userid_search").style.display="block";
	}
	
	function userid_search_fn() {
		var name=document.userid_search.name.value;
		var email=document.userid_search.email.value;
		console.log(name+" "+email);
		var us=new XMLHttpRequest();
		us.open("get","userid_search_ok?name="+name+"&email="+email);
		us.send();
		us.onreadystatechange=function() {
			if(us.readyState==4) {
				if(us.responseText=="0") {
					alert("이름 혹은 이메일이 틀립니다.");
				} else {
					var imsi=us.responseText.trim();
					document.getElementById("userid_search").style.display="none";
					document.getElementById("view_userid").innerText="당신의 아이디는"+imsi+" 입니다";
				}
			}
		}
	}
	
	function view_ps() {
		document.getElementById("userid_search").style.display="none";
		document.getElementById("view_userid").innrtText="";
		document.userid_search.name.value="";
		document.userid_search.email.value="";
		document.getElementById("pwd_search").style.display="block";
	}
	
	function pwd_search_fn() {
		var userid=document.pwd_search.userid.value;
		var name=document.pwd_search.name.value;
		var email=document.pwd_search.email.value;
		var ps=new XMLHttpRequest();
		ps.open("get","pwd_search_ok?userid="+userid+"&name="+name+"&email="+email);
		ps.send();
		ps.onreadystatechange=function() {
			if(ps.readyState==4) {
				if(ps.responseText=="0") {
					alert("아이디 또는 이름 또는 이메일이 틀립니다.");
				} else {
					var imsi=ps.responseText.trim();
					document.getElementById("pwd_search").style.display="none";
					document.getElementById("view_pwd").innerText="비밀번호는 "+imsi+" 입니다";
				}
			}
		}
	}
</script>
</head>
<body>
	<section>
		<form method="post" action="login_ok">
		<h2>로그인</h2>
			<div>
				<input type="text" name="userid" placeholder="아이디">
			</div>
			<div>
				<input type="password" name="pwd" placeholder="비밀번호">
			</div>
			<c:if test="${err == 1}">
				<br>
				<span style="color:red; font-size:12px;">아이디 또는 비밀번호가 틀렷습니다</span>
			</c:if>
			<div>
				<input type="submit" value="로그인">
			</div>
				<input type="button" onclick="view_us()" id="usearch" value="아이디 찾기">
				<input type="button" onclick="view_ps()" id="psearch" value="비밀번호 찾기">
		</form>
		
		<div id="view_userid"></div>
		<form name="userid_search" id="userid_search">
			<input type="text" name="name" placeholder="이름"><p>
			<input type="text" name="email" placeholder="이메일"><p>
			<input type="button" value="아이디찾기" onclick="userid_search_fn()">
		</form>
		
		<div id="view_pwd"></div>
		<form name="pwd_search" id="pwd_search">
			<input type="text" name="userid" placeholder="아이디"><p>
			<input type="text" name="name" placeholder="이름"><p>
			<input type="text" name="email" placeholder="이메일"><p>
			<input type="button" value="비밀번호찾기" onclick="pwd_search_fn()">
		</form>
	</section>
</body>
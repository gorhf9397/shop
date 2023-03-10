<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="decorator"
	uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
body {
	margin: 0px;
}

#message {
	width: 1000px;
	height: 29px;
	background: lightgreen;
	margin: auto;
	color: white;
}

#message #left {
	float: left;
	width: 980px;
	text-align: center;
	padding-top: 4px;
}

#message #right {
	float: right;
	width: 20px;
	padding-top: 4px;
}

header {
	width: 1000px;
	height: 40px;
	margin: auto;
}

header #left {
	float: left;
	padding-top: 10px;
}

header #right {
	float: right;
	padding-top: 10px;
	position: relative;
}

header #right #cu ul {
	position: absolute;
	left: 73px;
	top: 18px;
	border: 1px solid #cccccc;
	padding-left: 0px;
	padding: 5px;
	display: none;
	background: white;
}

header #right #cu ul li {
	list-style-type: none;
	height: 24px;
}

header a {
	text-decoration: none;
	color: black;
	display: inline-block;
	height: 30px;
}

header #myinfo {
	   position:absolute;
       top:20px;
      left:-10px;
      padding-left:0px;
      border:1px solid #cccccc;
      background:white;
      padding:5px;
      display:none;
}

header #myinfo li {
	list-style-type:none;
	width:100px;
	height:25px;
	text-align:center;
}

nav {
	width: 1000px;
	height: 40px;
	margin: auto;
}

nav .menu {
	
}

nav .menu>li { /* 메뉴의 li */
	list-style-type: none;
	display: inline-block;
	width: 130px;
	height: 30px;
	font-size: 17px;
	text-align: center;
}

nav .menu>li:first-child { /* 메뉴의 li중에 첫번째 */
	position: relative;
}

nav .dae { /* 대분류 메뉴 */
	position: absolute;
	left: 17px;
	top: 26px;
	padding-left: 0px;
	border: 1px solid #cccccc;
	background: white;
	display: none;
}

nav .dae>li { /* 대분류 메뉴내의 li */
	list-style-type: none;
	width: 82px;
	height: 28px;
	text-align: center;
	/*   background:red; */
	padding: 5px;
}
/* 중분류 관련 */
nav .dae>li { /* 대분류 메뉴 */
	position: relative;
}

nav .dae .jung { /* 중분류 ul태그 */
	position: absolute;
	top: -1px;
	left: 92px;
	padding-left: 0px;
	background: white;
	border: 1px solid #cccccc;
	display: none;
}

nav .dae .jung>li { /* 중분류 메뉴 */
	list-style-type: none;
	width: 82px;
	height: 28px;
	padding: 5px;
}
/*소분류 관련 */
nav .dae .jung>li {
	position: relative;
}

nav .dae .jung .so { /* 소분류 ul 태그 */
	position: absolute;
	left: 92px;
	top: -1px;
	padding-left: 0px;
	background: white;
	border: 1px solid #cccccc;
	display: none;
}

nav .dae .jung .so li { /* 소분류 메뉴 */
	list-style-type: none;
	width: 82px;
	height: 28px;
	padding: 5px;
}

/* 검색창 만들기 */
nav .menu #outer {
	width: 220px;
	border: 1px solid #cccccc;
	padding: 2px;
	border-radius: 20px;
}

nav .menu>li:last-child {
	width: 220px;
}

nav .menu>li input[type=text] {
	width: 150px;
	border: none;
	outline: none;
	font-size: 16px;
}
/* 검색창 만들기 끝 */
footer {
	width: 1000px;
	height: 100px;
	background: #D941C5;
	margin: auto;
}
</style>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>
$(function(){
	$("#message #right").click(function(){
		$("#message").slideUp(600);
	});
	
	$("#cu").mouseover(function(){
		$("header #right #cu ul").show();
	});
	
	$("#cu").mouseout(function(){
		$("header #right #cu ul").hide();
	});
	
	$("nav #cate").mouseover(function(){
		$("nav .dae").slideDown(700);
	});
	
	$("nav #cate").mouseout(function(){
		$("nav .dae").slideUp(700);
	});
	
	//중분류메뉴 보이기
	$("nav .dae > li").mouseover(function(){	//농산물, 수산물, 축산물, 가공품에 마우스가 올라오면
		var n=$(this).index();
		$("nav .jung").eq(n).show();
	});
	$("nav .dae > li").mouseout(function(){	//농산물, 수산물, 축산물, 가공품에 마우스가 내려가면
		var n=$(this).index();
		$("nav .jung").eq(n).hide();
	});
	
	//소분류메뉴 보이기
	$("nav .jung > li").mouseover(function(){
		var n=$(this).index();
		$("nav .so").eq(n).show();
	});
	$("nav .jung > li").mouseout(function(){
		var n=$(this).index();
		$("nav .so").eq(n).hide();
	});
	//회원정보 보이기
	$("header #my").mouseover(function(){
		$("header #myinfo").show();
	});
	$("header #my").mouseout(function(){
		$("header #myinfo").hide();
	});
});
</script>
<decorator:head />
</head>
<body>
	<!-- index.jsp -->
	<div id="message">
		<div id="left">회원가입 이벤트 : 어떤상품이든 100원에 구매 가능</div>
		<div id="right">X</div>
	</div>
	<!-- 간단메시지 -->
	<header> <!-- 로고, 로그인,회원가입 -->
	<div id="left"><a href="../main/index">SSS샵</a></div>
	<div id="right">
	<c:if test="${userid == null}">
		<a href="../login/login">로그인</a> 
		<a href="../member/memberinput">회원가입</a>
	</c:if>
	<c:if test="${userid != null}">
		<span id="my" style="display:inline-block; height:34px;">${name}님
			<ul id="myinfo">
				<li><a href="../mypage/myinfo">회원정보수정</a></li>
				<li><a href="../mypage/myjumun">주문조회</a></li>
				<li>적립금조회</li>
				<li><a href="../mypage/myreview">나의글확인</a></li>
				<li><a href="../mypage/wish">wish</a></li>
				<li><a href="../mypage/cart">장바구니</a></li>
			</ul>
		</span>
		<a href="../login/logout">로그아웃</a>
	</c:if>
		<a href="#" id="cu">고객센터
			<ul>
				<li>자주하는질문</li>
				<li onclick="location='../member/clist'" style="cursor:pointer;">1:1 상담</li>
				<li>긴급 상담</li>
			</ul>
		</a>
	</div>
	</header>
	<nav> <!-- 메뉴및 링크 -->
	<ul class="menu">
		<li id="cate">카테고리
			<ul class="dae">
				<li><a href="../product/pro_list?pcode=p01">농산물</a>
					<ul class="jung">
						<li><a href="../product/pro_list?pcode=p0101">야채류</a>
							<ul class="so">
								<li><a href="../product/pro_list?pcode=p010101">쌈채소</a></li>
								<li><a href="../product/pro_list?pcode=p010102">뿌리채소</a></li>
								<li><a href="../product/pro_list?pcode=p010103">열매채소</a></li>
							</ul>
						</li>
						<li>과일류
							<ul class="so">
								<li>수입과일</li>
								<li>국산과일</li>
								<li>통조림</li>
							</ul>
						</li>
						<li>쌀,잡곡
							<ul class="so">
								<li>햅쌀</li>
								<li>잡곡</li>
								<li>수입</li>
							</ul>
						</li>
					</ul>
				</li>
				<li>수산물
					<ul class="jung">
						<li>생선</li>
						<li>해조류</li>
						<li>횟 감</li>
					</ul>
				</li>
				<li>축산물
					<ul class="jung">
						<li>소고기</li>
						<li>돼지고기</li>
						<li>닭,오리</li>
					</ul>
				</li>
				<li>가공품
					<ul class="jung">
						<li>건조식품</li>
						<li>통조림</li>
						<li>절임식품</li>
					</ul>
				</li>
			</ul>
		</li>
		<li>신상품</li>
		<li>베스트</li>
		<li>특가상품</li>
		<li>이벤트</li>
		<li>
			<div id="outer">
				<input type="text" id="search" name="search"> <img
					src="../resources/simg/ss.png" width="24" valign="middle">
			</div>
		</li>
	</ul>
	</nav>
	<decorator:body />
	<!-- 사이트 관련 정보 -->
	<footer> 쇼핑몰 관련 정보 </footer>
</body>
</html>
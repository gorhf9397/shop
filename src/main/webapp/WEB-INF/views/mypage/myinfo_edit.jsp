<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<style>
section {
	width: 1000px;
	height: 700px;
	margin: auto;
	text-align: center;
}

section input[type=text] {
	width: 300px;
	height: 40px;
	border: 1px solid black;
}

section input[type=password] {
	width: 300px;
	height: 40px;
	border: 1px solid black;
}

section div {
	margin-top: 10px;
}

section #zip {
	width: 154px;
	height: 40px;
}

section #btn1 {
	width: 140px;
	height: 40px;
	border: 1px solid black;
	background: black;
	color: white;
}

section #btn2 {
	width: 306px;
	height: 44px;
	border: 1px solid black;
	background: black;
	color: white;
}
</style>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function juso_search() // 우편번호 버튼 클릭시 호출 함수명
	{
		new daum.Postcode({
			oncomplete : function(data) {
				if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
					addr = data.roadAddress;
				} else { // 사용자가 지번 주소를 선택했을 경우(J)
					addr = data.jibunAddress;
				}

				// 우편번호와 주소 정보를 해당 필드에 넣는다.
				document.suk.zip.value = data.zonecode; // 우편번호
				document.suk.juso.value = addr; // 주소
				// 커서를 상세주소 필드로 이동한다.
				document.suk.juso_etc.focus();
			}
		}).open();
	}
	function check(my) { //필수입력 :아이디 6자이상 , 이름 , 비번, 전번
		if(my.name.value.trim().length==0) {
			alert("이름을 입력하세요");
			return false;
		} else if(my.phone.value.trim().length==0) {
			alert("전화번호를 입력하세요");
			return false;
		} else if(my.email.value.trim().length==0) {
			alert("이메일을 입력하세요")
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
	<section>
		<form name="suk" method="post" action="myinfo_edit_ok" onsubmit="return check(this)">
			<div>
				<div> 아이디 : ${mvo.userid} </div>
			</div>
			<div>
				<input type="text" name="name" placeholder="이름" value="${mvo.name}">
			</div>
			<div>
				<input type="text" name="zip" id="zip" readonly placeholder="우편번호" value="${mvo.zip}">
				<input type="button" value="주소검색" id="btn1" onclick="juso_search()">
			</div>
			<div>
				<input type="text" name="juso" readonly placeholder="주소" value="${mvo.juso }">
			</div>
			<div>
				<input type="text" name="juso_etc" placeholder="상세주소" value="${mvo.juso_etc }">
			</div>
			<div>
				<input type="text" name="phone" placeholder="전화번호" value="${mvo.phone }">
			</div>
			<div>
				<input type="text" name="email" placeholder="이메일" value="${mvo.email}">
			</div>
			<div>
				<input type="submit" value="정보수정" id="btn2">
			</div>
		</form>
	</section>
</body>
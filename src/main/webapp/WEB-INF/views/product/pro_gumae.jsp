<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<head>
<style>
   section {
     width:1000px;
     height:1300px;
     margin:auto;
   }
   section .sub {
     display:none;
     height:60px;
   }
   section table {
     border-top:2px solid #cccccc;
     border-bottom:1px solid #cccccc;
     padding:10px;
     margin-top:30px;
     
   }
   section table td {
     font-family:돋움;
     font-size:14px;
     height:24px;
   }
   section caption {
     text-align:left;
   }
   section #bae_table .bb {
     font-size:12px;
     font-weight:100;
     display:inline-block;
     width:80px;
     height:20px;
     border:1px solid blue;
     padding-top:2px;
     text-align:center;
     cursor:pointer;
   }
   section .submit {
     text-align:center;
     margin-top:40px;
   }
   section input[type=submit] {
     width:200px;
     height:35px;
     border:1px solid #D941C5;
     background:#D941C5;
     color:white;
     font-size:16px; 
   }
 </style>
	<script>
		function bae_chuga() {
			var chk=new XMLHttpRequest();
			chk.onload=function() {
				//alert(chk.responseText);
				var bb=chk.responseText.split(",");
				document.getElementById("bname").innerText=decodeURI(bb[0]);
				document.getElementById("bjuso").innerText=decodeURI(bb[1]);
				document.getElementById("bphone").innerText=bb[2];
				
				//회원정보이용 추가후 회원정보이용 문구 안보이게하기
				document.getElementById("mem_use").style.display="none";
			}
			chk.open("get","bae_chuga");
			chk.send();
		}
		
		function bae_change() {
			open("baesong_list", "", "width=300px,height=400"); // 주소(문서), 프레임이름, 창의설정
		}
		
		function change_sub(n) {
			var sub=document.getElementsByClassName("sub");
			var len=sub.length;
			for(i=0;i<len;i++) {
				sub[i].style.display="none";
			}
			sub[n].style.display="table-row";
		}
	</script>
</head>
<body>
	<section>
		<!-- 구매상품정보 -->
	<form method="post" action="pro_gumae_ok">
	<input type="hidden" name="gchk" value="${gchk}">
		<table width="900" align="center">
		<caption> <h3> 구 매 정 보 </h3></caption>
			<tr>
				<th>상품</th>
				<th>상품명</th>
				<th>단가</th>
				<th>구매수량</th>
				<th>적립금</th>
				<th>할인액</th>
				<th>총 결제금액</th>
			</tr>
			<c:set var="chongprice" value ="0"/>
			<c:set var="chonghalin" value ="0"/>
			<c:set var="chongbaesong" value ="0"/>
			<c:set var="chongjuk" value ="0"/>
			<c:set var="cpcode" value =""/>
			<c:set var="csu" value =""/>
			<c:set var="cchong" value =""/>
		<c:forEach items="${list}" var="pvo">
			<tr align="center">
				<td><img src="../resources/img/${pvo.pimg }" width="80" height="80"></td>	<!-- 상품그림 -->
				<td>${pvo.title }</td>	<!-- 상품명 -->
				<td><fmt:formatNumber value="${pvo.price }"/></td>	<!-- 단가 -->
				<td>${pvo.su}</td>	<!-- 수량 -->
				<td><fmt:formatNumber value="${pvo.juk*pvo.su}"/></td>	<!-- 적립금 -->
				<td><fmt:formatNumber value="${pvo.price*(pvo.halin/100)*pvo.su}" pattern="#,###"/>원</td>	<!-- 할인액 -->
				<td><fmt:formatNumber value="${(pvo.price*pvo.su)-(pvo.price*(pvo.halin/100)*pvo.su)}" pattern="#,###"/>원</td>	<!-- 총결제금액 -->
			</tr>
			<c:set var="chongprice" value ="${chongprice+(pvo.price*pvo.su)}"/>
			<c:set var="chonghalin" value ="${chonghalin+(pvo.price*(pvo.halin/100)*pvo.su)}"/>
			<c:set var="chongbaesong" value ="${chongbaesong+pvo.baesong}"/>
			<c:set var="chongjuk" value ="${chongjuk+(pvo.juk*su)}"/>
			
			<c:set var="cimsi" value="${Integer((pvo.price*pvo.su)-(pvo.price*(pvo.halin/100)*pvo.su)+pvo.baesong)}"/>
			
			<c:set var="cpcode" value="${cpcode+=pvo.pcode+=','}"/>
     		<c:set var="csu" value="${csu+=pvo.su+=','}"/>
    		<c:set var="cchong" value="${cchong+=cimsi+=','}"/>
		</c:forEach>
			<c:set var="chongpay" value="${chongprice-chonghalin+chongbaesong }"/>
		</table>
		<input type="hidden" name="pcode" value="${cpcode}">
		<input type="hidden" name="su_imsi" value="${csu}">
   		<input type="hidden" name="bae_id" value="${bvo.id}">
   		<input type="hidden" name="chong_imsi" value="${cchong}">
        <!-- 결제금액 -->
		<!-- 구매자정보 -->
		<table width="900" align="center">
			<caption> <h3> 구매자 정보 </h3> </caption>
			<tr>
				<th width="150">이름</th>
				<td>${mvo.name }</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>${mvo.email }</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${mvo.phone }</td>
			</tr>
		</table>
		<!-- 배송지정보 -->
		<table width="900" align="center">
			<caption><h2 id="bh3">배송지정보</h2>
				<c:if test="${empty bvo}">
					<span class="bb" onclick="bae_chuga()" id="mem_use">회원정보이용</span>
				</c:if>
				<c:if test="${!empty bvo }">
					<span class="bb" onclick="bae_change()">배송지 변경</span>
				</c:if>
			</caption>
			<tr>
				<th>받는사람</th>
				<td id="bname">${bvo.name}</td>
			</tr>
			<tr>
				<th>배송주소</th>
				<td id="bjuso">${bvo.juso} ${bvo.juso_etc}</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td id="bphone">${bvo.phone}</td>
			</tr>
				<c:if test="${bvo.chuga == 0}">
			      <c:set var="chuga" value="문 앞"/>
			    </c:if>
			    <c:if test="${bvo.chuga == 1}">
			      <c:set var="chuga" value="직접받고 부재시 문 앞"/>
			    </c:if>
			    <c:if test="${bvo.chuga == 2}">
			      <c:set var="chuga" value="경비실"/>
			    </c:if>
			    <c:if test="${bvo.chuga == 3}">
			      <c:set var="chuga" value="택배함"/>
			    </c:if>
			<tr>
				<th>요청사항</th>
				<td id="bchuga">${chuga}</td>
			</tr>
		</table>
		<!-- 결제관련 -->
		<table width="900" align="center" border="0">
			<caption><h3>결제 정보</h3></caption>
			<tr>
				<th width="150">상품금액</th>
				<td><fmt:formatNumber value="${chongprice}" pattern=",###"/>원</td>
			</tr>
			<tr>
				<th>할인금액</th>
				<td><fmt:formatNumber value="${chonghalin}" pattern=",###"/>원</td>
			</tr>
			<tr>
				<th>배송비</th>
				<td><fmt:formatNumber value="${chongbaesong}"/></td>
			</tr>
			<tr>
				<th>총 결제금액</th>
				<td><fmt:formatNumber value="${chongpay}" pattern="#,###"/>원</td>
			</tr>
			<tr>
				<th>적립금</th>
				<td><fmt:formatNumber value="${chongjuk}"/></td>
			</tr>
			<tr>
				<th>결제정보</th>
				<td>
					<input type="radio" name="sudan" value="0" checked onclick="change_sub(0)">계좌이체
					<input type="radio" name="sudan" value="1" onclick="change_sub(1)">신용/체크카드
					<input type="radio" name="sudan" value="2" onclick="change_sub(2)">휴대폰
				</td>
			</tr>
			<tr class="sub" style="display:table-row;"><!-- 계좌이체 -->
				<th>*은행선택</th>
				<td>
					<select name="bank">
						<option value="-1">선택</option>
						<option value="0">국민은행</option>
						<option value="1">농협은행</option>
						<option value="2">하나은행</option>
						<option value="3">기업은행</option>
						<option value="4">우리은행</option>
						<option value="5">신협은행</option>
					</select>
				</td>
			</tr>
			<tr class="sub"><!-- 카드 -->
				<th>*카드선택</th>
				<td>
					<select name="card">
						<option value="-1">선택</option>
						<option value="0">국민카드</option>
						<option value="1">농협카드</option>
						<option value="2">하나카드</option>
						<option value="3">기업카드</option>
						<option value="4">우리카드</option>
						<option value="5">신협카드</option>
					</select>
					*할부
					<select name="gigan">
						<option value="-1">선택</option>
						<option value="0">2개월</option>
						<option value="1">3개월</option>
						<option value="2">4개월</option>
						<option value="3">5개월</option>
						<option value="4">6개월(무이자)</option>
						<option value="5">7개월</option>
					</select>
				</td>
			</tr>
			<tr class="sub"><!-- 휴대폰 -->
				<th>*통신사종류</th>
				<td>
					<select name="phone">
						<option value="-1">선택</option>
						<option value="0"> SKT </option>
				        <option value="1"> KT </option>
				        <option value="2"> LG </option>
				        <option value="3"> 그 외 </option>
					</select>
				</td>
			</tr>
		</table>
		<div class="submit"><input type="submit" value="구매하기"></div>
	</form>
	</section>
</body>
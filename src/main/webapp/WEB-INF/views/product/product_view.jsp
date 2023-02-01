<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<head>
	<style>
		section {
			width:1000px;
			height:700px;
			margin:auto;
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
	</style>
</head>
<body>
	<section>
		<!-- 상품정보 -->
		<table width="900" align="center">
			<caption><h3>구매상품정보</h3></caption>
			<c:set var="chong" value="0"/>
			<c:forEach items="${list}" var="pvo">
				<tr>
					<td>
						<img src="../resources/img/${pvo.pimg}" width="80">
					</td>
					<td>${pvo.title }</td>
					<td>${pvo.su }개</td>
					<td><fmt:formatNumber value="${pvo.price }" pattern="#,###"/>(개당)</td>
				</tr>
			<c:set var="chong" value="${chong+pvo.chong}"/>
			</c:forEach>
		</table>
		
		<c:set var="pvo" value="${list.get(0)}"/>
		
		<!-- 배송지정보 -->
		<table width="900" align="center">
			<caption><h2>배송지 정보</h2></caption>
			<tr>
				<td width="150">받는사람</td>
				<td>${pvo.name}</td>
			</tr>
			<tr>
				<td width="150">전화번호</td>
				<td>${pvo.hphone}</td>
			</tr>
			<tr>
				<td width="150">배송주소</td>
				<td>${pvo.juso} ${pvo.juso_etc}</td>
			</tr>
				<c:if test="${pvo.chuga == 0}">
			      <c:set var="chuga" value="문 앞"/>
			    </c:if>
			    <c:if test="${pvo.chuga == 1}">
			      <c:set var="chuga" value="직접받고 부재시 문 앞"/>
			    </c:if>
			    <c:if test="${pvo.chuga == 2}">
			      <c:set var="chuga" value="경비실"/>
			    </c:if>
			    <c:if test="${pvo.chuga == 3}">
			      <c:set var="chuga" value="택배함"/>
			    </c:if>
			<tr>
				<td width="150">요청사항</td>
				<td>${chuga}</td>
			</tr>
		</table>
		<!-- 상세정보 -->
		<table width="900" align="center">
			<caption><h3>결제정보</h3></caption>
			<c:if test="${pvo.sudan == 0}">
				<c:set var="sudan" value="계좌이체"/>
			</c:if>
			<c:if test="${pvo.sudan == 1}">
				<c:set var="sudan" value="신용/체크카드"/>
			</c:if>
			<c:if test="${pvo.sudan == 2}">
				<c:set var="sudan" value="휴대폰결제"/>
			</c:if>
			<tr>
				<td width="150">결제수단</td>
				<td>${sudan}</td>
			</tr>
			<tr>
				<td width="150">총결제금액</td>
				<td><fmt:formatNumber value="${pvo.chong}" pattern="#,###"/>원</td>
			</tr>
		</table>
	</section>
</body>
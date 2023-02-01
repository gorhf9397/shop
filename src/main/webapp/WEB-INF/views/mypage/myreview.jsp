<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<head>
	<style>
	section {
     width:1000px;
     margin:auto;
     margin-top:70px;
     margin-bottom:80px;
   }
   
   section table caption {
     text-align:left;
   }
   section table th {
     border-top:2px solid #cccccc;
     border-bottom:1px solid #cccccc;
   }
   section table td {
     border-bottom:1px solid #cccccc;
   }
	</style>
</head>
<body>
	<section>
		<table width="900" align="center">
			<caption><h2>나의 상품평</h2></caption>
			<tr>
				<td>상품</td>
				<td>상품코드</td>
				<td>별점</td>
				<td>한줄평</td>
				<td>구입일자</td>
				<td>수정/삭제</td>
			</tr>
		<c:forEach items="${rlist}" var="rvo">
			<tr>
				<td>
					${rvo.ptitle}
					<img src="../resources/img/${rvo.pimg}" width="50" height="50">
				</td>
				<td>${rvo.pcode}</td>
				<td>
					<c:forEach begin="1" end="${rvo.star}">
		            	<img src="../resources/main/star1.png" width="15">
		            </c:forEach>
		            <c:forEach begin="1" end="${5-rvo.star}">
		            	<img src="../resources/main/star2.png" width="15">
		            </c:forEach>
	            </td>
				<td>${rvo.title }</td>
				<td>${rvo.writeday}</td>
				<td>
					<input type="button" value="수정하기" onclick="location='review_update?id=${rvo.id}'">
					<input type="button" value="삭제하기" onclick="location='review_del?id=${rvo.id}&gid=${rvo.gid}'">
				</td>
			</tr>
		</c:forEach>
		</table>
	</section>
</body>
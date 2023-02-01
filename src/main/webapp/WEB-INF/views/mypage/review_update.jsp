<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
section {
	width: 1000px;
	height: 500px;
	margin: auto;
	margin-top: 60px;
}

section input[type=text] {
	width: 500px;
	height: 30px;
}

section textarea {
	width: 500px;
	height: 200px;
}

section input[type=submit] {
	width: 200px;
	height: 30px;
	border: 1px solid #D941C5;
	background: white;
	color: #D941C5;
}

section table {
	border-spacing: 17px;
}
</style>
<script>
	function change_star(n) // n이 클릭된 star의 index
	{
		var len = document.getElementsByClassName("star").length;

		// n보다 같거나 작은것은 노란색 별
		for (i = 0; i <= n; i++) {
			document.getElementsByClassName("star")[i].src = "../resources/main/star1.png";
		}

		// n+1보다 큰것은 회색별
		for (i = n + 1; i < len; i++) {
			document.getElementsByClassName("star")[i].src = "../resources/main/star2.png";
		}

		document.review.star.value = n + 1;
	}
</script>
</head>
<body>
	<section>
	<form name="review" method="post" action="review_update_ok">
		<input type="hidden" name="id" value="${rvo.id }">
		<input type="hidden" name="star" value="${rvo.star}">
		<table width="700" align="center">
			<caption>
				<h3>상품평 쓰기</h3>
			</caption>
			<tr>
				<td>한줄요약</td>
				<td><input type="text" name="title" value="${rvo.title}">
				</td>
			</tr>
			<tr>
				<td>상세리뷰</td>
				<td><textarea name="content" cols="30" rows="4">${rvo.content}</textarea>
				</td>
			</tr>
			<tr>
				<td>별 점</td>
				<td>
					<c:forEach begin="1" end="${rvo.star}" varStatus="my">
		            	<img src="../resources/main/star1.png" width="15" class="star" onclick="change_star(${my.index-1})">
		            </c:forEach>
		            <c:forEach begin="1" end="${5-rvo.star}" varStatus="my">
		            	<img src="../resources/main/star2.png" width="15" class="star" onclick="change_star(${my.index+rvo.star-1})">
		            </c:forEach>
				<!-- index: begin의 숫자부터 시작, count는 1부터시작 -->
				
				<p>
				
		           <%-- 
		            <c:set var="i" value="0"/>
		            <c:forEach begin="1" end="${rvo.star}">
		             <img src="../resources/main/star1.png" width="15" class="star" onclick="change_star(${i})">
		             <c:set var="i" value="${i+1}"/>
		            </c:forEach>
		            <c:forEach begin="1" end="${5-rvo.star}" varStatus="my">
		             <img src="../resources/main/star2.png" width="15" class="star" onclick="change_star(${i})">
		             <c:set var="i" value="${i+1}"/>
		            </c:forEach> 
		          --%>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><input type="submit"
					value="리뷰수정"></td>
			</tr>
		</table>
	</form>
	</section>
</body>
</html>
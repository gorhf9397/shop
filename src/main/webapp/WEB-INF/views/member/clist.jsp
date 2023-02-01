<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<style>
	section {
     width:1000px;
     height:500px;
     margin:auto;
     margin-top:60px;
   }
   section tr:first-child td {
     border-top:2px solid #cccccc;
   }
   section td {
     border-bottom:1px solid #cccccc;
     height:40px;
   }
   section tr:last-child td {
     border-bottom:2px solid #cccccc;
   }
   </style>
</head>
<body>
	<section>
		<table width="700" align="center">
		<caption><h3>나의 상담 목록</h3></caption>
			<tr align="center">
				<td>상담제목</td>
				<td>상담날짜</td>
				<td>답변여부</td>
			</tr>
			<c:forEach items="${clist}" var="cvo">
				<tr align="center">
					<td><a href="ccontent?id=${cvo.id}">${cvo.title }</a></td>
					<td>${cvo.writeday }</td>
					<td>
						<c:if test="${cvo.cnt == 0}">
       					 	답변 미작성
         				</c:if>
         				<c:if test="${cvo.cnt == 1}">
							답변 완료
         				</c:if>
					</td>
				</tr>
			</c:forEach>
			<tr>
				<td colspan="2" align="right">
					<a href="cwrite">글쓰기</a>
				</td>
			</tr>
		</table>
	</section>
</body>
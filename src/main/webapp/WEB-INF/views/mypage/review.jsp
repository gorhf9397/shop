<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
	<style>
		section {
      width:1000px;
      height:500px;
      margin:auto;
      margin-top:60px;
    }
    section input[type=text] {
      width:500px;
      height:30px;
    }
    section textarea {
      width:500px;
      height:200px;
    }
    section input[type=submit] {
      width:200px;
      height:30px;
    }
    section td {
      /* border-spacing:10px; */
    }
	</style>
	<script>
		function change_star(n) {// n이 클릭된 star index
			var len=document.getElementsByClassName("star").length;
			
			// n보다 같거나 작은것은 노란색 별
			for(i=0;i<=n;i++) {
				document.getElementsByClassName("star")[i].src="../resources/main/star1.png";
			}
			// n+1보다 큰것은 회색별
			for(i=n+1;i<len;i++) {
				document.getElementsByClassName("star")[i].src="../resources//main/star2.png";
			}
			document.review.star.value=n+1;
		}
	</script>
</head>
<body>
	<section>
	<form name="review" method="post" action="review_ok">
	<input type="hidden" name="pcode" value="${pcode}">
	<input type="hidden" name="star" value="1">
	<input type="hidden" name="gid" value="${gid}">
									<!-- gumae테이블 id -->
	<caption> <h3> 상품평 쓰기 </h3></caption>
		<table width="900" align="center" cellspacing="17">
			<tr>
				<td>한줄요약</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>상세리부</td>
				<td><textarea name="content" cols="30" rows="4"></textarea></td>
			</tr>
			<tr>
				<td>별점</td>
				<td>
					<img alt="별점" src="../resources/main/star1.png" class="star" onclick="change_star(0)"> <!-- index:0 -->
					<img alt="별점" src="../resources/main/star2.png" class="star" onclick="change_star(1)"> <!-- index:1 -->
					<img alt="별점" src="../resources/main/star2.png" class="star" onclick="change_star(2)"> <!-- index:2 -->
					<img alt="별점" src="../resources/main/star2.png" class="star" onclick="change_star(3)"> <!-- index:3 -->
					<img alt="별점" src="../resources/main/star2.png" class="star" onclick="change_star(4)"> <!-- index:4 -->
				</td>
			</tr>
			<tr>
				<td><input type="submit" value="작성"></td>
			</tr>
		</table>
	</form>
	</section>
</body>
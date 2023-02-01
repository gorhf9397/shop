<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function getjung(daecode) {
		var chk=new XMLHttpRequest();
		chk.open("get", "getjung?daecode="+daecode);
		chk.send();
		chk.onreadystatechange=function() {
			if(chk.readyState==4){
				//alert(chk.responseText);
				var jung=decodeURI(chk.responseText.trim());
				jung="<option> 선택 </option>"+jung;
				document.inpro.jung.innerHTML=jung;
			}
		}
	}
	function getso(jung) {
		var dae=document.inpro.dae.value;
		var daejung=dae+jung;
		//alert(daejung);
		var suk=new XMLHttpRequest();
		suk.open("get", "getso?daejung="+daejung);
		suk.send();
		suk.onreadystatechange=function(){
			if(suk.readyState==4){
				document.inpro.so.innerHTML=decodeURI(suk.responseText.trim());
			}
		}
	}
	function bunho() {
		// 대,중,소 의 value값을 가져와서 연결하기
		var dae = document.inpro.dae.value;
		var jung = document.inpro.jung.value;
		var so = document.inpro.so.value;
		var code = "p"+dae+jung+so;
		
		var chk=new XMLHttpRequest();
		chk.open("get", "getbunho?code="+code);
		chk.send();
		chk.onreadystatechange=function(){
			if(chk.readyState==4){
				//alert(chk.responseText);
				var bunho=parseInt(chk.responseText)+1;
				//alert(bunho);
				//bunho의 값을 3자리로 변경
				bunho=bunho+""; //String(bunho) , bunho.toString();
				if(bunho.length==1) {
					bunho="00"+bunho;
				} else if(bunho.length==2) {
					bunho="0"+bunho;
				}
				//p 대 중 소 bunho를 연결한다
				document.inpro.pcode.value=code+bunho;
			}
		}
	}
</script>
</head>
<body><!-- pro_write.jsp : 상품 입력 폼 -->
<form name="inpro" enctype="multipart/form-data" method="post" action="product_ok">
	<table width="600" align="center">
		<caption><h2>상품 등록</h2></caption>
		<tr>
			<th>상품 코드</th>
			<td><input type="text" name="pcode" readonly></td>
			<td> <!-- 대,중,소 에 해당하는 상품코드 -->
				<select name="dae" onchange="getjung(this.value)"> <!-- this.value를 써서 선택된 value를 가져온다 -->
					<option>선택</option>
					<c:forEach items="${list}" var="dvo">
						<option value="${dvo.code}">${dvo.title}</option>
					</c:forEach>
				</select>
				<select name="jung"  onchange="getso(this.value)">
				
				</select>
				<select name="so">
				
				</select>
				<input type="button" onclick="bunho()" value="상품코드 생성">
			</td>
		</tr>
		<tr>
			<th>상품메인 이미지</th>
			<td colspan="2"><input type="file" name="pimg"></td>
		</tr>
		<tr>
			<th>상품상세 이미지</th>
			<td colspan="2"><input type="file" name="cimg"></td>
		</tr>
		<tr>
			<th>상품제목</th>
			<td colspan="2"><input type="text" name="title"></td>
		</tr>
		<tr>
			<th>상품가격</th>
			<td colspan="2"><input type="text" name="price"></td>
		</tr>
		<tr>
			<th>상품 제조사</th>
			<td colspan="2"><input type="text" name="made"></td>
		</tr>
		<tr>
			<th>상품 할인율</th>
			<td colspan="2"><input type="text" name="halin" value="0"></td>
		</tr>
		<tr>
			<th>적립금</th>
			<td colspan="2"><input type="text" name="juk"></td>
		</tr>
		<tr>
			<th>상품수량</th>
			<td colspan="2"><input type="text" name="su"></td>
		</tr>
		<tr>
			<th>배송비</th>
			<td colspan="2"><input type="text" name="baesong" value="0"></td>
		</tr>
		<tr>
			<th>배송일</th>
			<td colspan="2"><input type="text" name="baeday" value="2"></td>
		</tr>
		<tr>
			<td colspan="3" align=right>
				<input type="submit" value="등록하기">
			</td>
		</tr>
	</table>
</form>
</body>
</html>
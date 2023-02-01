<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<style>
		section {
      width:1000px;
      margin:auto;
      margin-top:70px;
    }
    section #a1 {
      width:1000px;
      height:500px;
    }
    section #a1 #left {
      width:500px;
      height:500px;
      float:left;
      text-align:center;
    }
    section #a1 #right {
      width:500px;
      height:500px;
      float:right;
    }
    section #right div {
      margin-top:28px;
    }
    section #right div:first-child {
      margin-top:0px;
    }
    section #right #title {
      font-size:24px;
    }
    section #right #price {
      font-size:20px;
      color:red;
      font-weight:900;
    }
    section #right #juk {
      color:blue;
    }
    section #right #bae {
      font-size:20px;
      
    }
    section #right #su #spinner {
      width:140px;
      outline:none;  /* input type="text" 의 외곽선밖 없애기 */
    }
    section #right #etc .btn { /* span태그 wish,cart,바로구매 */
      width:100px;
      height:30px;
      border:1px solid #cccccc;
      display:inline-block;
      padding-top:5px;
      text-align:center;
      cursor:pointer;
    }
    section #a2 {
      clear:both; /* float기능 해제 */
      width:1000px;
      margin-bottom:30px;
      margin-top:50px;
    }
    
    section #review {
      width:1000px;
      /* height:500px; */
      margin-bottom:30px;
      margin-top:20px;
    }
    section #review .pers div {
      padding-top:5px; /* 사용자별 상품평의 div 태그의 간격 조절 */
    }
    section #inq {
      width:1000px;
      margin-bottom:30px;
      margin-top:20px;
    }
    section #an {
      width:1000px;
      margin-bottom:30px;
      margin-top:20px;
    }
    section #cart_msg {
      position:absolute;
      visibility:hidden;
      width:150px;
      height:80px;
      border:1px solid #cccccc;
      background:white;
      padding-top:22px;
      padding-left:22px;
    }
    section #pcmenu {
        width:1000px;
        height:60px;
        margin:auto;
        position:relative;
      }
      section #pcmenu ul {
        padding-left:0px;
      }
      section #pcmenu ul li {
        list-style-type:none;
        display:inline-block;
        width:243px;
        height:38px;
        text-align:center;
        border:1px solid #cccccc;
        border-top:3px solid #cccccc;
        padding-top:12px;
        margin-left:0px;
        border-right:none;
        background:#f7f7f7;
        cursor:pointer;
       }
      section #pcmenu ul li:last-child {
        border-right:1px solid #cccccc;
      }
      section #pcmenu ul li:first-child {
        background:white;
        border-bottom:none;
      }
      section #qlayer {
        position:absolute;
        visibility:hidden;
        width:440px;
        height:250px;
        border:1px solid #cccccc;
        background:white;    
      }
      section article {
        border-top:2px solid #cccccc;
        margin-top:30px;
      }
      section #qq {
       border:1px solid #888888;
       background:#888888;
       color:white;
      }
      section #qq2 {
       border:1px solid blue;
       background:blue;
       color:white;
      }
	</style>
	<script src="http://code.jquery.com/jquery-latest.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script>
	    $(function()
	    {
	    	 $("#spinner").spinner(
	    	 {
	    		 min:1,
	    		 max:10,
	    		 spin:function(e,ui) {	/* 아래위로 가는버튼 클릭시 실행 */
	    			 var total=parseInt(${pvo.price - (pvo.price*(pvo.halin/100))}*ui.value);
	    			 							/* 할인금액을 뺀 상품금액 * 수량 */
	    			 total=new Intl.NumberFormat().format(total); /* 자바스크립트에 넣기 */
	    			 document.getElementById("tot").innerText=total+"원";
	    			 
	    			 /* 적립금 변경 */
	    			 var juk_tot=parseInt(${pvo.juk}*ui.value);
	    			 juk_tot=new Intl.NumberFormat().format(juk_tot);
	    			 document.getElementById("juk_in").innerText=juk_tot+"원";
	    		 }
	    	 });
	    });
	    
	    function wish_add() { /* 사용자 아이디,상품코드를 wish테이블에 저장 */
	    	if(confirm("wish테이블에 상품을 추가할까요?")) {
	    		var chk=new XMLHttpRequest();
		    	chk.onload=function() {
		    		//alert(chk.responseText);
		    		if(chk.responseText=="0") {
		    			alert("wish테이블에저장")
		    		}else {
		    			alert("내부 오류발생");
		    		}
		    	}
		    	chk.open("get","wish_add?pcode=${pvo.pcode}");
		    	chk.send();
	    	}
	    }
	    function cart_add() {	/* 사용자 아이디,상품코드를 cart테이블에 저장 */
	    	var x=event.clientX-100;
	    	var y=event.clientY-100;
	    	var chk=new XMLHttpRequest();
	    	var su=document.pro.su.value;
	    	chk.onload=function() {
	    		if(chk.responseText=="0") {
	    			document.getElementById("cart_msg").style.left=x+"px";
	    			document.getElementById("cart_msg").style.top=y+"px";
	    			document.getElementById("cart_msg").style.visibility="visible";
	    			/* if(confirm("장바구니로 이동하시겟습니까?"))
	    				location="../product/cart_view"; */
	    		} else {
	    			alert("내부 오류");
	    		}
	    	}
	    	chk.open("get","cart_add?pcode=${pvo.pcode}&su="+su);
	    	chk.send();
	    }
	    
	    function pro_submit() {
	    	document.pro.submit()
	    }
	    
	    /* pcmenu부분 스크립트 처리 */
	    function change_sub(n) {
	    	var pcsub=document.getElementsByClassName("pcsub");
	    	var len=pcsub.length;
	    	for(i=0;i<len;i++) {
	    		pcsub[i].style.background="#f7f7f7";
	    		pcsub[i].style.borderBottom="1px solid #cccccc";
	    	}
	    	pcsub[n].style.background="white";
	    	pcsub[n].style.borderBottom="none";
	    }
	   	/* 컨텐츠 스크롤시 상단 메뉴따라다니게하는 스크립트처리 */
	    function pcmenu_stop() {// 스크롤이 특정값이 될 경우 #pcmenu를 position:fixed로 변경
	    	var top=document.documentElement.scrollTop;
	    	if(top>710) {
	    		document.getElementById("pcmenu").style.position="fixed";
	    		document.getElementById("pcmenu").style.top="-17px";
	    	} else {
	    		document.getElementById("pcmenu").style.position="relative";
	    	}
	    }
	    window.onscroll=pcmenu_stop;
	    /* pcmenu부분 스크립트 처리 종료*/
	    function qwrite(){
    	 document.getElementById("qlayer").style.visibility="visible";
    	 position_chg();
     }
     function position_chg() { // 브라우즈의 중앙에 레이어를 위치 시키기위한 좌표
    	 var x=innerWidth;  // 브라우저 가로
    	 var y=innerHeight; // 브라우저 세로
    	 var left=(x/2)-220;
    	 var top=(y/2)-125+document.documentElement.scrollTop;
    	 
    	 document.getElementById("qlayer").style.left=left+"px";
    	 document.getElementById("qlayer").style.top=top+"px";
     }
     window.onresize=position_chg; // 브라우저의 크기를 바꿀때마다 실행
    </script>
</head>
<body>
	<section>
		<form name="pro" method="post" action="pro_gumae">
		<input type="hidden" name="gchk" value="0">
		<input type="hidden" name="pcode" value="${pvo.pcode}">
			<article id="a1">
				<div id="left"><img src="../resources/img/${pvo.pimg }" width="400"></div>
				<div id="right">
					<div id="title">${pvo.title}</div>	<!-- 상품명 -->
					<div id="star"></div>	<!-- 별점 -->
					<div id="price">	<!-- 가격 -->
						<c:if test="${pvo.halin != 0}"> <!-- 할인율이 0이 아닌경우 -->
				           ${pvo.halin}% <br>
				           <s> <fmt:formatNumber value="${pvo.price}"/>원 </s> <br>
				           <span id="tot"><fmt:formatNumber value="${ pvo.price - ( pvo.price*(pvo.halin/100) )  }" pattern=",000"/>원</span>
						</c:if>
				        <c:if test="${pvo.halin == 0}"> <!-- 할인율이 0인 경우 -->
				        	<span id="tot"><fmt:formatNumber value="${pvo.price}"/>원</span>
						</c:if>
					</div>
					<div id="juk">	<!-- 적립금 -->
						적립금 : <span id="juk_in"><fmt:formatNumber value="${pvo.juk}"/>원</span>
					</div>
					<c:choose>
						<c:when test="${pvo.yoil == 1}">
					        <c:set var="yo" value="일요일"/>
					    </c:when>
					    <c:when test="${pvo.yoil == 2}">
					        <c:set var="yo" value="월요일"/>
					    </c:when>
					    <c:when test="${pvo.yoil == 3}">
					        <c:set var="yo" value="화요일"/>
					    </c:when>
					    <c:when test="${pvo.yoil == 4}">
					        <c:set var="yo" value="수요일"/>
					    </c:when>
					    <c:when test="${pvo.yoil == 5}">
					       	<c:set var="yo" value="목요일"/>
					    </c:when>
					    <c:when test="${pvo.yoil == 6}">
					        <c:set var="yo" value="금요일"/>
					    </c:when>
					    <c:when test="${pvo.yoil == 7}">
					    	<c:set var="yo" value="토요일"/>
					    </c:when>
					</c:choose>	
					<div id="bae">	<!-- 배송일정 -->
						${pvo.baeday2}
						${yo} 도착예정
					</div>
					<div id="made">${pvo.made }</div>	<!-- 제조사 -->
					<div id="su">
						<input type="text" id="spinner" name="su" value="1" readonly>
					</div>
					<div id="etc">	<!-- 수량,위시,장바구니,구매 -->
						<c:if test="${userid !=null }">
							<c:if test="${wishcnt==0 }">
								<span class="btn" onclick="wish_add()">wish</span>
							</c:if>
							<c:if test="${wishcnt == 1}"> <!-- wish테이블에 존재하는 경우 -->
            					<span class="btn" onclick="location='wish_cancel?pcode=${pvo.pcode}'"> wish취소 </span>
           					</c:if>
						</c:if>
						<c:if test="${userid == null }">
							<span class="btn" onclick="alert('로그인 해야함')">wish</span>
						</c:if>
						<!-- 장바구니관련 -->
						<c:if test="${userid !=null }">
							<span class="btn" onclick="cart_add()">장바구니</span>
						</c:if>
						<c:if test="${userid == null }">
							<span class="btn" onclick="alert('로그인 해야함')">장바구니</span>
						</c:if>
						<span class="btn" onclick="pro_submit()">바로구매</span>
					</div>
				</div>
			</article>
		</form>
			<div id="pcmenu">
				<ul>
					<li class="pcsub" onclick="change_sub(0)"><a href="#a2">상품상세</a></li><li class="pcsub" onclick="change_sub(1)"><a href="#review">상품평</a></li><li class="pcsub" onclick="change_sub(2)"><a href="#inq">상품문의</a></li><li class="pcsub" onclick="change_sub(3)"><a href="#an">배송/교환/반품안내</a></li>
				</ul>
			</div>
			
		<article id="a2">
			<img src="../resources/img/${pvo.cimg }" width="1000">
		</article>
		
		<article id="review">	<!-- 상품평 -->
			<h3>상품평</h3>
			<div class="pers">
				<c:forEach begin="1" end="${chong_star}">
					<img alt="별점" src="../resources/main/star1.png">
				</c:forEach>
				<c:forEach begin="1" end="${5-chong_star}">
					<img alt="흑별점" src="../resources/main/star2.png">
				</c:forEach>
				
				<!-- 사용자별 상품평 출력하기 -->
         <c:forEach items="${rlist}" var="rvo">
          <div style="margin-top:30px;"> ${fn:substring(rvo.userid,0,4)}** </div>
          <%-- ${fn:substring(rvo.userid,0,4} --%>
          <div> 
            <c:forEach begin="1" end="${rvo.star}">
             <img src="../resources/main/star1.png" width="15">
            </c:forEach>
            <c:forEach begin="1" end="${5-rvo.star}">
             <img src="../resources/main/star2.png" width="15">
            </c:forEach>
            
          </div>
          <div> ${rvo.title}</div>
          <div> ${rvo.content}</div>
          <p>
         </c:forEach>
			</div>
		</article>
		<article id="inq">	<!-- 상품문의 -->
			<h2 align="left">상품문의	<span style="font-size:13px;" onclick="qwrite()">문의하기</span></h2>
				<table width="1000" align="center" cellspacint="0">
					<c:forEach items="${qlist}" var="qvo">
						<tr>
							<td>
								<c:if test="${qvo.seq==1 }">
									<span id="qq">질문</span>
								</c:if>
								<c:if test="${qvo.seq==2}">
									<span id="qq2">답변</span>
								</c:if>
								${qvo.email }
							</td>
							<td>${qvo.writeday }</td>
						</tr>
						<tr>
							<td colspan="2">${qvo.ptitle}</td>
						</tr>
						<tr>
							<td colspan="2" style="border-bottom:1px solid #cccccc">${qvo.content}</td>
						</tr>
					</c:forEach>
				</table>
		</article>
		<article id="an">	<!-- 배송/교환/안내 -->
			<h2 align="left"> 배송/교환/안내 </h2>
    	<table width="1000" align="center">
      		<caption> <h3> 배송 정보 </h3></caption>
      			<tr>
			        <td> 배송방법 </td>
			        <td> 신선/냉장/냉동 </td>
			        <td rowspan="2"> 배송비 </td>
			        <td rowspan="2"> </td>
	      		</tr>
	      		<tr>
			        <td> 배송사 </td>
			        <td> CH 택배 </td>
		      	</tr>
	    </table>
	    <table width="1000" align="center">
	      <caption> <h3> 교환/반품안내 </h3> </caption>
 			<tr>
        		<td> 교환/반품 비용 </td>
	        	<td> 4,000원 <br> -단, 고객 변심의 경우에만 발생 <br> -도서산간 지역 배송불가 
	      	</tr>
	      	<tr>
	        	<td> 교환/반품 신청기준일 </td>
	        	<td>
			            ㆍ단순변심에 의한 교환/반품은 제품 수령 후 7일 이내까지, 교환/반품 제한사항에 해당하지 않는 경우에만 가능 (배송비용과 교환/반품 비용 왕복배송비 고객부담)
			
			           ㆍ상품의 내용이 표시·광고의 내용과 다른 경우에는 상품을 수령한 날부터 3개월 이내, 그 사실을 안 날 또는 알 수 있었던 날부터
			        30일 이내에 청약철회 가능
	        	</td>
	      	</tr>
	    </table>
		</article>
		
		<div id="cart_msg">
			장바구니로 이동 <p>
			<input type="button" value="이동" onclick="location='../mypage/cart'">
			<input type="button" value="계속쇼핑" onclick="document.getElementById('cart_msg').style.visibility='hidden'">
		</div>
		
		<div id="qlayer">
		<form method="post" action="qwrite_ok">
		<input type="hidden" name="pcode" value="${pvo.pcode}">
		<input type="hidden" name="seq" value="1">
			<table width="500" align="center">
				<caption><h3>상품문의</h3></caption>
				<tr>
					<td>상품정보</td>
					<td><input type="text" name="ptitle" value="${pvo.title }" readonly style="border:noneloutline:none;font-size:15px;"></td>
				</tr>
				<tr>
					<td>문의내용</td>
					<td><textarea cols="30" rows="6" name="content"></textarea></td>
				</tr>
				<tr>
					<td align="center" colspan="2">
						<input type="submit" value="문의작성">
						<input type="button" value="취소">
					</td> 
				</tr>
			</table>
		</form>
		</div>
	</section>
</body>
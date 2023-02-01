<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
	<style>
		section {
     width:1000px;
     height:500px;
     margin:auto;
     text-align:center;
     margin-top:60px;
   }
   section input[type=text] {
     width:400px;
     height:30px;
     outline:none;
   }
   section textarea {
     width:400px;
     height:200px;
     margin-top:20px;
   }
   section input[type=submit] {
     width:408px;
     height:34px; 
     margin-top:20px;
     background:#FFD9FA;
     border:1px solid #FFD9FA;
   }
		}
	</style>
</head>
<body>
	<section>
		<form method="post" action="cwrite_ok">
			<h2 align="center"> 1:1 상담하기</h2>
			<div><input type="text" name="title" placeholder="제목"></div>
			<div><textarea cols="40" rows="6" name="content" placeholder="상담내용"></textarea></div>
			<div><input type="submit" value="저장하기"></div>
		</form>
	</section>
</body>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>할 일 등록 화면(쓰기)</title>
	<style type="text/css">

	header{
		margin-top: 50px;
		margin-left: 800px;
	}

	section{
		margin-top: 20px;
		margin-left: 800px;	
	}

	#beforeBtn{
		background-color: #FFFFFF;
		outline: 0;
	}
		
	#sumitAction input{
			background-color: #00BFFF;
			color: #FFFFFF;
			outline: 0;
			border: 0;
			width: 100px;
			height: 30px;
	}

	.btn{
			background-color: #FFFFFF;
			outline: 0;
			width: 100px;
			height: 30px;
			margin-right: 70px;
	}

	</style>
</head>
<body>
<header id="headText"><span style="font-size: 30px; font-weight: bold;">할일 등록</span></header>
<section>
	<form action="TodoAddServlet" method="post">
		<span>어떤일인가요?</span><br>
		<input type="text" name="registerTodo" maxlength="24" required="이 입력란을 작성하세요" placeholder="swift 공부하기(24까지)" style="width: 300px; height: 20px"><br><br>
		<span>누가 할일인가요?</span><br>
		<input type="text" name="registerName" placeholder="홍길동"  required="이 입력란을 작성하세요" style="width: 200px; height: 20px" ><br><br>
		<span>우선순위를 선택하세요</span><br>
		<input type="radio" name="registerSequence" value="1">1순위
		<input type="radio" name="registerSequence" value="2">2순위
		<input type="radio" name="registerSequence" value="3">3순위<br><br>

		<div id="sumitAction">
			<button type="button" class="btn" onclick="window.history.back();">&lt;이전</button>
			<input type="submit" name="name" value="제출">
			<input type="reset" onclick="" value="내용지우기">	
		</div>
	</form>
	
</section>
</body>
</html>
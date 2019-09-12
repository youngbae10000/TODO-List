<%@page import="kr.or.connect.dao.TodoDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.or.connect.dto.TodoDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>할 일 목록 화면(리스트)</title>
<style type="text/css">
#newRegisterBtn {
	background-color: #00BFFF;
	color: #FFFFFF;
	outline: 0;
	border: 0;
	width: 150px;
	height: 30px;
	margin-left: 1350px;
}

#todoText {
	color: #045FB4;
	font-size: 30px;
	transform: rotate(-20deg);
	width: 240px;
	font-weight: bold;
}

article {
	display: block;
}

#TODO {
	margin-left: 200px;
	width: 400px;
	height: 700px;
	float: left;
}

#DOING {
	margin-left: 40px;
	width: 400px;
	height: 700px;
	float: left;
}

#DONE {
	margin-left: 40px;
	width: 400px;
	height: 700px;
	float: left;
}

#topIndex {
	padding-top: 20px;
	padding-left: 20px;
	height: 60px;
	width: 400px;
	font-size: 30px;
	color: #FFFFFF;
	text-align: left;
	background-color: #0B4C5F;
}

.taskBox {
	margin-top: 10px;
	padding-top: 20px;
	padding-left: 20px;
	height: 70px;
	width: 400px;
	background-color: #A9E2F3;
	line-height: 1.1em;
}
</style>
</head>
<body>
	<header>
		<button type="button" id="newRegisterBtn"
			onClick="location.href='todoRegister.jsp'">새로운 TODO등록</button>
	</header>
	<section>
		<div id="todoText">
			<span>나의 해야할 일들</span>
		</div>
		<article id="TODO">
			<div id="topIndex">TODO</div>
		</article>
		<article id="DOING">
			<div id="topIndex">DOING</div>
		</article>
		<article id="DONE">
			<div id="topIndex">DONE</div>
		</article>
	</section>

	<script type="text/javascript">
	
	function ajax(id, obj){
		
		var taskDivDom = document.getElementById(id);
		var parentDom = taskDivDom.parentElement;
		var sendDataType = parentDom.id;
		var sendDataId = id;
		
		var params = {
				method: 'post',
				url: "TodoTypeServlet",
				header : ['Content-type','application/json;'],
				data : JSON.stringify({
					'id' : sendDataId,
					'type' : sendDataType	
				})
		};
		var oReq = new XMLHttpRequest();
		
		oReq.addEventListener("success", function() {
			console.log(this.responseText);
		});
		
		oReq.open(params.method, params.url);
		oReq.setRequestHeader(params.header[0],params.header[1]);
		
		oReq.send(params.data);
		
		if(sendDataType == "TODO"){
			var doingDiv = document.querySelector("#DOING");
			var nextParent = document.getElementById("DOING");
			parentDom.removeChild(taskDivDom);
			nextParent.appendChild(taskDivDom);
		}
		else if(sendDataType == "DOING"){
			var doneDiv = document.querySelector("#DONE");
			var nextParent = document.getElementById("DONE");
			parentDom.removeChild(taskDivDom);
			taskDivDom.removeChild(obj);
			nextParent.appendChild(taskDivDom);
		}
	}
	
		function drawing(id, name, regdate, sequence, title, type){
		
		if(type.id != "undefined"){
			var obj = document.getElementById(type.id);
			var newDiv = document.createElement("div");
			newDiv.setAttribute("class","taskBox");
			newDiv.setAttribute("id",id);
			var output = "";
			
			output += '<span type="text" style="font-size: 23px;">'+title+'</span><br><br>';
			output += '<span type="text" style="font-size: 17px;">등록날짜'+regdate+', '+name+', 우선순위 '+sequence+' </span>';
			
			if(type != DONE){
				output += '<input type="button" value="→" id="execute" onclick="ajax('+id+', this);" style="height : 20px; width: 30px;"></input>';	
			}
			
			newDiv.innerHTML = output;
			obj.appendChild(newDiv);	
		}
	}
		
	</script>

	<%
		ArrayList<TodoDto> list = (ArrayList<TodoDto>) request.getAttribute("list");
		if (list != null) {
			for (TodoDto dto : list) {
				pageContext.setAttribute("id",dto.getId());
				pageContext.setAttribute("name",dto.getName());
				pageContext.setAttribute("regdate",dto.getRegdate().substring(0,10));
				pageContext.setAttribute("sequence", dto.getSequence());
				pageContext.setAttribute("title",dto.getTitle());
				pageContext.setAttribute("type",dto.getType());
				
	%>
	<script>		
			drawing(${id},"${name}","${regdate}",${sequence},"${title}",${type});
	</script>
	<%
			}
		}
	%>
</body>
</html>

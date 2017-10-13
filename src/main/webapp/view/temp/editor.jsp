<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../import/tag.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../import/jscss.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		var demo = $("#demo").val();
		var reg=new RegExp("\r\n","g");
		demo= demo.replace(reg,"<br>");
		$("#demo").val(demo);
		
		//保存的时候把<br>去掉
		$("#ff").form({
			onSubmit:function(){
				var custom = $("#custom").val();
				var reg=new RegExp("<br>","g");
				custom= custom.replace(reg,"\r\n");
				$("#custom").val(custom);
			}
		});
	});
</script>
</head>
<body>
	<form id="ff" method="post" action="${ctx }/temp/save">
		<input type="hidden" name="name" value="${name }"></input>
		<textarea id="demo" name="demo"  style="width:500px;height:1000px;overflow:scroll;resize:none;">${demo }</textarea> 
		<textarea id="custom" name="custom"  style="width:500px;height:1000px;overflow:scroll;resize:none;">${custom }</textarea>
	</form>
</body>
</html>
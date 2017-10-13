<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="../import/tag.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<jsp:include page="../import/jscss.jsp"></jsp:include>
</head>
<body>
	<form id="ff" method="post" action="${ctx }/conf/save">
		<div>
			<label for="name">name:</label> <input class="easyui-textbox"
				type="text" name="name" data-options="width:400" value="${dto.name }" />
		</div>
		<div>
			<label for="driver">driver:</label> 
			<input id="driver" class="easyui-combobox" name="driver" value="${dto.driver }"   
    data-options="valueField:'id',textField:'text',data:[{id:'com.mysql.jdbc.Driver',text:'com.mysql.jdbc.Driver'},
    {id:'com.microsoft.sqlserver.jdbc.SQLServerDriver',text:'com.microsoft.sqlserver.jdbc.SQLServerDriver'}],width:400" />  
		</div>
		<dir>
			<label for="url">url:</label> <input class="easyui-textbox"
				type="text" name="url" data-options="width:400" value="${dto.url }"/>
		</dir>
		<div>
			<label for="username">username:</label> <input class="easyui-textbox"
				type="text" name="username" data-options="width:400" value="${dto.username }" />
		</div>
		<div>
			<label for="password">password:</label> <input class="easyui-textbox"
				type="text" name="password" data-options="width:400" value="${dto.password }" />
		</div>
	</form>
</body>
</html>
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
	var conndata=null;
	$(document).ready(function(){
		$("#conn").combobox({
			onSelect:function(record){
				//console.log(record);
				conndata=record;//记录下数据库连接地址
				$.post("${ctx}/build/gettables",record,function(data){
					$("#tables").combobox('loadData',data);
				});
			}
		});
		$('#btn').bind('click', function(){    
			var table = $("#tables").combobox('getValue');
			conndata.tablename =table;
			//console.log(conndata);
			//$.post("${ctx}/build/action",conndata);
			
			$('#ff').form({      
				queryParams:conndata    
			});    
			// submit the form    
			$('#ff').submit();  
	    }); 
	});
</script>
</head>
<body>
	<jsp:include page="../import/navbar.jsp"></jsp:include>
	<div class="container-fluid">
		<div class="row">
		  <div class="col-md-1">数据库连接</div>
		  <div class="col-md-11">
		  	<input id="conn" class="easyui-combobox" name="conn"   
    			data-options="valueField:'url',textField:'url',url:'${ctx }/conf/getConnects',width:400" />  
		  </div>
		</div>
		<div class="row">
			<div class="col-md-1">依据表</div>
			<div class="col-md-11">
				<input id="tables" name="tables" class="easyui-combobox" 
				data-options="valueField:'tablename',textField:'tablename',width:400" />
			</div>
		</div>
		<div class="row">
			<div class="col-md-2">
				<form id="ff" action="${ctx}/build/action" method="post">
					<a id="btn" class="easyui-linkbutton">生成</a>  
				</form>
			</div>
		</div>
	</div>
</body>
</html>
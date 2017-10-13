<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="../import/tag.jsp"></jsp:include>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<jsp:include page="../import/jscss.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function(){
		$('#btntest').bind('click', function(){
			var row = $('#dg').datagrid('getSelected');
	        $.post('${ctx}/conf/testConnect',row,function(data){
	        	if(data.code=="1"){
	        		$.messager.alert('提示','数据库连接可用!');    
	        	}else{
	        		$.messager.alert('警告','数据库连接不可用!');    
	        	}
	        });   
	    });
		$('#btnedit').bind('click',function(){
			var row = $('#dg').datagrid('getSelected');
			$('#win').window({
				href:'${ctx}/conf/editconnect',
			    width:600,    
			    height:400,    
			    modal:true,
			    queryParams:row,
			    tools: [{    
			        iconCls:'icon-save',    
			        handler:function(){
			        	alert('save');
			        	//var div = $('#win').window('body')[0];
			        	//var ff = $($('#win').window('body')[0]).children()[0];
			        	$('#ff').submit();  
			        }    
			      }]
			});  
		});
	});
</script>
</head>
<body>
	<jsp:include page="../import/navbar.jsp"></jsp:include>
	<table id="dg" class="easyui-datagrid" style="width:98%; height: 1000px;"   
        data-options="url:'${ctx }/conf/getConnects',fitColumns:true,singleSelect:true,toolbar: '#tb',striped:true">   
	    <thead>   
	        <tr>   
	            <th data-options="field:'name',width:80">名称</th>   
	            <th data-options="field:'driver',width:100">驱动</th>   
	            <th data-options="field:'url',width:100,align:'right'">数据库连接</th>
	            <th data-options="field:'username',width:80,align:'right'">用户名</th>
	            <th data-options="field:'password',width:80,align:'right'">密码</th>
	        </tr>   
	    </thead>   
	</table>
	<div id="tb">
		<!-- <a id="btnadd" class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">新增</a> -->
		<a id="btnedit" class="easyui-linkbutton" data-options="iconCls:'icon-edit',plain:true">修改</a>
		<!-- <a id="btndel" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true">删除</a> -->
		<a id="btntest" class="easyui-linkbutton" data-options="iconCls:'icon-ok',plain:true">测试</a>
	</div>
	<div id="win" title="编辑"></div>
</body>
</html>
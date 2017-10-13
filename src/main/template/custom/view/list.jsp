<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../../base/jscss.jsp"/>
    <script type="text/javascript">
    	/*初始化*/
	    $(document).ready(function () {
	        $('#dg').datagrid({
	            data:$_{data} //TODO:生成时，会导致错误，故添加下划线，使用时修改！
	        });
	    });
	    /*功能*/
        function getSelectRow() {
            var row = $('#dg').datagrid('getSelected');
            if(row==null){
                $.messager.alert('警告','请选择要操作的行！');
                return null;
            }
            return row;
        }
	    function refresh() {
	        window.location.href='$_{ctx}/${classNameLower}/list'; //TODO:生成时，会导致错误，故添加下划线，使用时修改！
	    }
	    function openWin() {
	        parent.OP.showDialog({
	            title:'新增${classNameLower}',
	            href:'$_{ctx}/${classNameLower}/add',//TODO:生成时，会导致错误，故添加下划线，使用时修改！
	            width:settings.dialogWidth,
	            height:settings.dialogHeith,
	            maximized:false,
	            onClose:function () {
	                //刷新
	                refresh();
	                //TODO:无刷新加载
	            }
	        });
	    }
	    function updateWin() {
	        var row = getSelectRow();
	        if(row){
	        	parent.OP.showDialog({
		            title:'修改${classNameLower}',
		            href:'$_{ctx}/${classNameLower}/update/'+row.id,//TODO:生成时，会导致错误，故添加下划线，使用时修改！
		            width:settings.dialogWidth,
		            height:settings.dialogHeith,
		            maximized:false,
		            onClose:function () {
		                //刷新
		                refresh();
		                //TODO:无刷新加载
		            }
		        });
	        }
	    }
	    function del() {
	        var row = getSelectRow();
	        if(row){
	        	var id =row.id;
		        //TODO:生成时，会导致错误，故添加下划线，使用时修改！
		        $.get("$_{ctx}/${classNameLower}/del/"+id,function (data) {
		            refresh();
		        });
	        }
	    }
	    /*datagrid 格式化显示*/
	    //<th data-options="field:'rs',width:40,align:'center'" formatter="setrs">状态</th>
        function setrs(value, row, index) {
            if (row.rs==""){
                return "启用";
            } else {
                return "停用";
            }
        }
    </script>
</head>
<body>
    <table id="dg" class="easyui-datagrid" style="width:100%;height:100%"
           data-options="singleSelect:true,fit:false,fitColumns:true,striped:true,toolbar:tb">
        <thead>
        <tr>
        	<#list table.columns as column>
			<th data-options="field:'${column.columnNameLower}',width:40,align:'center'">${column.columnNameLower}</th>
			</#list>
        </tr>
        </thead>
    </table>
    <div id="tb">
        <a class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="openWin()">新增</a>
        <a class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="updateWin()">修改</a>
        <a class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="del()">删除</a>
    </div>
</body>
</html>
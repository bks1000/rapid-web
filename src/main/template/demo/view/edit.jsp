<#assign className = table.className>   
<#assign classNameLower = className?uncap_first> 
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <jsp:include page="../../base/jscss.jsp"/>
    <script type="text/javascript">
    	var dto = $_{dto}; //TODO:生成时，会导致错误，故添加下划线，使用时修改！
        $(document).ready(function () {
            $("#ff").validate();
            $('#btnsave').bind('click', function(){
                //TODO:表单验证
                /*if($("#ff").validate()){
                    console.log($("#ff").validate());
                    return;
                }*/
                //console.log($('#ff').form('getData',true));
                var param = $('#ff').form('getData',true);
                
              	//TODO:生成时，会导致错误，故添加下划线，使用时修改！
                $.post('$_{ctx}/${classNameLower}/save',param,function (data) {
                    parent.OP.closeDialog();
                })
            });
            $('#btncancel').bind('click', function(){
                parent.OP.closeDialog();
            });

            if (dto!=null && dto!=undefined && dto!=0){
                $('#ff').form('setData',dto);
            }
        });
    </script>
</head>
<body>
    <form id="ff" class="container" role="form">
    	<#list table.columns as column>
		<div class="row">
            <label class="col-xs-2 control-label" for="${column.columnNameLower}">${column.columnNameLower}:</label>
            <div class="col-xs-10">
                <input class="form-control" id="${column.columnNameLower}" name="${column.columnNameLower}" maxlength="${column.size}" type="text" placeholder="请输入${column.columnNameLower}" required />
            </div>
        </div>
		</#list>
		<div class="row">
            <span class="col-xs-8"></span>
            <a id="btnsave" class="easyui-linkbutton" data-options="iconCls:'icon-save'">保存</a>&nbsp;&nbsp;
            <a id="btncancel" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'">取消</a>
        </div>
    </form>
</body>
</html>
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
	$(document).ready(function() {
		$('#tt').tabs({
			border : false,
			onSelect : function(title) {
				//alert(title + ' is selected');
				//var currentTab = $('#tt').tabs('getSelected');
				var currentTab = $('#tt').tabs('getTab',title);
				RefreshTab(currentTab);
			},
			tools:[{
				iconCls:'icon-save',
				handler:function(){
					var tab = $("#tt").tabs('getSelected');
					//console.log(tab);
					//console.log($("#ff").serialize());
					var form = tab[0].children;
					$(form).submit();  
				}
			}]

		});
	});
	function RefreshTab(currentTab) {
		/*var url = $(currentTab.panel('options')).attr('href');
		$('#tabs').tabs('update', {
			tab : currentTab,
			options : {
				href : url
			}
		});
		currentTab.panel('refresh');*/
	}
	
</script>
</head>
<body>
	<jsp:include page="../import/navbar.jsp"></jsp:include>
	<div id="tt" style="width: 98%; height: 1000px;">
		<div title="dto"
			data-options="iconCls:'icon-save',href:'${ctx }/temp/editor/dto'"
			style="padding: 20px; display: none;">tab1</div>
		<div title="idao" data-options="iconCls:'icon-save',href:'${ctx }/temp/editor/idao'"
			style="overflow: auto; padding: 20px; display: none;">tab2</div>
		<div title="dao" data-options="iconCls:'icon-save',href:'${ctx }/temp/editor/dao'"
			style="padding: 20px; display: none;">tab3</div>
		<div title="iservice" data-options="iconCls:'icon-save',href:'${ctx }/temp/editor/iservice'"
			style="overflow: auto; padding: 20px; display: none;">tab2</div>
		<div title="service" data-options="iconCls:'icon-save',href:'${ctx }/temp/editor/service'"
			style="padding: 20px; display: none;">tab3</div>
		<div title="controller" data-options="iconCls:'icon-save',href:'${ctx }/temp/editor/controller'"
			style="padding: 20px; display: none;">tab3</div>
		<div title="listpage" data-options="iconCls:'icon-save',href:'${ctx }/temp/editor/listpage'"
			style="overflow: auto; padding: 20px; display: none;">tab2</div>
		<div title="editpage" data-options="iconCls:'icon-save',href:'${ctx }/temp/editor/editpage'"
			style="padding: 20px; display: none;">tab3</div>
	</div>
</body>
</html>
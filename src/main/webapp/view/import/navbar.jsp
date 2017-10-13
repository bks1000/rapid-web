<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-default" role="navigation">
	<div class="container-fluid">
	<div class="navbar-header">
		<a class="navbar-brand" href="#">CreateCodeTools</a>
	</div>
	<div>
		<ul class="nav navbar-nav">
			<li><a href="${ctx }/conf/config">Database Connection</a></li>
			<li><a href="${ctx }/temp/list">Template</a></li>
			<li><a href="${ctx }/build/list">Build</a></li><!-- 选择数据库表，然后通过模板构建，压缩zip输出 -->
		</ul>
	</div>
	</div>
</nav>
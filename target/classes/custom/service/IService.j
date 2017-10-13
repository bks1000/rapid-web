<#include "java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.${subpackage}.service;

<#include "java_imports.include">

import ${basepackage}.${subpackage}.dto.${className};

public interface I${className}Service{
	<#macro getByID>
		<#list table.columns as column>
			<#if column.pk>
			
	public ${className} get${className}ById(${column.javaType} ${column.columnName});
	
			</#if>
		</#list>
	</#macro>
	
	<#macro delByID>
		<#list table.columns as column>
			<#if column.pk>
			
	public void del${className}ById(${column.javaType} ${column.columnName});
	
			</#if>
		</#list>
	</#macro>
	
	public List<${className}> get${className}List();
	
	<@getByID/>
	
	public void save${className}(${className} dto);
	
	<@delByID/>
}
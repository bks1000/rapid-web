<#include "java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.${subpackage}.service;

<#include "java_imports.include">

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ${basepackage}.${subpackage}.dao.I${className}Dao;
import ${basepackage}.${subpackage}.service.I${className}Service;
import ${basepackage}.${subpackage}.dto.${className};

@Service
public class ${className}ServiceImpl extends BaseService implements I${className}Service{
	
	@Autowired
	private I${className}Dao dao;
	
	<#macro getByID>
		<#list table.columns as column>
			<#if column.pk>
			
	public ${className} get${className}ById(${column.javaType} ${column.columnName}) {
		return dao.get${className}ById(${column.columnName});
	}
	
			</#if>
		</#list>
	</#macro>
	
	<#macro delByID>
		<#list table.columns as column>
			<#if column.pk>
			
	public void del${className}ById(${column.javaType} ${column.columnName}) {
		dao.del${className}ById(${column.columnName});
	}
	
			</#if>
		</#list>
	</#macro>
	
	public List<${className}> get${className}List() {
		return dao.get${className}List();
	}
	
	<@getByID/>
	
	public void save${className}(${className} dto) {
		dao.save${className}(dto);
	}
	
	<@delByID/>
}
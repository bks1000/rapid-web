<#include "java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.${subpackage}.dao;

<#include "java_imports.include">

import ${basepackage}.${subpackage}.dto.${className};

import org.springframework.stereotype.Component;

@Component
public class ${className}DaoImpl extends BaseDao implements I${className}Dao{
	
	<#macro getByID>
		<#list table.columns as column>
			<#if column.pk>
			
	public ${className} get${className}ById(${column.javaType} ${column.columnName}) {
		return get(${className}.class, ${column.columnName});
	}
	
			</#if>
		</#list>
	</#macro>
	
	<#macro delByID>
		<#list table.columns as column>
			<#if column.pk>
			
	public void del${className}ById(${column.javaType} ${column.columnName}) {
		executeSql("DELETE FROM ${className} WHERE ${column.columnName}=?", ${column.columnName});
	}
	
			</#if>
		</#list>
	</#macro>


	public List<${className}> get${className}List() {
		return this.find("from ${className}");
	}
	
	<@getByID/>
	
	public void save${className}(${className} dto) {
		//saveOrUpdate(dto);
		if (dto.getOrgid()==null){
			save(dto);
		}else if (exists(${className}.class,dto.getId())){
			update(dto);
		}else {
			save(dto);
		}
	}
	
	<@delByID/>
}
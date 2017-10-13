<#include "java_copyright.include">
<#assign className = table.className>   
<#assign classNameLower = className?uncap_first>   
package ${basepackage}.${subpackage}.controller;
<#include "java_imports.include">

import com.fasterxml.jackson.core.JsonProcessingException;
import com.june.core.utils.JsonUtils;
import javax.servlet.http.HttpServletRequest;

<#include "spring_imports.include">

import ${basepackage}.${subpackage}.dto.${className};
import ${basepackage}.${subpackage}.service.I${className}Service;

<#include "msg.include">
@Controller
@RequestMapping("/${classNameLower}")
public class ${className}Controller {
	@Autowired
	private I${className}Service service;
	
	@RequestMapping("/list")
	public ModelAndView get${className}List(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView("${classNameLower}/list");
		List<${className}> lst = service.get${className}List();
		//将List<Menu>序列化为JSON字符串，供datagrid使用。
		String data="";
		try {
			data = JsonUtils.listToJson(lst);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		mav.addObject("data", data);
		return mav;
	}
	
	@RequestMapping("/add")
	public String add${className}(ModelMap bt) {
		
		bt.addAttribute("dto", 0);
		return "${classNameLower}/edit";
	}
	
	@RequestMapping("/update/{id}")
	public ModelAndView update${className}(@PathVariable("id")String id,HttpServletRequest request){
		ModelAndView mav = new ModelAndView("${classNameLower}/edit");
		//int id = Integer.parseInt(PageUtils.getString(PageUtils.getParameters(request).get("id")));
		try {
			mav.addObject("dto", JsonUtils.objectToJson(service.get${className}ById(id)));
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return mav;
	}
	
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, Object> save(@ModelAttribute("form")${className} dto,HttpServletRequest request) {
		//Map<String, Object> params = PageUtils.getParameters(request);
		service.save${className}(dto);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", 1);
		return map;
	}
	
	@RequestMapping("/del/{id}")
	@ResponseBody
	public Map<String, Object> del${className}(@PathVariable("id")String id,HttpServletRequest request) {
		Map<String, Object> data = PageUtils.getParameters(request);
		//int id = Integer.parseInt(PageUtils.getString(data.get("id")));
		service.del${className}ById(id);
		
		Map<String, Object> ret = new HashMap<String, Object>();
		ret.put("code", 0);
		return ret;
	}
}
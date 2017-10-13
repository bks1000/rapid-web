package com.june.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.june.config.ConfigerHelper;
import com.june.config.ConfigerTemplateDto;
import com.june.core.TempHelper;

@Controller
@RequestMapping("/temp")
public class TemplateController {
	
	@RequestMapping("/list")
	public String getTempMain(){
		return "temp/list";
	}
	
	@RequestMapping("/editor/{name}")
	public String getEditor(@PathVariable("name") String name,ModelMap map) throws Exception {
		List<ConfigerTemplateDto> lst = ConfigerHelper.getInstance().getTemplates();
		for (ConfigerTemplateDto dto : lst) {
			if (name.equals(dto.getName())) {
				String f= TempHelper.getInstance().readFile(dto.getPath());
				map.addAttribute(dto.getType(), f);
			}
		}
		map.addAttribute("name", name);
		return "temp/editor";
	}
	
	@RequestMapping("/save")
	public String save(HttpServletRequest request) throws Exception {
		String name = request.getParameter("name").toString();
		String custom = request.getParameter("custom").toString();
		
		//System.out.println(custom);
		List<ConfigerTemplateDto> lst = ConfigerHelper.getInstance().getTemplates();
		for (ConfigerTemplateDto dto : lst) {
			if (name.equals(dto.getName())&&"custom".equals(dto.getType())) {
				//String f= TempHelper.getInstance().readFile(dto.getPath());
				TempHelper.getInstance().writeFile(dto.getPath(), custom);
				break;
			}
		}
		return "temp/list";
	}
}

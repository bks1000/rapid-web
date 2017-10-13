package com.june.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.dom4j.DocumentException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.june.config.ConfigerConnectionDto;
import com.june.config.ConfigerHelper;
import com.mysql.jdbc.MySQLConnection;
import com.mysql.jdbc.MysqlIO;

@Controller
@RequestMapping("/conf")
public class ConfigerController {

	@RequestMapping("/config")
	public String getConfigPage() {
		return "config/list";
	}
	
	@RequestMapping("/editconnect")
	public String editConnectPage(ConfigerConnectionDto dto,ModelMap mm) {
		mm.addAttribute("dto",dto);
		return "config/edit";
	}
	
	@RequestMapping("/getConnects")
	@ResponseBody
	public List<ConfigerConnectionDto> getConnects(HttpServletRequest request) throws DocumentException {
		return ConfigerHelper.getInstance().getConnections();
	}
	
	@RequestMapping("/testConnect")
	@ResponseBody
	public Map<String, Object> testConnect(HttpServletRequest request) {
		String name =  request.getParameter("name").toString();
		String driver =  request.getParameter("driver").toString();
		String url =  request.getParameter("url").toString();
		String username =  request.getParameter("username").toString();
		String password =  request.getParameter("password").toString();
		
		 Map<String, Object> map = new HashMap<String, Object>();
		// 加载驱动程序
        try {
			Class.forName(driver);
			// 连接数据库
	        Connection conn = DriverManager.getConnection(url, username, password);
	        if(!conn.isClosed()) {
	        	map.put("code", "1");
	        	conn.close();
	        }else {
				map.put("code", "0");
			}
		} catch (ClassNotFoundException | SQLException e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			map.put("code", 0);
		}
        
        return map;
	}
	
	@RequestMapping("/save")
	public String saveConnects(HttpServletRequest request) throws DocumentException, IOException {
		ConfigerConnectionDto dto = new ConfigerConnectionDto();
		String name =  request.getParameter("name").toString();
		String driver =  request.getParameter("driver").toString();
		String url =  request.getParameter("url").toString();
		String username =  request.getParameter("username").toString();
		String password =  request.getParameter("password").toString();
		dto.setName(name);
		dto.setDriver(driver);
		dto.setUrl(url);
		dto.setUsername(username);
		dto.setPassword(password);
		ConfigerHelper.getInstance().saveConnection(dto);
		
		//Map<String, Object> map = new HashMap<String, Object>();
		//map.put("code", 1);
		return "config/list";
	}
}

package com.june.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.june.core.DbHelper;
import com.june.core.ZipCompress;
import com.june.generator.Generator;

@Controller
@RequestMapping("build")
public class BuildController {

	@RequestMapping("list")
	public String list() {
		return "build/list";
	}
	
	@RequestMapping("/gettables")
	@ResponseBody
	public List<Map<String, Object>> getTables(HttpServletRequest request) {
		String name =  request.getParameter("name").toString();
		String driver =  request.getParameter("driver").toString();
		String url =  request.getParameter("url").toString();
		String username =  request.getParameter("username").toString();
		String password =  request.getParameter("password").toString();
        
        return DbHelper.getInstance().getAllTableInfo(driver, url, username, password);
	}
	
	@RequestMapping("/action")
	public void build(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String name =  request.getParameter("name").toString();
		String driver =  request.getParameter("driver").toString();
		String url =  request.getParameter("url").toString();
		String username =  request.getParameter("username").toString();
		String password =  request.getParameter("password").toString();
		String tablename = request.getParameter("tablename").toString();
		
		Generator generator = new Generator(driver,url,username,password);
		try {
			generator.clean();
			generator.generateTable(tablename);
		} catch (Exception e) {
			// TODO 自动生成的 catch 块
			e.printStackTrace();
			return;
		}
		ClassLoader loader = getClass().getClassLoader();
		URL rooturl = loader.getResource("");
		String zipurl = rooturl.getFile()+"outroot.zip";
		URL outrootUrl = loader.getResource("outroot");
		
		ZipCompress zip = new ZipCompress(zipurl,outrootUrl.getFile());
		zip.zip();
		
		//输出到客户端
		//详细参考
		//http://blog.csdn.net/chenaini119/article/details/51791978
		//1.获取要下载的文件的绝对路径
	     //String realPath = this.getServletContext().getRealPath("/download/1.JPG");
	     //2.获取要下载的文件名
	     //String fileName = realPath.substring(realPath.lastIndexOf("\\")+1);
		String fileName = "outroot.zip";
	     //3.设置content-disposition响应头控制浏览器以下载的形式打开文件
	     response.setHeader("content-disposition", "attachment;filename="+fileName);
	     //4.获取要下载的文件输入流
	     InputStream in = new FileInputStream(zipurl);
	     int len = 0;
	     //5.创建数据缓冲区
	     byte[] buffer = new byte[1024];
	     //6.通过response对象获取OutputStream流
	     OutputStream out = response.getOutputStream();
	     //7.将FileInputStream流写入到buffer缓冲区
	     while ((len = in.read(buffer)) > 0) {
	     //8.使用OutputStream将缓冲区的数据输出到客户端浏览器
	         out.write(buffer,0,len);
	     }
	     in.close();
	}
}

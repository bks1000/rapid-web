package com.june.config;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

import com.june.core.XmlHelper;

/**
 * xml操作
 * http://www.cnblogs.com/fnz0/p/5538459.html
 * @author lenovo
 *
 */
public class ConfigerHelper {
	
	private static ConfigerHelper helper=null;
	
	private ConfigerHelper(){}
	
	public static ConfigerHelper getInstance(){
		if (helper==null) {
			helper = new ConfigerHelper();
		}
		return helper;
	}
	
	/**
	 * 读取XML配置文件，获取连接信息
	 * @return
	 * @throws DocumentException
	 */
	public List<ConfigerConnectionDto> getConnections() throws DocumentException {
		String fileName ="init.xml";
		ClassLoader classLoader = getClass().getClassLoader();
		URL url = classLoader.getResource(fileName);
		
		List<ConfigerConnectionDto> lst = new ArrayList<ConfigerConnectionDto>();
		SAXReader reader = new SAXReader(); //1.创建一个xml解析器对象
		Document doc = reader.read(new File(url.getFile()));//2.读取xml文档，返回Document对象
		Element elem =  doc.getRootElement();  //获取xml文档的根标签（一般创建doc对象后回先调用此方法得到根标签）
		List<Element> list =  ((Element)elem.elements().get(0)).elements(); //获取所有子标签
		for (Element element : list) {
			ConfigerConnectionDto dto= new ConfigerConnectionDto();
			dto.setName(element.attributeValue("name"));
			dto.setDriver(element.attributeValue("driver"));
			dto.setUrl(element.attributeValue("url"));
			dto.setUsername(element.attributeValue("username"));
			dto.setPassword(element.attributeValue("password"));
			lst.add(dto);
		}
		return lst;
	}
	
	/**
	 * 保存数据库连接串
	 * @param dto
	 * @throws DocumentException 
	 * @throws IOException 
	 */
	public void saveConnection(ConfigerConnectionDto dto) throws DocumentException, IOException {
		String fileName ="init.xml";
		ClassLoader classLoader = getClass().getClassLoader();
		URL url = classLoader.getResource(fileName);
		
		SAXReader reader = new SAXReader(); //1.创建一个xml解析器对象
		Document doc = reader.read(new File(url.getFile()));//2.读取xml文档，返回Document对象
		Element elem =  doc.getRootElement();  //获取xml文档的根标签（一般创建doc对象后回先调用此方法得到根标签）
		List<Element> list =  ((Element)elem.elements().get(0)).elements(); //获取所有子标签
		for (Element element:list) {
			if(element.attributeValue("driver").equals(dto.getDriver())){
				//更新
				element.attribute("name").setText(dto.getName());
				element.attribute("url").setText(dto.getUrl());
				element.attribute("username").setText(dto.getUsername());
				element.attribute("password").setText(dto.getPassword());
				break;
			}
		}
		 XMLWriter writer = new XMLWriter(new FileWriter(url.getFile()));
		 writer.write(doc);
		 writer.close();
	}

	/**
	 * 获取模板配置信息
	 * @return
	 * @throws Exception
	 */
	public List<ConfigerTemplateDto> getTemplates() throws Exception {
		List<ConfigerTemplateDto> lst = new ArrayList<ConfigerTemplateDto>();
		
		Document document = XmlHelper.getInstance().getDocument();
		Element root = document.getRootElement();
		List<Element> list = ((Element)root.elements().get(1)).elements();
		for (Element element : list) {
			ConfigerTemplateDto dto = new ConfigerTemplateDto();
			dto.setId(element.attributeValue("id"));
			dto.setName(element.attributeValue("name"));
			dto.setType(element.attributeValue("type"));
			dto.setPath(element.attributeValue("path"));
			lst.add(dto);
		}
		return lst;
	}
}

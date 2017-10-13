package com.june.core;

import java.io.FileWriter;
import java.net.URL;

import org.dom4j.Document;
import org.dom4j.io.SAXReader;
import org.dom4j.io.XMLWriter;

public class XmlHelper {
	
	/**
	 * 应用程序配置文件
	 */
	private String fileName ="init.xml";
	
	private static XmlHelper helper;
	
	private XmlHelper() {}
	
	public static XmlHelper getInstance() {
		if (helper==null) {
			helper=new XmlHelper();
		}
		return helper;
	}
	
	/**
     * 该方法用于得到document对象。
     * 
     * @return
     * @throws Exception
     */
    public Document getDocument() throws Exception {
    	ClassLoader classLoader = getClass().getClassLoader();
		URL url = classLoader.getResource(fileName);
		
        SAXReader sr = new SAXReader();
        Document document = sr.read(url.getFile());
        return document;
    }
    
    /**
     * 通过document对象将内存中的dom树保存到xml文档。
     * 
     * @param document
     * @throws Exception
     */
    public void writeToNewXMLDocument(Document document)
            throws Exception {
    	ClassLoader classLoader = getClass().getClassLoader();
		URL url = classLoader.getResource(fileName);
        XMLWriter writer = new XMLWriter(new FileWriter(url.getFile()));
        writer.write(document);
        writer.close();
    }
    
    
}

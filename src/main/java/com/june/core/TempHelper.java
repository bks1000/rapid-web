package com.june.core;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URI;
import java.net.URL;
import java.nio.CharBuffer;

public class TempHelper {
	
	/**
	 * 应用程序配置文件
	 */
	//private String fileName ="init.xml";
	private static TempHelper helper;
	private TempHelper() {
		// TODO 自动生成的构造函数存根
	}
	
	public static TempHelper getInstance() {
		if (helper==null) {
			helper = new TempHelper();
		}
		return helper;
	}
	
	/**
	 * 读取文件内容
	 * @param fileName :配置文件中配置的文件路径
	 * @return
	 * @throws IOException 
	 */
	public String readFile(String fileName) throws IOException {
		ClassLoader classLoader = getClass().getClassLoader();
		URL url = classLoader.getResource(fileName);
		
		File filename = new File(url.getFile()); // 要读取以上路径的input。txt文件  
        InputStreamReader reader = new InputStreamReader(  
                new FileInputStream(filename)); // 建立一个输入流对象reader  
        BufferedReader br = new BufferedReader(reader); // 建立一个对象，它把文件内容转成计算机能读懂的语言  
        StringBuilder builder = new StringBuilder(); 
        String line = br.readLine();
        while (line != null) {  
        	builder.append(line+"\r\n"); 
        	
            line = br.readLine(); // 一次读入一行数据  
        }  
        reader.close();
        return builder.toString();
	}
	
	/**
	 * 写入文件内容
	 * @param fileName 配置文件中配置的文件路径(只写custom中的文件)
	 * @throws IOException 
	 */
	public void writeFile(String fileName,String content) throws IOException {
		ClassLoader classLoader = getClass().getClassLoader();
		URL url = classLoader.getResource(fileName);
		
		/* 写入Txt文件 */  
        File writename = new File(url.getFile()); // 相对路径，如果没有则要建立一个新的output。txt文件  
        if (!writename.exists()) {
        	writename.createNewFile(); // 创建新文件  
		}
        
        BufferedWriter out = new BufferedWriter(new FileWriter(writename));  
        out.write(content); // \r\n即为换行  
        out.flush(); // 把缓存区内容压入文件  
        out.close(); // 最后记得关闭文件  
	}
}

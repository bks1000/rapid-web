package com.june.core;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//http://www.cnblogs.com/avivaye/p/4938592.html

public class DbHelper {
	
	private static DbHelper dbHelper;
	private DbHelper() {}
	public static DbHelper getInstance() {
		if (dbHelper==null) {
			dbHelper = new DbHelper();
		}
		return dbHelper;
	}
	
	/**
	 * 获取conn
	 */
    public Connection getConn(String driver,String url,String uname,String pwd) {
    	Connection  conn=null;
        try {
            Class.forName(driver).newInstance();
            conn = java.sql.DriverManager.getConnection(url, uname, pwd);
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
	
	/**
	 * 获取全部表信息
	 * @return
	 */
	public List<Map<String, Object>> getAllTableInfo(String driver,String url,String uname,String pwd) {
		List<Map<String, Object>> lst = new ArrayList<Map<String,Object>>();
		 //获取数据库所有表
        StringBuffer sbTables = new StringBuffer();
        List<Map<String, Object>> tables = new ArrayList<Map<String, Object>>();
        sbTables.append("-------------- 数据库中有下列的表 ----------<br/>");
        try {
            DatabaseMetaData dbMetaData = (DatabaseMetaData)getConn(driver, url, uname, pwd).getMetaData();
            ResultSet rs = dbMetaData.getTables(null, null, null,new String[] { "TABLE" });
            /*while (rs.next()) {// ///TABLE_TYPE/REMARKS
                sbTables.append("表名：" + rs.getString("TABLE_NAME") + "<br/>");
                sbTables.append("表类型：" + rs.getString("TABLE_TYPE") + "<br/>");
                sbTables.append("表所属数据库：" + rs.getString("TABLE_CAT") + "<br/>");
                sbTables.append("表所属用户名：" + rs.getString("TABLE_SCHEM")+ "<br/>");
                sbTables.append("表备注：" + rs.getString("REMARKS") + "<br/>");
                sbTables.append("------------------------------<br/>");
                tables.add(rs.getString("TABLE_NAME"));
            }*/
            while (rs.next()) {
				Map<String, Object> table = new HashMap<String, Object>();
				table.put("tablename", rs.getString("TABLE_NAME"));
				tables.add(table);
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tables;
	}
}

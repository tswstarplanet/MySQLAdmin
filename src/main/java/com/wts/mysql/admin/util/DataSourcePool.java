package com.wts.mysql.admin.util;

import com.wts.mysql.admin.model.LogonModel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

/**
 * Created by weitaosheng on 16/9/11.
 */
public class DataSourcePool {

    public static final String urlPrefix = "jdbc:mysql://";

    public static ConcurrentMap<String, Connection> map = new ConcurrentHashMap<String, Connection>();

    public static Connection addConnection(String ip, LogonModel logonModel) throws Exception {
        if (map.get(ip) != null) {
            throw new Exception("该连接已存在，添加失败");
        }
        String driver = "com.mysql.jdbc.Driver";
        String url = urlPrefix + logonModel.getIp() + ":" + logonModel.getPort() + "/?useSSL=false";
        String username = logonModel.getUsername();
        String password = logonModel.getPassword();

        Connection connection = DriverManager.getConnection(url, username, password);
        return connection;
    }

    public static void deleteConnection(String ip) throws Exception{
        if (!map.containsKey(ip)) {
            return;
        }
        Connection connection = map.get(ip);
        if (!connection.isClosed()) {
            connection.close();
        }
        map.remove(ip);
    }

}

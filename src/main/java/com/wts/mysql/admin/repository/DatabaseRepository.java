package com.wts.mysql.admin.repository;

import com.wts.mysql.admin.model.SchemaModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcOperations;
import org.springframework.stereotype.Repository;

import java.util.*;

/**
 * Created by weitaosheng on 16/9/13.
 */

@Repository
public class DatabaseRepository implements IDatabaseRepository{


    public static final String FIND_DATABASE_NAMES = "select SCHEMA_NAME from information_schema.SCHEMATA";

    public static final String FIND_TABLES_NAMES = "select TABLE_NAME from information_schema.TABLES where TABLE_SCHEMA = ?";

    public static final String FIND_COLUMN_NAMES = "select COLUMN_NAME from information_schema.COLUMNS where TABLE_NAME = ? and TABLE_SCHEMA = ?";
    @Autowired
    private JdbcOperations jdbcOperations;


    public void getDatabases() {

    }

    public JdbcOperations getJdbcOperations() {
        return jdbcOperations;
    }

    public void setJdbcOperations(JdbcOperations jdbcOperations) {
        this.jdbcOperations = jdbcOperations;
    }

    public List<String> findDatabases() {
        List<String> dbNames = jdbcOperations.queryForList(FIND_DATABASE_NAMES, String.class);
        return dbNames;
    }

    public List<SchemaModel> getSchemas(String name) {
        return null;
    }

    public List<Object> getDatabaseTree() {
        List<String> dbNames = jdbcOperations.queryForList(FIND_DATABASE_NAMES, String.class);
        Iterator<String> iterator = dbNames.iterator();
        while (iterator.hasNext()) {
            String dbName = iterator.next();
            if ("information_schema".equals(dbName) || "mysql".equals(dbName) || "performance_schema".equals(dbName)) {
                iterator.remove();
            }
        }
        List<Object> databaseTree = new LinkedList();
//        List<String> tbNames = null;
        for (String dbName : dbNames) {
            Map<String, Object> dbMap = new HashMap();
            dbMap.put("name", dbName);
            dbMap.put("open", false);
            List<Object> tbChildList = new LinkedList();
            List<Object> tbList = new LinkedList();
            List<String> tbNames = jdbcOperations.queryForList(FIND_TABLES_NAMES, new Object[] {dbName} ,String.class);
            for (String tbName : tbNames) {
                Map<String, Object> tbMap = new HashMap();
                tbMap.put("name", tbName);
                tbMap.put("open", false);
                List<String> colNames = jdbcOperations.queryForList(FIND_COLUMN_NAMES, new Object[]{tbName, dbName}, String.class);
                List<Object> colList = new LinkedList();
                List<Object> colChildList = new LinkedList();
                for (String colName : colNames) {
                    Map<String, Object> colMap = new HashMap();
                    colMap.put("name", colName);
                    colMap.put("class", "column");
                    colList.add(colMap);
                }
                Map<String, Object> column = new HashMap();
                column.put("name", "column");
                column.put("open", false);
                column.put("children", colList);
                colChildList.add(column);
                tbMap.put("children", colChildList);
                tbMap.put("class", "table");
                tbList.add(tbMap);
            }
            Map<String, Object> table = new HashMap();
            table.put("name", "table");
            table.put("open", false);
            table.put("children", tbList);
            tbChildList.add(table);
            dbMap.put("children", tbChildList);
            dbMap.put("class", "schema");
//            dbMap.put("children", tbList);
            databaseTree.add(dbMap);
        }
        return databaseTree;
    }
}

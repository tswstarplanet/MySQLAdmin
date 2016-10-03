package com.wts.mysql.admin.repository;

import com.wts.mysql.admin.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcOperations;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by weitaosheng on 2016/10/2.
 */

@Repository
public class TableRepository implements ITableRepository {

    @Autowired
    private JdbcOperations jdbcOperations;

    public JdbcOperations getJdbcOperations() {
        return jdbcOperations;
    }

    public void setJdbcOperations(JdbcOperations jdbcOperations) {
        this.jdbcOperations = jdbcOperations;
    }

    public List<String> findColumnNames(String schemaName, String tableName) {
        List<String> columnNames = jdbcOperations.queryForList(Constants.FIND_COLUMN_NAMES, new Object[]{tableName, schemaName}, String.class);
        return columnNames;
    }

    public List<Map<String, Object>> findDataRows(String schemaName, String tableName, int numOfRow) {
        String tableFullName = schemaName + "." + tableName;
//        List<Map<String, Object>> dataList = jdbcOperations.queryForList(Constants.FIND_TABLE_DATA_OF_RANGE, new Object[] {tableFullName});
        String sql = "select * from " + schemaName + "." + tableName + " limit ?";
        List<Map<String, Object>> dataList = jdbcOperations.queryForList(sql, Constants.DEFAULT_NUM_OF_ROWS_RETURN);
        return dataList;
    }
}

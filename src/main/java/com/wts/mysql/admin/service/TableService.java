package com.wts.mysql.admin.service;

import com.wts.mysql.admin.repository.ITableRepository;
import com.wts.mysql.admin.util.Constants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by weitaosheng on 2016/10/1.
 */

@Service
public class TableService implements ITableService {

    @Autowired
    private ITableRepository tableRepository;

    public ITableRepository getTableRepository() {
        return tableRepository;
    }

    public void setTableRepository(ITableRepository tableRepository) {
        this.tableRepository = tableRepository;
    }

    private String generateSelectSql(String schemaName, String tableName, int numOfRows) {
        return "select * from " + schemaName + "." + tableName + " limit " + numOfRows;
    }

    public Map<String, Object> findTableData(String schemaName, String tableName) {
//        Map<String, Object> map = new HashMap();
//        return map;
        String selectSql = generateSelectSql(schemaName, tableName, Constants.DEFAULT_NUM_OF_ROWS_RETURN);
//        List<String> columnNames = tableRepository.findColumnNames(schemaName, tableName);
        List<Map<String, Object>> dataList = tableRepository.findDataRows(schemaName, tableName, Constants.DEFAULT_NUM_OF_ROWS_RETURN);
        Map<String, Object> tableData = new HashMap();
        tableData.put("sql", selectSql);
//        tableData.put("columnNames", columnNames);
        tableData.put("dataList", dataList);
        return tableData;
    }
}

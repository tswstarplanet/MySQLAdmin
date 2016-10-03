package com.wts.mysql.admin.repository;

import java.util.List;
import java.util.Map;

/**
 * Created by weitaosheng on 16/9/18.
 */
public interface ITableRepository {

    List<String> findColumnNames(String schemaName, String tableName);

    List<Map<String, Object>> findDataRows(String schemaName, String tableName, int numOfRow);

}

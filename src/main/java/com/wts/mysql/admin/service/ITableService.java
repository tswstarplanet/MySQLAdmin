package com.wts.mysql.admin.service;

import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by weitaosheng on 2016/10/1.
 */

@Service
public interface ITableService {

    Map<String, Object> findTableData(String schemaName, String tableName);

}

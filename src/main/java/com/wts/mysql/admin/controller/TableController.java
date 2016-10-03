package com.wts.mysql.admin.controller;

import com.wts.mysql.admin.service.ITableService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by weitaosheng on 2016/10/1.
 */

@Controller
@RequestMapping("/table")
public class TableController {

    @Autowired
    private ITableService tableService;

    public ITableService getTableService() {
        return tableService;
    }

    public void setTableService(ITableService tableService) {
        this.tableService = tableService;
    }

    @RequestMapping("/findTableData")
    public @ResponseBody Map<String, Object> findTableData(
            @RequestParam("schemaName") String schemaName,
            @RequestParam("tableName") String tableName
    ) {
        Map<String, Object> tableData = tableService.findTableData(schemaName, tableName);
        return tableData;
    }

}

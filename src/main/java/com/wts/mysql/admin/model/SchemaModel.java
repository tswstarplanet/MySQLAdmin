package com.wts.mysql.admin.model;

import java.util.List;

/**
 * Created by weitaosheng on 16/9/17.
 */
public class SchemaModel {

    private String name;

    private boolean open;

    private List<TableModel> tableModelList;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<TableModel> getTableModelList() {
        return tableModelList;
    }

    public void setTableModelList(List<TableModel> tableModelList) {
        this.tableModelList = tableModelList;
    }
}

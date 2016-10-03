package com.wts.mysql.admin.model;

import java.util.List;

/**
 * Created by weitaosheng on 16/9/17.
 */
public class DatabaseModel {

    private List<SchemaModel> schemaModelList;

    public List<SchemaModel> getSchemaModelList() {
        return schemaModelList;
    }

    public void setSchemaModelList(List<SchemaModel> schemaModelList) {
        this.schemaModelList = schemaModelList;
    }


}

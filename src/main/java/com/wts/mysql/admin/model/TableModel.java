package com.wts.mysql.admin.model;

import java.util.List;

/**
 * Created by weitaosheng on 16/9/17.
 */
public class TableModel {

    private String name;

    private List<ColumnModel> columnModelList;

    private boolean isPrimaryKey;

    private boolean isNotNull;

    private boolean isUniqueIndex;

    private boolean isBinary;

    private boolean isUnsigned;

    private boolean isZeroFill;

    private boolean isAutoIncrement;

    private boolean isGenerated;

    private String defaultExpression;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<ColumnModel> getColumnModelList() {
        return columnModelList;
    }

    public void setColumnModelList(List<ColumnModel> columnModelList) {
        this.columnModelList = columnModelList;
    }

    public boolean isPrimaryKey() {
        return isPrimaryKey;
    }

    public void setPrimaryKey(boolean primaryKey) {
        isPrimaryKey = primaryKey;
    }

    public boolean isNotNull() {
        return isNotNull;
    }

    public void setNotNull(boolean notNull) {
        isNotNull = notNull;
    }

    public boolean isUniqueIndex() {
        return isUniqueIndex;
    }

    public void setUniqueIndex(boolean uniqueIndex) {
        isUniqueIndex = uniqueIndex;
    }

    public boolean isBinary() {
        return isBinary;
    }

    public void setBinary(boolean binary) {
        isBinary = binary;
    }

    public boolean isUnsigned() {
        return isUnsigned;
    }

    public void setUnsigned(boolean unsigned) {
        isUnsigned = unsigned;
    }

    public boolean isZeroFill() {
        return isZeroFill;
    }

    public void setZeroFill(boolean zeroFill) {
        isZeroFill = zeroFill;
    }

    public boolean isAutoIncrement() {
        return isAutoIncrement;
    }

    public void setAutoIncrement(boolean autoIncrement) {
        isAutoIncrement = autoIncrement;
    }

    public boolean isGenerated() {
        return isGenerated;
    }

    public void setGenerated(boolean generated) {
        isGenerated = generated;
    }

    public String getDefaultExpression() {
        return defaultExpression;
    }

    public void setDefaultExpression(String defaultExpression) {
        this.defaultExpression = defaultExpression;
    }
}

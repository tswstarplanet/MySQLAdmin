package com.wts.mysql.admin.util;

/**
 * Created by weitaosheng on 2016/10/2.
 */
public class Constants {

    public static final int DEFAULT_NUM_OF_ROWS_RETURN = 10;

    public static final String FIND_DATABASE_NAMES = "select SCHEMA_NAME from information_schema.SCHEMATA";

    public static final String FIND_TABLES_NAMES = "select TABLE_NAME from information_schema.TABLES where TABLE_SCHEMA = ?";

    public static final String FIND_COLUMN_NAMES = "select COLUMN_NAME from information_schema.COLUMNS where TABLE_NAME = ? and TABLE_SCHEMA = ?";

    public static final String FIND_TABLE_DATA_OF_RANGE = "select * from ?";

}

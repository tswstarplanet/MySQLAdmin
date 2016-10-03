package com.wts.mysql.admin.service;

import org.json.JSONArray;

/**
 * Created by weitaosheng on 16/9/17.
 */
public interface IDatabaseService {

    JSONArray getDBNames();

    JSONArray getTbNames(String dbName);

    JSONArray getColNames(String tbName);

}

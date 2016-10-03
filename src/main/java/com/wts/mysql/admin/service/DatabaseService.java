package com.wts.mysql.admin.service;

import com.wts.mysql.admin.repository.DatabaseRepository;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Iterator;
import java.util.List;

/**
 * Created by weitaosheng on 16/9/17.
 */

@Service
public class DatabaseService implements IDatabaseService {

    @Autowired
    private DatabaseRepository databaseRepository;

    public DatabaseRepository getDatabaseRepository() {
        return databaseRepository;
    }

    public void setDatabaseRepository(DatabaseRepository databaseRepository) {
        this.databaseRepository = databaseRepository;
    }

    public JSONArray getDBNames() {
        List<String> dbNames = databaseRepository.findDatabases();
        Iterator<String> iterator = dbNames.iterator();
        JSONArray dbNameArray = new JSONArray();
        while (iterator.hasNext()) {
            String dbName = iterator.next();
            if ("information_schema".equals(dbName) || "mysql".equals(dbName) || "performance_schema".equals(dbName)) {
                iterator.remove();
                continue;
            }
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("name", dbName);
            jsonObject.put("open", false);
            dbNameArray.put(jsonObject);
        }
        return dbNameArray;
    }

    public JSONArray getTbNames(String dbName) {
        return null;
    }

    public JSONArray getColNames(String tbName) {
        return null;
    }

}

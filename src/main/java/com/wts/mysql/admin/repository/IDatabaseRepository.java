package com.wts.mysql.admin.repository;

import com.wts.mysql.admin.model.SchemaModel;

import java.util.List;

/**
 * Created by weitaosheng on 16/9/17.
 */
public interface IDatabaseRepository {

    List<SchemaModel> getSchemas(String name);

}

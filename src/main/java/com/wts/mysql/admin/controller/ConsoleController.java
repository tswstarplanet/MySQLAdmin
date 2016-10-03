package com.wts.mysql.admin.controller;

import com.wts.mysql.admin.repository.DatabaseRepository;
import com.wts.mysql.admin.repository.IDatabaseRepository;
import com.wts.mysql.admin.service.IDatabaseService;
import com.wts.mysql.admin.util.SystemDBName;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * Created by weitaosheng on 16/9/17.
 */

@Controller
public class ConsoleController {

    public static final EnumSet<SystemDBName> systemDBNames = EnumSet.allOf(SystemDBName.class);

    @Autowired
    private IDatabaseService databaseService;

    @Autowired
    private DatabaseRepository databaseRepository;

    public IDatabaseService getDatabaseService() {
        return databaseService;
    }

    public void setDatabaseService(IDatabaseService databaseService) {
        this.databaseService = databaseService;
    }

    class Person {
        private String username;
        private String password;
        private boolean flag;

        public boolean isFlag() {
            return flag;
        }

        public void setFlag(boolean flag) {
            this.flag = flag;
        }

        public String getUsername() {
            return username;
        }

        public void setUsername(String username) {
            this.username = username;
        }

        public String getPassword() {
            return password;
        }

        public void setPassword(String password) {
            this.password = password;
        }
    }

//    @RequestMapping("/getDBNames")
//    @ResponseBody
//    public String getDBNames() {
//        Map<String, Object> map = new HashMap();
//        map.put("work", "develop");
//        map.put("School", "bupt");
////        Person person1 = new Person();
////        person1.setUsername("Tom");
////        person1.setPassword("123");
////        Person person2 = new Person();
////        person2.setUsername("Jack");
////        person2.setPassword("456");
////        List<Person> list = new ArrayList<Person>();
////        list.add(person1);
////        list.add(person2);
////        map.put("userList", list);
//        return "hello";
//    }

    @RequestMapping("/getDBTree")
    public @ResponseBody Map<String, Object> getDBNames() {
        List<Object> list = databaseRepository.getDatabaseTree();
        Map<String, Object> map = new HashMap();
        map.put("list", list);
        return map;
    }


    @RequestMapping("/")
    public String view() {
//        JSONArray dbNameArray = databaseService.getDBNames();
//        model.addAttribute("dbNameArray", dbNameArray);
        databaseRepository.getDatabaseTree();
        return "views/console";
    }



}

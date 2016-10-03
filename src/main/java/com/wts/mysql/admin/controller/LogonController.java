package com.wts.mysql.admin.controller;

import com.wts.mysql.admin.model.LogonModel;
import org.springframework.stereotype.Controller;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

/**
 * Created by weitaosheng on 16/9/11.
 */

@Controller
public class LogonController {


    public String index() {
        return "views/console";
    }

    @RequestMapping("/login")
    public String login(
            @Valid LogonModel logonModel,
            Errors errors) {
        if (errors.hasErrors()) {
            return "views/login";
        }
        return "views/login";
    }

}

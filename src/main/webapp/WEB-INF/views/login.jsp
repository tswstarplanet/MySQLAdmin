<%--
  Created by IntelliJ IDEA.
  User: weitaosheng
  Date: 16/9/11
  Time: 下午3:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/webinfo/util/bootstrap/css/bootstrap.min.css">
    <style>
        .col-center-block {
            float: none;
            display: block;
            margin-left: auto;
            margin-right: auto;
            margin-top: 20px;
            margin-bottom: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row myCenter">
            <div class="col-md-6 col-center-block">
                <form class="form-horizontal" role="form" action="/login">
                    <div class="form-group">
                        <label for="url" class="col-sm-2 control-label">地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="url"
                                   placeholder="请输入服务器地址">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="port" class="col-sm-2 control-label">端口</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="port"
                                   placeholder="请输入端口">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="username" class="col-sm-2 control-label">用户名</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="username"
                                   placeholder="请输入用户名">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="password" class="col-sm-2 control-label">密码</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" id="password"
                                   placeholder="请输入密码">
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="submit" class="btn btn-default">登录</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script src="/webinfo/util/jquery/jquery-3.1.0.min.js"></script>
    <script src="/webinfo/util/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>

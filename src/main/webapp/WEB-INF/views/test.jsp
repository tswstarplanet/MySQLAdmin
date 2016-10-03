<%--
  Created by IntelliJ IDEA.
  User: weitaosheng
  Date: 16/9/22
  Time: 下午10:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="/resource/util/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="/resource/util/easyui/themes/icon.css">
    <%--<link rel="stylesheet" type="text/css" href="/resource/util/easyui/demo.css">--%>
    <link rel="stylesheet" href="/resource/util/bootstrap/css/bootstrap.min.css">
    <script type="text/javascript" src="/resource/util/jquery/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="/resource/util/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" href="/resource/util/bootstrap/js/bootstrap.min.js"></script>

    <script type="text/javascript">
        function addTab(title){
            alert(title);
            if ($('#tt').tabs('exists', title)){
                $('#tt').tabs('select', title);
                alert(1);
            } else {
//                var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
                var content = '<p style="font-size:14px">jQuery EasyUI framework helps you build your web pages easily.</p>'
                alert(2);
                $('#tt').tabs('add',{
                    title:title,
                    content:content,
                    closable:true
                });
                alert(3);
            }
        }
    </script>
</head>
<body>
<h2>Basic Tabs</h2>
<p>Click tab strip to swap tab panel content.</p>
<div style="margin:20px 0 10px 0;"></div>
<div id="tt" class="easyui-tabs" style="width:700px;height:250px">
    <div title="About" style="padding:10px">
        <p style="font-size:14px">jQuery EasyUI framework helps you build your web pages easily.</p>
        <ul>
            <li>easyui is a collection of user-interface plugin based on jQuery.</li>
            <li>easyui provides essential functionality for building modem, interactive, javascript applications.</li>
            <li>using easyui you don't need to write many javascript code, you usually defines user-interface by writing some HTML markup.</li>
            <li>complete framework for HTML5 web page.</li>
            <li>easyui save your time and scales while developing your products.</li>
            <li>easyui is very easy but powerful.</li>
        </ul>
    </div>
    <div title="My Documents" style="padding:10px">
        <ul class="easyui-tree" data-options="url:'tree_data1.json',method:'get',animate:true"></ul>
    </div>
    <div title="Help" data-options="iconCls:'icon-help',closable:true" style="padding:10px">
        This is the help content.
    </div>
</div>
<button type="button" class="btn btn-default" onclick="addTab('新标签')">
    添加标签
</button>
</body>
</html>

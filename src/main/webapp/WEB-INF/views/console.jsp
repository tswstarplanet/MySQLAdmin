<%--
  Created by IntelliJ IDEA.
  User: weitaosheng
  Date: 16/9/16
  Time: 上午9:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- Bootstrap core CSS -->
    <link rel="stylesheet" href="/resource/util/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="/resource/util/wangeditor/dist/css/wangEditor.min.css">
    <script type="text/javascript" src="/resource/util/jquery/jquery-3.1.0.min.js"></script>
    <script type="text/javascript" src="/resource/util/bootstrap/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="/resource/util/zTree/css/metroStyle/metroStyle.css" type="text/css">
    <%--<script type="text/javascript" src="/webinfo/util/zTree/js/jquery-1.4.4.min.js"></script>--%>

    <script type="text/javascript" src="/resource/util/zTree/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="/resource/util/zTree/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="/resource/util/zTree/js/jquery.ztree.exedit.js"></script>
    <script type="text/javascript" charset="utf-8" src="/resource/util/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/resource/util/ueditor/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="/resource/util/ueditor/lang/zh-cn/zh-cn.js"></script>
    <script type="text/javascript" src="/resource/util/wangeditor/dist/js/wangEditor.min.js"></script>
    <style type="text/css">
        .sidebar {
            position: fixed;
            top: 51px;
            bottom: 0;
            left: 0;
            z-index: 1000;
            display: block;
            padding: 20px;
            overflow-x: hidden;
            overflow-y: auto; /* Scrollable contents if viewport is shorter than content. */
            background-color: #f5f5f5;
            border-right: 1px solid #eee;
        }
        /* Sidebar navigation */
        .nav-sidebar {
            margin-right: -21px; /* 20px padding + 1px border */
            margin-bottom: 20px;
            margin-left: -20px;
        }
        .nav-sidebar > li > a {
            padding-right: 20px;
            padding-left: 20px;
        }
        .nav-sidebar > .active > a,
        .nav-sidebar > .active > a:hover,
        .nav-sidebar > .active > a:focus {
            color: #fff;
            background-color: #428bca;
        }

        div#schemaMenu {position:absolute; visibility:hidden; top:0; background-color: #00a2d4;text-align: left;padding: 2px; z-index: 1200;}
        div#schemaMenu ul li{
            margin: 1px 0;
            padding: 0 5px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #DFDFDF;
        }

        div#tableMenu {position:absolute; visibility:hidden; top:0; background-color: #00a2d4;text-align: left;padding: 2px; z-index: 1200;}
        div#tableMenu ul li{
            margin: 1px 0;
            padding: 0 5px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #DFDFDF;
        }

        div#columnMenu {position:absolute; visibility:hidden; top:0; background-color: #00a2d4;text-align: left;padding: 2px; z-index: 1200;}
        div#columnMenu ul li{
            margin: 1px 0;
            padding: 0 5px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #DFDFDF;
        }
    </style>
    <script type="text/javascript">

        var pageNum = 1;

        function reNumberPages() {
            pageNum = 1;
            var tabCount = $('#pageTab > li').length;
            $('#pageTab > li').each(function() {
                var pageId = $(this).children('a').attr('href');
                if (pageId == "#page1") {
                    return true;
                }
                pageNum++;
                $(this).children('a').html('Page ' + pageNum +
                        '<button class="close" type="button" ' +
                        'title="Remove this page">×</button>');
            });
        }

        $(document).ready(function() {
            /**
             * Add a Tab
             */
            $('#btnAddPage').click(function() {
                pageNum++;
                $('#pageTab').append(
                        $('<li><a href="#page' + pageNum + '">' +
                                'Page ' + pageNum +
                                '<button class="close" type="button" ' +
                                'title="Remove this page">×</button>' +
                                '</a></li>'));

                $('#pageTabContent').append(
                        $('<div class="tab-pane" id="page' + pageNum +
                                '">Content page' + pageNum + '</div>'));

                $('#page' + pageNum).tab('show');
            });

            /**
             * Remove a Tab
             */
            $('#pageTab').on('click', ' li a .close', function() {
                var tabId = $(this).parents('li').children('a').attr('href');
                $(this).parents('li').remove('li');
                $(tabId).remove();
                reNumberPages();
                $('#pageTab a:first').tab('show');
            });

            /**
             * Click Tab to show its content
             */
            $("#queryTabs").on("click", "a", function(e) {
                e.preventDefault();
                $(this).tab('show');
            });

            $("#resultTabs").on("click", "a", function(e) {
                e.preventDefault();
                $(this).tab('show');
            });
        });

        //////////

        var setting = {
            view: {
                dblClickExpand: false
            },
            check: {
                enable: true
            },
            callback: {
                onRightClick: rightClickDBTree
            }
        };
        var zNodes = null;
        var zTree = null;
        var schemaMenu = null;
        var tableMenu = null;
        var columnMenu = null;
        function getDBTree() {
            $.ajax({
                type: "GET",
                data: {},
                dataType: 'json',
                contentType: "application/json",
                url: "/getDBTree",
                error: function (data) {
                    console.log(data);
                },
                success: function (data) {
//                    console.log(data);
                    zNodes = data.list;
                    $.fn.zTree.init($("#treeDemo"), setting, zNodes);
                    zTree = $.fn.zTree.getZTreeObj("treeDemo");
                    schemaMenu = $("#schemaMenu");
                    tableMenu = $("#tableMenu");
                    columnMenu = $("#columnMenu");
                }
            });
        }
        function rightClickDBTree(event, treeId, treeNode) {
            if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
                zTree.cancelSelectedNode();
                showRMenu("root", event.clientX, event.clientY);
            } else if (treeNode && !treeNode.noR) {
                zTree.selectNode(treeNode);
                showRMenu(treeNode.class, event.clientX, event.clientY);
//                showRMenu("node", event.clientX, event.clientY);
            }
        }

        function showRMenu(type, x, y) {
            $("#" + type + "Menu").show();
            if (type == "schema") {
                schemaMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
            }
            if (type == "table") {
                tableMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
            }
            if (type == "column") {
                columnMenu.css({"top":y+"px", "left":x+"px", "visibility":"visible"});
            }
            $("body").bind("mousedown", onBodyMouseDown);
        }
        function hideRMenu() {
            if (schemaMenu) rMenu.css({"visibility": "hidden"});
            $("body").unbind("mousedown", onBodyMouseDown);
        }
        function onBodyMouseDown(event){
            if (!(event.target.id == "schemaMenu" || $(event.target).parents("#schemaMenu").length>0)) {
                schemaMenu.css({"visibility" : "hidden"});
            }
            if (!(event.target.id == "tableMenu" || $(event.target).parents("#tableMenu").length>0)) {
                tableMenu.css({"visibility" : "hidden"});
            }
            if (!(event.target.id == "columnMenu" || $(event.target).parents("#columnMenu").length>0)) {
                columnMenu.css({"visibility" : "hidden"});
            }
        }

        function addQueryTab(schemaName, tableName, data) {
//            pageNum++;
            if ($('#' + schemaName + '_' + tableName + '_query').length <= 0) {
                $('#queryTabs').append(
                        $('<li><a href="#' + schemaName + '_' + tableName + '_query' + '">' +
                                schemaName + '.' + tableName +
                                '<button class="close" type="button" ' +
                                'title="Remove this page">×</button>' +
                                '</a></li>'));
                $('#resultTabs').append(
                        $('<li><a href="#' + schemaName + '_' + tableName + '_result' + '">' +
                                schemaName + '.' + tableName +
                                '<button class="close" type="button" ' +
                                'title="Remove this page">×</button>' +
                                '</a></li>'));
                $('#queryContents').append(
                        $('<div class="tab-pane" id="' + schemaName + '_' + tableName + '_query' +
                                '"><textarea style="height: 65%; width: 100%" id="' + schemaName + '_' + tableName + '_textarea' + '"></textarea>' + '</div>'));
                $('#resultContents').append(
                        $('<div class="tab-pane" id="' + schemaName + '_' + tableName + '_result' +
                                '"><table class="table table-bordered table-striped table-hover" style="height: 65%; width: 100%" id="' + schemaName + '_' + tableName + '_table' + '"></table>' + '</div>'));
//                $('#' + schemaName + '_' + tableName + '_result').tab('show');
//                $('#' + schemaName + '_' + tableName + '_result').tab('show');
                $('#' + schemaName + '_' + tableName + '_textarea').val(data.sql);
                $('#' + schemaName + '_' + tableName + '_result_textarea').val('ABC');
                displayResults($('#' + schemaName + '_' + tableName + '_table'), schemaName, tableName, data);
            }
        }

        function displayResults(table, schemaName, tableName, data) {
            table.append($('<thead><tr></tr></thead>'));
            table.append($('<tbody></tbody>'));
            var dataList = data.dataList;
            var columnList = new Array();
            if (dataList.length > 0) {
                var firstObj = dataList[0];
                for(colName in firstObj) {
                    table.find("thead").find("tr").append($('<th>' + colName + '</th>'));
                    columnList.push(colName);
                }
//                console.log(columnList);
                for(i = 0; i < dataList.length; i++) {
                    var row = "<tr>";

                    for (j in columnList) {
                        row = row + "<td><div style='height: 20px;' >" + dataList[i][columnList[j]] + "</div></td>";
                    }
                    row += "</tr>";
                    table.find("tbody").append(row);
//                    table.find("tbody").append('<tr></tr>');
//                    var trList = table.find("tbody").lastChild;
//                    console.log(trList);
//                    var lastTr = trList[trList.length - 1];
//                    console.log(lastTr);
//                    for (colName in columnList) {
//                        lastTr.append($('<th>' + dataList[i][colName] + '</th>'))
//                    }
                }
            }
        }

        function queryTable() {
            var sNodes = zTree.getSelectedNodes();
            var tableName = sNodes[0].name;
            var schemaName = sNodes[0].getPath()[0].name;
//            addQueryTab(schemaName, tableName);
            $.ajax({
                type: "GET",
                url: "/table/findTableData",
                dataType: 'json',
                contentType: "application/json",
                data: {
                    schemaName: schemaName,
                    tableName: tableName
                },
                success: function (data) {
                    console.log(data);
                    addQueryTab(schemaName, tableName, data);
                },
                error: function (data) {
                    alert("error");
                    console.log(data);
                }
            });
//            $('#queryResults').append(
//                    '<div class="tab-pane fade" id="' + schemaName + '.' + tableName + '_tab"><textarea style="width: 100%; height: 65%;"></textarea></div>'
//            );
//            $('#queryTabs').append(
//                    '<li><a href="#' + schemaName + '.' + tableName + '_tab" data-toggle="tab">' + schemaName + '.' + tableName + '</a></li>'
//            );
        }

        function createSchema() {
            var nodes = zTree.getPath();
            console.log(nodes);
        }

        $('#queryTabs').on("click", "a", function (e) {
            e.preventDefault();
            $(this).tab('show');
        });

        $(document).ready(function () {
//            $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            getDBTree();
//            zTree = $.fn.zTree.getZTreeObj("treeDemo");
//            rMenu = $("#rMenu");
//            $.fn.zTree.init($("#treeDemo"), setting, zNodes);

//            UE.getEditor('editor');
        });
    </script>
</head>
<body style="padding-top: 50px;">
<nav class="navbar navbar-inverse navbar-fixed-top" style="border: 0;">
    <div class="container-fluid">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">MySQL客户端</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">Dashboard</a></li>
                <li><a href="#">Settings</a></li>
                <li><a href="#">Profile</a></li>
                <li><a href="#">Help</a></li>
            </ul>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>
<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <ul id="treeDemo" class="ztree"></ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main" style="padding: 20px; height: 100%;">
            <div class="row-fluid" style="height: 33%; padding-bottom: 5px;">
                <div class="panel panel-default" style="height: 100%;">
                    <div class="panel-heading">执行区</div>
                    <ul id="queryTabs" class="nav nav-tabs">
                        <li class="active"><a href="#queryDiv" data-toggle="tab">Query</a></li>
                    </ul>
                    <div id="queryContents" class="tab-content">
                        <div class="tab-pane active" id="queryDiv">
                            <textarea id="query_textarea" style="width: 100%; height: 65%;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row-fluid" style="height: 33%; padding-bottom: 5px;">
                <div class="panel panel-default" style="height: 100%;">
                    <div class="panel-heading">执行区</div>
                    <ul id="resultTabs" class="nav nav-tabs">
                        <li class="active"><a href="#resultDiv" data-toggle="tab">Query</a></li>
                    </ul>
                    <div id="resultContents" class="tab-content">
                        <div class="tab-pane active" id="resultDiv">
                            <textarea id="result_textarea" style="width: 100%; height: 65%;"></textarea>
                        </div>
                    </div>
                </div>
            </div>
            <%--<div class="row-fluid" style="height: 33%;">--%>
                <%--<div class="panel panel-default" style="height: 100%;">--%>
                    <%--<div class="panel-heading">结果区</div>--%>
                    <%--<ul id="resultTabs" class="nav nav-tabs">--%>
                        <%--<li class="active"><a href="#resultDiv" data-toggle="tab">Query</a></li>--%>
                        <%--<li><a href="#resultDiv2" data-toggle="tab">Query</a></li>--%>
                    <%--</ul>--%>
                    <%--<div id="resultContents" class="tab-content">--%>
                        <%--<div class="tab-pane active" id="resultDiv">--%>
                            <%--wts--%>
                        <%--</div>--%>
                        <%--<div class="tab-pane" id="resultDiv2">--%>
                            <%--wts2--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        </div>
    </div>
</div>

<div id="schemaMenu">
    <ul>
        <li id="new_schema" onclick="createSchema();">新建数据库</li>
        <li id="del_schema">删除数据库</li>
        <li id="new_table">新建表</li>
        <li id="del_all_table">删除所有表</li>
    </ul>
</div>

<div id="tableMenu">
    <ul>
        <li id="select_table" onclick="queryTable()">查询100条数据</li>
        <li id="del_table">删除表</li>
        <li id="m_check">新建列</li>
    </ul>
</div>

<div id="columnMenu">
    <ul>
        <li id="select_column" onclick="queryTable();">查询100条数据</li>
        <li id="del_column">删除列</li>
        <li id="new_index">创建索引</li>
    </ul>
</div>
</body>
</html>

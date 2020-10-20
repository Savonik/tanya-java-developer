<%--
  Created by IntelliJ IDEA.
  User: Татьяна
  Date: 9/12/2020
  Time: 7:38 AM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>TODO-app</title>
    <style>
        body {
            background-color: powderblue;
        }

        h1 {
            color: #de1212;
        }
    </style>
    <style>
        .btn {
            display: inline-block;
            background: #8C959D;
            color: #fff;
            padding: 1rem 1.5rem;
            text-decoration: none;
            border-radius: 3px;
        }
    </style>
</head>

<body>
<h1>Welcome to To do App</h1>

<form name="createTaskForm" method="post" action="/todo/create-task">
    <label for="task_name">Enter your task mame: </label>
    <input id="task_name" type="text" name="task_name"><br><br>

    <label for="task_date">Enter deadline date: </label>
    <input id="task_date" type="date" name="task_date"><br><br>

    <input type="submit" value="Create" class="btn">
</form>

<br><br>

<form name="showListForm" method="get" action="/todo/task-list">
    <input id="show" type="submit" value="Show my tasks" class="btn">
</form>

<form name="showListForm" method="get" action="/todo/task-list-done">
    <input id="done" type="submit" value="Show done tasks" class="btn">
</form>

</body>
</html>

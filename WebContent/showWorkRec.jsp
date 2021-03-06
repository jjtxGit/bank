<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="com.shxt.vo.WorkerRec"%>
<%@page import="com.shxt.dao.WorkerRecDao"%>
<%@page import="com.shxt.vo.LoginRec"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	Object infor = session.getAttribute("username");
	if (infor == null) {
		response.sendRedirect("Error.html");
		return;
	}
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>

<script type="text/javascript">
	$(document).ready(function() {
		$(".click").click(function() {
			$(".tip").fadeIn(200);
		});

		$(".tiptop a").click(function() {
			$(".tip").fadeOut(200);
		});

		$(".sure").click(function() {
			$(".tip").fadeOut(100);
		});

		$(".cancel").click(function() {
			$(".tip").fadeOut(100);
		});

	});
</script>

<%
	WorkerRecDao workerRecDao = WorkerRecDao.getInstance();
	String localPageString = request.getParameter("page");

	int localPage = Integer.parseInt(localPageString);
	int begin = (localPage - 1) * 6;

	ArrayList<WorkerRec> aList = workerRecDao.getRecs(begin);

	int count = workerRecDao.getSum();

	int pages = 1;

	if (count >= 1) {

		pages = (count - 1) / 6 + 1;

	}
%>

</head>


<body>



	<div class="rightinfo">

		<div class="tools"></div>
		<table class="tablelist">
			<thead>
				<tr>
					<th>记录序列<i class="sort"><img src="images/px.gif" /></i></th>
					<th>操作者</th>
					<th>操作类型</th>
					<th>操作时间</th>
					<th>备注</th>
				</tr>
			</thead>

			<tbody>
				<%
					for (WorkerRec workerRec : aList) {
				%>
				<tr>
					<td><%=workerRec.getId()%></td>
					<td><%=workerRec.getUser()%></td>
					<td>
						<%
							if (workerRec.getType() == 1) {
									out.print("添加");
								} else if (workerRec.getType() == 2) {
									out.print("修改");
								} else {
									out.print("删除");
								}
						%>
					</td>
					<td><%=workerRec.getTime()%></td>
					<td><%=workerRec.getDes()%></td>

				</tr>

				<%
					}
				%>

			</tbody>
		</table>


		<div class="pagin">
			<div class="message">
				共<i class="blue"><%=count%></i>条记录，当前显示第&nbsp;<i class="blue"><%=localPage%>&nbsp;</i>页
			</div>

			<ul class="paginList">
				<%
					for (int i = 1; i <= pages; i++) {
				%>
				<li class="paginItem"><a href="showWorkRec.jsp?page=<%=i%>"><%=i%></a></li>
				<%
					}
				%>
			</ul>
		</div>
	</div>
	<script type="text/javascript">
		$('.tablelist tbody tr:odd').addClass('odd');
	</script>

</body>

</html>

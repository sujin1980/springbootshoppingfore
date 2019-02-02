<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>一级商品类型列表</title>
    <h1>一级商品类型列表</h1>
  </head>
  
  <body>
  <div class="with:80%">
	<table border="1">
		<tbody>
			<tr>
				<th>序号</th>
				<th>一级商品类型名称</th>
				<th>描述</th>
				<th>编辑</th>
				<th>删除</th>
			</tr>
			<c:if test="${!empty brands}">
				<c:forEach items="${ brands }" var="brand">
					<tr>
						<td>${brand.id}</td>
						<td>${brand.name}</td>
						<td>${brand.remarks}</td>
						<td><a href="<%=basePath%>/brand/toEdit2?id=${brand.id}">编辑</a></td>
						<td><a href="<%=basePath%>/brand/toDelete2?id=${brand.id}">删除</a></td>
					</tr>				
				</c:forEach>
			</c:if>
		</tbody>
		 <h6><a href="<%=basePath%>/brand/toAdd2">添加一级商品类型</a></h6>
	</table>
</div>	
  </body>
</html>

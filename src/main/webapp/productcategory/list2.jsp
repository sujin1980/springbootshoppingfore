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
			<c:if test="${!empty productcategorys}">
				<c:forEach items="${ productcategorys }" var="productcategory">
					<tr>
						<td>${productcategory.id}</td>
						<td>${productcategory.name}</td>
						<td>${productcategory.remarks}</td>
						<td><a href="<%=basePath%>/productcategory/toEdit2?id=${productcategory.id}">编辑</a></td>
						<td><a href="<%=basePath%>/productcategory/toDelete2?id=${productcategory.id}">删除</a></td>
					</tr>				
				</c:forEach>
			</c:if>
		</tbody>
		 <h6><a href="<%=basePath%>/productcategory/toAdd2">添加一级商品类型</a></h6>
	</table>
</div>	
  </body>
</html>

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
    <title>编辑一级商品类型</title>
       <h1>编辑一级商品类型</h1>
  </head>
  
  <body>
	<form action="/producttype/edit2" name="producttypeForm" method="post">
		<input type="hidden" name="id" value="${producttype.id }"/>
		一级商品类型名称：<input type="text" name="name" value="${producttype.name }"/>
		描述：<input type="text" name="remarks" value="${producttype.remarks }"/>
		<input type="submit" value="提交" />
		 &nbsp; &nbsp; &nbsp;
        <input type="reset" value="重置"  />
	</form>
  </body>
  
</html>

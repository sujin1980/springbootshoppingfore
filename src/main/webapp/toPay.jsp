<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body style="font-size: 30px">

<form method="post" action="/alipay/wap/alipage">
    <h3>购买商品：越南新娘</h3>
    <h3>价格：20000</h3>
    <h3>数量：2个</h3>

    <button style="width: 100%; height: 60px; alignment: center; background: blue" type="submit">支付</button>
</form>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta charset="UTF-8">
    <base href="<%=basePath%>">
    <title>订单商品信息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	
	<link rel="stylesheet" type="text/css" href="common/css/client.css"/>
	<link rel="stylesheet" type="text/css" href="common/css/style.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">

	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
</head>

<script type="text/javascript">




function account(){
	

	
	var idlist = {};
	  
	
	 
	 idlist[0] = 1;
	 idlist[1] = 2;
	$.ajax({
	    	dataType: "json",  
	        type: "POST",
	        data: idlist,
			url : '/ordergoods/findGoodsByOrderList.do',
			async: false, 
			success : function(data) {
				 if(data == null){
					 alert("用户没有订单信息");
					 return;
				 }
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("fail==");
			}
	}); 
}

function login() {
	var idlist = {};
	  
	
	 $.ajax({ 
	        type: "POST",
			url : '/alipay/wap/alipage.do',
			async: true, 
			success : function(data) {
				alert("OK");
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				alert("fail");
			}
		});
}


</script> 

<body style="font-size: 30px">

<form id="form1" onsubmit="return false" action="##" method="post">
    <h3>购买商品：越南新娘</h3>
    <h3>价格：20000</h3>
    <h3>数量：2个</h3>

    <p><input type="button" value="支付" onclick="login()">
</form>

</body>
</html>
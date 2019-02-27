<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <base href="<%=basePath%>">
  <meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>美酒商城</title>
	
	<link rel="stylesheet" type="text/css" href="css/client.css"/>
		<link rel="stylesheet" type="text/css" href="css/style.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">

	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
  </head>

<script type="text/javascript">

$(function(){
	initOrderGoodsinfo();
}) 

function initOrderGoodsinfo(){
	var idlist = {};
	 
	idlist[0] = ${sessionScope.clientorder.id}; 
	$.ajax({
    	dataType: "json",  
        type: "POST",
        data: idlist,
		url : '/ordergoods/findGoodsByOrderList.do',
		async: false, 
		success : function(data) {
			 if(data == null){
				 console.log("用户没有订单信息");
				 return;
			 }
			 updateOrderGoodsInfo(data); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("fail");
		}
	}); 
}

function getProductById(productid){
	window.location.href = "/product/toEdit2?id=" + productid;
	return;
}

function updateOrderGoodsInfo(data){
	$("#order-m-list").html("");
	var thtmlbody = "";
	for(var i = 0; i < data.length; i++){
		thtmlbody += "<li>";
		thtmlbody += "<a href=\"javascript:void(0);\" style=\"width:100px;display:inline\" onclick=\"getProductById(" + data[i].goodsId + ")\" >";
		thtmlbody += " <img src=\"" + data[i].picture + "\"" + " width=\"34\" height=\"34\" onerror=\"this.src='common/images/default.gif;this.onerror=null'\">"; 
		thtmlbody += "<span class=\"shopping-client-smalltext\">" +  data[i].goodsName + "*" + data[i].goodsNumber + "&nbsp;</span>" + "</a>";
		thtmlbody += "<br>";
		thtmlbody += "<span class=\"shopping-client-smalltext\" style=\"float:right;\">" +  data[i].remarks + "&nbsp;</span>";
		thtmlbody += "<span class=\"shopping-client-smalltext\" style=\"float:right;\">&nbsp;&nbsp;" +  "金额：" + data[i].totalFee + "&nbsp;&nbsp;</span>";
		thtmlbody += "</li>";	
	}
	console.log(thtmlbody);
	$("#order-m-list").html(thtmlbody);
	return;	
}

function account(){
	window.location.href = "/order/account.jsp";
	
	
}

</script> 

<body>
	<div class="easyui-navpanel">
		<header>
			<div class="m-toolbar" style="justify-content:center;align-items:center;height:40px;">
			    <span class="m-title" style="font-size:20px;">订单商品信息</span>
			    <div class="m-left">
	                <a href="javascript::void(0)" onclick="$.mobile.back()">
	                	<img src="images/back.png" style="margin-top:5;" width="34px" height="34px" onerror="this.src='common/images/default.gif;this.onerror=null'">
	                </a>
	            </div>   
		    </div>
		</header>
		<div  style="height:100%;width:100%;z-index:1;" >
			<div id="orderstatus" style="margin-top:10px" data-options="tabHeight:60,tabPosition:'top',border:false,pill:true,narrow:true,justified:true">
				<div style="padding:10px">
					<span class="shopping-client-text">${sessionScope.clientorder.clientChineseName}&nbsp;&nbsp;</span>
					<span class="shopping-client-text">${sessionScope.clientorder.receiverMobile}&nbsp;&nbsp;</span>
				</div>
				
			</div>	
		
			<div id="ordersinfo" style="padding:5px;" >
				<ul class="m-list" id="order-m-list"  style="padding:10px;">
					<li>
						
					</li>
			    </ul>
			</div>	
			<div margin-top:30px">
				<span class="shopping-client-text" style="margin-left:50px;">总计： ${sessionScope.clientorder.payment}</span>
			</div>	
			
			<div style="text-align:center;margin-top:30px">
				<form method="post" action="/alipay/wap/alipage">
					<button style="width:80%;height:60px;background:#FF1493" type="submit">支付</button>
				</form>
			</div>
			<!---
			<div style="text-align:center;margin-top:30px">
		        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="account();" style="width:80%;height:60px;background:#FF1493">
					<span  class="shopping-client-text">去支付</span>
				</a>
		    </div>
		    --->
		</div>	
	</div>
  </body>
  </html>

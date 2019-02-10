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
				 alert("用户没有订单信息");
				 return;
			 }
			 updateOrderGoodsInfo(data); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("fail");
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
		thtmlbody += " <img src=\"" + data[i].picture + "\"" + " width=\"50\" height=\"50\" onerror=\"this.src='common/images/default.gif;this.onerror=null'\">"; 
		thtmlbody += "<span class=\"shopping-client-text\">" +  data[i].goodsName + "*" + data[i].goodsNumber + "&nbsp;</span>" + "</a>";
		thtmlbody += "<br>";
		thtmlbody += "<span class=\"shopping-client-text\" style=\"float:right;\">" +  data[i].remarks + "&nbsp;</span>";
		thtmlbody += "<span class=\"shopping-client-text\" style=\"float:right;\">&nbsp;&nbsp;" +  "金额：" + data[i].totalFee + "&nbsp;&nbsp;</span>";
		thtmlbody += "</li>";	
	}
	console.log(thtmlbody);
	$("#order-m-list").html(thtmlbody);
	return;	
}

function account(){
	//window.location.href = "order/account.jsp";
}

</script> 

<body>
	<div class="easyui-navpanel">
		<header>
			<div class="m-toolbar" style="justify-content:center;align-items:center;height:80px;">
				<span class="m-title" style="font-size:28px;"><br>订单商品信息</span>
		        <div class="m-left">
	                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true,back:true">
	                	<span class="shopping-client-text">回退</span>
	                </a>
	            </div>   
		    </div>
		</header>
		<div  style="height:100%;width:100%;z-index:1;" >
			<div id="orderstatus" style="margin-top:60px" data-options="tabHeight:60,tabPosition:'top',border:false,pill:true,narrow:true,justified:true">
				<div style="padding:20px">
					<span class="shopping-client-text">${sessionScope.clientorder.clientChineseName}&nbsp;&nbsp;</span>
					<span class="shopping-client-text">${sessionScope.clientorder.receiverMobile}&nbsp;&nbsp;</span>
				</div>
				
			</div>	
		
			<div id="ordersinfo" style="padding:10px;" >
				<ul class="m-list" id="order-m-list"  style="padding:10px;">
					<li>
						
					</li>
			    </ul>
			</div>	
			<div margin-top:30px">
				<span class="shopping-client-text" style="margin-left:50px;">总计： ${sessionScope.clientorder.payment}</span>
			</div>	
			<div style="text-align:center;margin-top:30px">
		        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="account();" style="width:80%;height:60px;background:#FF1493">
					<span  class="shopping-client-text">去支付</span>
				</a>
		    </div>
		    
		</div>	
	</div>
  </body>
  </html>

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
    <title>我的商城</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	
	<link rel="stylesheet" type="text/css" href="common/css/style.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">

	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
  </head>

<script type="text/javascript">


var orderList = {
	id:                Array(),
	clientName:        Array(),
	status:            Array(),
	paymentTime:       Array(),
	consignTime:       Array(),
	receiverMobile:    Array(),
	receiverAreaName:  Array(),
	
	goodsId:   Array(),
	price:     Array(),
	goodsFee:  Array(),
	picture:   Array(),
	price:     Array(),
	totalFee:  Array(),
	remarks:   Array(),
	goodsName: Array(),
	goodsnum:  Array(),
};

$(function(){
	initOrderList();//"${ orders }");*/
	alert(window.location.href);
	
	$('#orderstatus').tabs({
		onSelect: function(title,index){
			updateOrdersinfo();
		return;
	  }
	});

}) 

function updateOrdersinfo(){
	$("#order-m-list").html("");
	var thtmlbody = "";
	for(var i = 0; i < orderList.length; i++){
		thtmlbody += "<li>";
		thtmlbody += "<span>" + orderList[i].goodsName[0] + "</span>" + "<span style=\"float:right;\">" + orderList[i].status + "</span>" + "|";
		thtmlbody += "<a href=\"javascript:void(0);\">" ;
		thtmlbody += "<img src=\"images/delete.png\"" + " style=\"float:right;\"" +  " onerror=\"this.src='common/images/default.gif;this.onerror=null'\"> </a>";
		
		thtmlbody += "<span style=\"float:right;\">共1件商品</span>" + "<span style=\"float:right;\">实付金额：" + orderList[i].payment + "</span>";
		thtmlbody += "</li>";
		
	}
	console.log(thtmlbody);
	$("#order-m-list").html(thtmlbody);
	return;	
}

function getProductById(productid){
	window.location.href = "/product/toEdit2?id=" + productid;
	return;
}
	
function updateOrderGoodsInfo(data){
	for(var i= 0; i< orderList.length; i++){
		orderList[i].goodsnum = 0;
		for(var j = 0; j < data.length; j++){
			if(orderList[i].id == data[j].orderId){
				orderList[i].goodsId[goodsnum]   = data[j].goodsId;
				orderList[i].price[goodsnum]     = data[j].price;
				orderList[i].goodsFee[goodsnum]  = data[j].goodsFee;
				orderList[i].picture[goodsnum]   = data[j].picture;
				orderList[i].price[goodsnum]     = data[j].price;
				orderList[i].totalFee[goodsnum]  = data[j].totalFee;
				orderList[i].remarks[goodsnum]   = data[j].remarks;
				orderList[i].goodsName[goodsnum] = data[j].goodsName;
				orderList[i].goodsnum++;
			}
		}
	}
	
}
function updateOrderDetailInfo(data){
	 var idlist = {};
	 /*
	 var s_keySearch = {
	      key_name:Array(),
	      key_index:Array(),
	      key_count:Array(),
	      key_scount:Array()
	   };
	  
	  for(i=0;i<3;i++){
	   s_keySearch.key_name[i]="内衣"+i;
	   s_keySearch.clientName[i]= i;
	   s_keySearch.status[i]= i*100;
	   s_keySearch.paymentTime[i]=i*10;
	  }*/
		  
	 for(var i= 0; i< data.length; i++){
		  orderList.id[i]               = data[i].id;
		  orderList.clientName[i]       = data[i].clientName;
		  orderList.status[i]           = data[i].status;
		  orderList.paymentTime[i]      = data[i].paymentTime;
		  orderList.consignTime[i]      = data[i].consignTime;
		  orderList.receiverMobile[i]   =  data[i].receiverMobile;
		  orderList.receiverAreaName[i] = data[i].receiverAreaName; 
		  
		  idlist[i] = data[i].id;
	}
	 
	$.ajax({
	    	dataType: "json",  
	        type: "POST",
	        data: idlist,
			url : '/ordergoods/findGoodsByOrderList.do',
			async: true, 
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

function initOrderList(){
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"clientName": '${sessionScope.loginClient.name}'
		},
		async: true, 
		url : '/order/getOrderListByClientName.do',
		success : function(data) {
			 if(data == null){
				 alert("用户没有订单信息");
				 return;
			 }
			 updateOrderDetailInfo(data); 
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("fail");
		}
	});
}

</script> 

<body>
	<div class="easyui-navpanel">
		<header>
		    <div class="m-toolbar">
				<span class="m-title">我的订单</span>
		        <div class="m-left">
	                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true,back:true">回退</a>
	            </div>   
		    </div>
		</header>
		<div  style="height:100%;width:100%;z-index:1;" >
			<div style="padding:10px;height:50px;width:100%;z-index:1;" >
				<input class="easyui-textbox" id="address" data-options="prompt:'商品名称/商品编号/订单号'  "  style="width:70%;height:38px">
				<a id="btn" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="margin:10px;height:38px">搜索</a>
			</div>
			<br />
			
			<div id="orderstatus" class="easyui-tabs" data-options="tabHeight:60,tabPosition:'top',border:false,pill:true,narrow:true,justified:true">
				<div style="padding:10px">
					<div class="panel-header tt-inner">
						<span>所有订单</span>
					</div>
				</div>
				<div style="padding:10px">
					<div class="panel-header tt-inner">
						<span>待付款</span>
					</div>
				</div>
				<div style="padding:10px">
					<div class="panel-header tt-inner">
						<span>待收货</span>
					</div>
				</div>
				<div style="padding:10px">
					<div class="panel-header tt-inner">
						<span>已完成</span>
					</div>
				</div>
			</div>	
		
			<div id="ordersinfo" style="padding:10px;" >
				<ul class="m-list" id="order-m-list"  style="padding:10px;">
					
			    </ul>
			</div>	
		</div>	
	</div>
  </body>
  </html>

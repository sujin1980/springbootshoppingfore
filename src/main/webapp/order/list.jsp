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



var orderList = new Array();

$(function(){
	initOrderList();//"${ orders }");*/
	//alert(window.location.href);
	
	var ordertype = new Object();
	if(window.location.href.indexOf("?") > 0 ){
		var equalPos = window.location.href.indexOf("=");
		if(equalPos > 0){
			ordertype = window.location.href.substr(equalPos + 1);
		}
	}
	
	switch(ordertype)
	{
	case "0":
		$('#orderstatus').tabs('select', 0);
		break;
	
	case "3":
		$('#orderstatus').tabs('select', 1);
		break;
	
	case "4":
		$('#orderstatus').tabs('select', 2);
		break;
	
	default:
		$('#orderstatus').tabs('select', 0);
		break;
	}
	

	
	var tab = $('#orderstatus').tabs('getSelected');
	var index = $('#orderstatus').tabs('getTabIndex',tab);

	
	updateOrdersinfo(index);
	
	console.log("selected = " + index);
	console.log("ordertype = " + ordertype);
	$('#orderstatus').tabs({
		onSelect: function(title,index){
			updateOrdersinfo(index);
		return;
	  }
	});
	
	$("#querycondition").textbox('textbox').css("font-size", "28px");
}) 

function updateOrdersinfo(statusfilter){
	$("#order-m-list").html("");
	var thtmlbody = "";
	for(var i = 0; i < orderList.length; i++){
		if(orderList[i].goodsnum > 0){
			if((statusfilter == 0) || ((statusfilter == 3) && (orderList[i].status == "未付款"))
				|| ((statusfilter == 4) && ((orderList[i].status == "已付款") || (orderList[i].status == "未发货") || (orderList[i].status == "已发货") ))) {
				thtmlbody += "<li>";
				thtmlbody += "<span class=\"shopping-client-text\" style=\"display:inline\">" + orderList[i].clientChineseName + "</span>";
				thtmlbody += "<a href=\"javascript:void(0);\" style=\"width:90px; float:right;display:block;\" onclick=\"deleteOrderById(" + 
					orderList[i].id + ")\" >";
				thtmlbody += "<img src=\"images/delete.png\" style=\"float:right;display:block;\" width=\"50\" height=\"50\""
					+ "onerror=\"this.src='common/images/default.gif;this.onerror=null'\">";
				thtmlbody += "</a>";
				thtmlbody += "<span class=\"shopping-client-text\" style=\"float:right;\">&nbsp;&nbsp;&nbsp;" + orderList[i].status + "&nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;</span>"; 
				thtmlbody += "<br /><br /><br />";	
				
				for(var j = 0; j < orderList[i].goodsnum; j++){
					thtmlbody += "<a href=\"javascript:void(0);\" style=\"width:100px;display:inline\" onclick=\"getProductById(" + orderList[i].goodsList[j].goodsId + ")\" >";
					thtmlbody += " <img src=\"" + orderList[i].goodsList[0].picture + "\"" + " width=\"50\" height=\"50\" onerror=\"this.src='common/images/default.gif;this.onerror=null'\">"; 
					thtmlbody += "<span class=\"shopping-client-text\">" + orderList[i].goodsList[j].goodsName + "&nbsp;</span>" + "</a>";
				}
				thtmlbody += "<br /><br /><br />";
				
				thtmlbody += "<span class=\"shopping-client-text\" style=\"float:right;\">&nbsp;实付金额：" + orderList[i].payment + "&nbsp;</span>";
				thtmlbody += "<span class=\"shopping-client-text\" style=\"float:right;\">&nbsp;共" + orderList[i].goodsnum + "件商品&nbsp;</span>";
				thtmlbody += "</li>";
			}
		}
	}
	console.log(thtmlbody);
	$("#order-m-list").html(thtmlbody);
	return;	
}

function deleteOrderById(productid){
	window.location.href = "/order/toDelete2?id=" + productid;
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
				var  goodsinfo = new Object();
				goodsinfo.goodsId   = data[j].goodsId;
				goodsinfo.price     = data[j].price;
				goodsinfo.goodsFee  = data[j].goodsFee;
				goodsinfo.picture   = data[j].picture;
				goodsinfo.price     = data[j].price;
				goodsinfo.totalFee  = data[j].totalFee;
				goodsinfo.remarks   = data[j].remarks;
				goodsinfo.goodsName = data[j].goodsName;
				orderList[i].goodsList.push(goodsinfo);
				orderList[i].goodsnum++;
			}
		}
	}
}
function updateOrderDetailInfo(data){
	 var idlist = {};
		  
	 for(var i= 0; i< data.length; i++){
		  var  goodsorder = new Object();
		  goodsorder.id               = data[i].id;
		  goodsorder.clientName       = data[i].clientName;
		  goodsorder.clientChineseName = data[i].clientChineseName;
		  goodsorder.status           = data[i].status;
		  goodsorder.payment          = data[i].payment;
		  goodsorder.paymentTime      = data[i].paymentTime;
		  goodsorder.consignTime      = data[i].consignTime;
		  goodsorder.receiverMobile   =  data[i].receiverMobile;
		  goodsorder.receiverAreaName = data[i].receiverAreaName; 
		  goodsorder.goodsList = new Array();
		  orderList.push(goodsorder);
		  idlist[i] = data[i].id;
	}
	 
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

function initOrderList(){
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"clientName": '${sessionScope.loginClient.name}'
		},
		async: false, 
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
			<div class="m-toolbar" style="justify-content:center;align-items:center;height:80px;">
				<span class="m-title" style="font-size:28px;"><br>我的订单</span>
		        <div class="m-left">
	                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true,back:true">
	                	<span class="shopping-client-text">回退</span>
	                </a>
	            </div>   
		    </div>
		</header>
		<div  style="height:100%;width:100%;z-index:1;" >
			<div style="padding:30px;height:50px;width:100%;z-index:1;" >
				<input class="easyui-textbox" id="querycondition" data-options="prompt:'商品名称/商品编号/订单号'  "  style="width:70%;height:60px">
					<a id="btn" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="margin:10px;height:60px">
						<span class="shopping-client-text">搜索</span>
	                </a>
			</div>
			
			<div id="orderstatus" class="easyui-tabs" style="margin-top:60px" data-options="tabHeight:60,tabPosition:'top',border:false,pill:true,narrow:true,justified:true">
				<div style="padding:10px">
					<div class="panel-header tt-inner">
						<span class="shopping-client-text">所有订单</span>
					</div>
				</div>
				<div style="padding:10px">
					<div class="panel-header tt-inner">
						<span class="shopping-client-text">待付款</span>
					</div>
				</div>
				<div style="padding:10px">
					<div class="panel-header tt-inner">
						<span class="shopping-client-text">待收货</span>
					</div>
				</div>
				<div style="padding:10px">
					<div class="panel-header tt-inner">
						<span class="shopping-client-text">已完成</span>
					</div>
				</div>
			</div>	
		
			<div id="ordersinfo" style="padding:10px;" >
				<ul class="m-list" id="order-m-list"  style="padding:10px;">
					<li>
						
					</li>
			    </ul>
			</div>	
		</div>	
	</div>
  </body>
  </html>

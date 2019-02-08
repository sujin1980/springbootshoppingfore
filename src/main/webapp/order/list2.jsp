<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

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
$(function(){
	$('#orderstatus').tabs({
		onSelect: function(title,index){
		return;
	  }
	});
	
	updateOrderList("${ orders }");
}) 

function getProductById(productid){
	window.location.href = "/product/toEdit2?id=" + productid;
	return;
}
	
function updateOrderList(data){
	console.log(data);
	if((data != null) && (data.length != 0)) {
		$("#order-m-list").html("");
		var thtmlbody = "";
		for(var i= 0; i< data.length; i++){

			thtmlbody += "<li>";
			thtmlbody += "<span>美酒商城</span>" + "<span style=\"float:right;\">" + data.status + "</span>" + "|";
			thtmlbody += "<a href=\"javascript:void(0);\">" ;
			thtmlbody += "<img src=\"images/delete.png\"" + " style=\"float:right;\"" +  " onerror=\"this.src='common/images/default.gif;this.onerror=null'\"> </a>";
			
			thtmlbody += "<span style=\"float:right;\">共1件商品</span>" + "<span style=\"float:right;\">实付金额：" + data.payment + "</span>";
		}
		
		console.log(thtmlbody);
		$("#order-m-list").html(thtmlbody);
	}
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
			<div id="orderstatus" class="easyui-tabs" data-options="tabHeight:60,fit:true,tabPosition:'top',border:false,pill:true,narrow:true,justified:true">
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

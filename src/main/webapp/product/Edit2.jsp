<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>美酒商城</title>
	
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/client.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">
	
	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
  </head>

<script type="text/javascript">

$(document).ready(function (){
	$('#mm').menu({
	    onClick:function(item){
	    	if(item.index == "首页"){
	    		window.location.href = "mainFrame.jsp";
	    	}else if(item.index == "我的商城"){
	    		console.log("登录用户基本信息页");
	    	}else{
	    		console.log("登录分享");
	    	}
	    }
	});
	
	initProductInfo();
}); 

function getProductById(productid){
	window.location.href = "/product/toEdit2?id=" + productid;
	return;
}

function initProductInfo(){
	//console.log('${product.name}');
	$('#goodsbaseinfo').css("display","block");
	$('#goodsdetails').css("display","none");
	return;	
}

function goodsBaseInfo(){
	$('#goodsbaseinfo').css("display","block");
	$('#goodsdetails').css("display","none");
	return;	
}

function goodsDetails(){
	$('#goodsdetails').css("display","block");
	$('#goodsbaseinfo').css("display","none");
	return;	
}

function addGoodsToOrder(){
	return;	
}

function buyNow(){
	console.log("productid = " + ${product.id});
	$.ajax({
        type: "POST",
		data: {
			"goodsid": ${product.id}
		},
		url : '/product/buyNow.do',
		success : function(data) {
			if(data == "OK"){
				window.location.href = "order/Edit.jsp";
			}else if(data == "NOORDER"){
				console.log("目前没有订单，请联系客服添加 ");
				//window.location.href = "client/Edit2.jsp";
			}else if(data == "NOLOGIN"){
				//console.log("转入客户登录");
				window.location.href = "client/login.jsp";
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("fail");
		}
	});
	return;
}

</script> 

<body class="easyui-layout">
			<div data-options="region:'north',split:false,border:true" style="justify-content:center;align-items:center;overflow:hidden;height:40px;width:100%;z-index:1">
				    <div class="m-toolbar" style="justify-content:center;align-items:center;height:40px">
						<span class="m-title"  style="font-size:28px;padding:15px;">
							<a href="javascript:void(0);" onclick="goodsBaseInfo()" class="shopping-client-text">商品</a>
							<a href="javascript:void(0);" onclick="goodsDetails()" class="shopping-client-text">详情</a>
							<a href="javascript:void(0);" class="shopping-client-text">推荐</a>
						</span>
			        
						<div class="m-left">
			                <a href="javascript::void(0)" onclick="$.mobile.back()">
			                	<img src="images/back.png" style="margin-top:5;" width="34px" height="34px" onerror="this.src='common/images/default.gif;this.onerror=null'">
			                </a>
			            </div>
						<div class="m-right">
							<a href="javascript:void(0);" class="easyui-menubutton" data-options="iconCls:'icon-more',plain:true,hasDownArrow:false,menu:'#mm',menuAlign:'right'"></a>
						</div>
					</div>
					<div id="mm" class="easyui-menu" style="width:50px;" data-options="itemHeight:20,noline:true">
						<div>
							首页
						</div>
						<div>
							我的商城
						</div>
						<div>
							分享         
						</div>
					</div>
			</div>
			<div data-options="region:'south',split:false,border:true" style="height:60px;width:100%;z-index:1">  
	            <div class="m-buttongroup m-buttongroup-justified" style="height:60px;width:100%">
	                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="size:'large',iconAlign:'top',plain:true">
	                	<span class="shopping-client-text">联系客户</span>
	                </a>
	                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="size:'large',iconAlign:'top',plain:true">
	                	<span class="shopping-client-text">订单</span>
	                </a>
	                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="addGoodsToOrder()" data-options="size:'large',iconAlign:'top',plain:true">
	                	<span class="shopping-client-text">加入订单</a>
	                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="buyNow()" data-options="size:'large',iconAlign:'top',plain:true">
	                	<span class="shopping-client-text">立即购买</span>
	                </a>
	            </div>
	        </div>
        
			<div data-options="region:'center',split:false,border:true"  id="goodsinfo" style="background:#C71585;padding:20px;height:100%;width:100%;z-index:1">
			    <div id="goodsbaseinfo" style="text-align:center; align-items:center;height:100%;width:100%;">
			    	
			    	<span id="goodsname" class="shopping-client-text">${product.name}</span></br>
			    	<span id="goodsprice" class="shopping-client-text">${product.price}</span>
			    	<span class="shopping-client-text">元</span></br>
			    	<img  id="productimage" src="${product.icon}" onerror="this.src='common/images/default.gif;this.onerror=null'" /></br>
			    	<span id="goodsremarks" class="shopping-client-text">${product.remarks}</span>
			    </div>
			     <div id="goodsdetails" style="text-align:center; align-items:center;height:100%;width:100%;>
			    	<span id="goodsremarks2" class="shopping-client-text">${product.remarks}</span>
			    </div>
			</div>
	
  </body>
  </html>

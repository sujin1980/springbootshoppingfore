<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>欢迎登录后台管理系统</title>
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

$(document).ready(function (){
	$('#mm').menu({
	    onClick:function(item){
	    	if(item.index == "首页"){
	    		window.location.href = "mainFrame.jsp";
	    	}else if(item.index == "我的商城"){
	    		alert("登录用户基本信息页");
	    	}else{
	    		alert("登录分享");
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
	//alert('${product.name}');
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
	alert("productid = " + ${product.id});
	$.ajax({
        type: "POST",
		data: {
			"goodsid": ${product.id}
		},
		url : '/product/buyNow.do',
		success : function(data) {
			if(data == "OK"){
				alert("转入客户订单页面");
			}else{
				alert("转入客户登录");
				window.location.href = "login.jsp";
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("fail");
		}
	});
	return;
}

</script> 

<body>
		<div class="easyui-navpanel">
			<header>
			    <div class="m-toolbar">
			       
						<span class="m-title">
							<nav>
								<a href="javascript:void(0);" onclick="goodsBaseInfo()">商品</a>&nbsp;&nbsp;&nbsp; 
								<a href="javascript:void(0);" onclick="goodsDetails()">详情</a>&nbsp;&nbsp;&nbsp;
								<a href="javascript:void(0);">推荐</a>
							</nav>
						</span>
			        
			        <div class="m-left">
		                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true" onclick="$.mobile.back()">回退</a>
		            </div>
		            <div class="m-right">
		                <a href="javascript:void(0);" class="easyui-menubutton" data-options="iconCls:'icon-more',plain:true,hasDownArrow:false,menu:'#mm',menuAlign:'right'"></a>
		            </div>
			    </div>
			    <div id="mm" class="easyui-menu" style="width:150px;" data-options="itemHeight:30,noline:true">
		            <div>首页</div>
		            <div>我的商城</div>
		            <div>分享</div>
		        </div>
			</header>
			<footer>
	            <div class="m-buttongroup m-buttongroup-justified" style="width:100%">
	                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="size:'large',iconAlign:'top',plain:true">联系客户</a>
	                <a href="javascript:void(0)" class="easyui-linkbutton" data-options="size:'large',iconAlign:'top',plain:true">订单</a>
	                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="addGoodsToOrder()" data-options="size:'large',iconAlign:'top',plain:true">加入订单</a>
	                <a href="javascript:void(0)" class="easyui-linkbutton" onclick="buyNow()" data-options="size:'large',iconAlign:'top',plain:true">立即购买</a>
	            </div>
	        </footer>
        
			<div id="goodsinfo" style="background:#C71585;padding:5px;height:100%;width:100%;z-index:1">
			    <div id="goodsbaseinfo" style="text-align:center; align-items:center;height:100%;width:100%;">
			    	
			    	<span id="goodsname">${product.name}</span></br>
			    	<span id="goodsprice">${product.price}</span>
			    	<span>元</span></br>
			    	<img  id="productimage" src="${product.icon}" onerror="this.src='common/images/default.gif;this.onerror=null'" /></br>
			    	<span id="goodsremarks">${product.remarks}</span>
			    </div>
			     <div id="goodsdetails" style="text-align:center; align-items:center;height:100%;width:100%;>
			    	<span id="goodsremarks2">${product.remarks}</span>
			    </div>
			</div>
										
		</div>
  </body>
  </html>

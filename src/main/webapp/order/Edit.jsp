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
		<footer >
	        <div class="m-buttongroup m-buttongroup-justified" style="height:90px;width:100%">
			    
	            <input type="checkbox" class="shopping-checkbox" style="margin:20px; height:30px;width:30px;" name="goodsall" >
	            <span class="shopping-client-text">全选</span>
		       
	            <span class="shopping-client-text" style="margin-left:50px;">总计： + ''</span>
	            
	            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="addGoodsToOrder()" style="background-color:#3CB371;" data-options="size:'large',iconAlign:'top',plain:true">
	            	<span class="shopping-client-text" style="color:#FFFFFF">继续添加商品</span>
	            </a>
	            <a href="javascript:void(0)" class="easyui-linkbutton" onclick="addGoodsToOrder()" style="background-color:#FF1493;" data-options="size:'large',iconAlign:'top',plain:true">
	            	<span class="shopping-client-text" style="color:#FFFFFF">去结算</span>
	            </a>
	        </div>
	    </footer>
		<div  style="height:100%;width:100%;z-index:1;" >
			
			
			<div id="orderstatus" style="margin-top:60px" data-options="tabHeight:60,tabPosition:'top',border:false,pill:true,narrow:true,justified:true">
				<div style="padding:20px">
					<span class="shopping-client-text">美酒商城</span>
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

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
	    }
	});
	
}); 

function getProductById(productid){
	window.location.href = "/product/toEdit2?id=" + productid;
	return;
}
</script> 

<body>
		<div class="easyui-navpanel">
			<header>
			    <div class="m-toolbar">
			        <div class="m-title" id="linknav" style="height:50px;">
						<ul class="nav" style="text-align:center;list-style-type:none;">
							<li styple="display:inline;list-style-type:none;"><a href="javascript:void(0)">商品</a></li><li styple="display:inline;list-style-type:none;"><a href="javascript:void(0)">详情</a></li><li styple="display:inline;list-style-type:none;"><a href="javascript:void(0)">推荐</a></li>
						</ul>
			        </div>
			        <div class="m-left">
		                <a href="#" class="easyui-linkbutton m-back" data-options="plain:true,outline:true">回退</a>
		            </div>
		            <div class="m-right">
		                <a href="javascript:void(0)" class="easyui-menubutton" data-options="iconCls:'icon-more',plain:true,hasDownArrow:false,menu:'#mm',menuAlign:'right'"></a>
		            </div>
			    </div>
			    <div id="mm" class="easyui-menu" style="width:150px;" data-options="itemHeight:30,noline:true">
		            <div>首页</div>
		            <div>我的商城</div>
		            <div>分享</div>
		        </div>
			</header>
			<div id="productlist" style="background:#C71585;padding:5px;height:100%;width:100%;z-index:1">
			    <ul class="m-list" id="product-m-list">
			    </ul>
			</div>
										
		</div>
  </body>
  </html>

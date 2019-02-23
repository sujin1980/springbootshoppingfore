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
	<link rel="stylesheet" type="text/css" href="common/css/client.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">

	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
  </head>

<script type="text/javascript">
$(function () {
	

	$('#goodsname').textbox({
	    onChange:function(newvalue, oldvalue){
			//console.log(title+' is selected');
			console.log(newvalue);
			findGoodsByName();
	    }
	});
	$("#goodsname").textbox('textbox').css("font-size", "48px");
}); 

function getProductById(productid){
	window.location.href = "/product/toEdit2?id=" + productid;
	return;
}

function updateProductList(data){
	if((data != null) && (data.length != 0)) {
		$("#product-m-list").html("");
		var thtmlbody = "";
		for(var i= 0; i< data.length; i++){
			thtmlbody += "<li><a href=\"javascript:void(0);\" onclick=\"getProductById("
				+ data[i].id +  ")\">";
			thtmlbody += "<img src=\""+ data[i].icon + "\"" + 
			    "alt=\"" + data[i].name + "的图片\"  onerror=\"this.src='common/images/default.gif;this.onerror=null'\"></ br>"
			    + data[i].name + "</ br>" + data[i].price + "元</a></li>";
		}
		
		console.log(thtmlbody);
		$("#product-m-list").html(thtmlbody);
	}
}	

function findGoodsByName(){
	//alert("newvalue = " + $("#goodsname").val());
	$.ajax({
		type : "POST",
		url : "product/getproductbyname.do",
		data:{
			"name":  $("#goodsname").val(),
		},
		success : function(data) {
			if(data != null){
				updateProductList(data);
			}else{
				console.log("未找到商品");
			}
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("error");
		}
	});
}

</script> 
<body>
		<div class="easyui-navpanel">
			<header>
			    <div class="m-toolbar" style="justify-content:center;align-items:center;height:100px;">
			        <div class="m-title" style="padding-top:20px;font-size:48px;">
			        	<input class="easyui-textbox" id="goodsname" data-options="prompt:'商品名称', iconCls:'icon-search'" style="width:60%;height:70px;font-size:48px">
			        </div>
			        <div class="m-left">
					    <a href="javascript::void(0)" onclick="$.mobile.back()">
		                	<img src="images/back.png" style="margin-top:20;" width="64px" height="64px" onerror="this.src='common/images/default.gif;this.onerror=null'">
		                </a>
		            </div>
		            <div class="m-right" >
		                <a href="javascript:void(0)" onclick="findGoodsByName()" class="easyui-linkbutton" data-options="plain:true,outline:true">
		                	<span  class="shopping-client-text">搜索</span>
		                </a>
		            </div>
			    </div>
			</header>
			<div id="productlist" style="background:#C71585;padding:5px;height:100%;width:100%;z-index:1">
			    <ul class="m-list" id="product-m-list">
			    </ul>
			</div>
										
		</div>
  </body>
  </html>

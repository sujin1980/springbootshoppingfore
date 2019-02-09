<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<title>美酒商城系统</title>
	
	<link rel="stylesheet" type="text/css" href="common/css/style.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">
	
	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
</head>
<style  type="text/css">
	#productlist li{
		float:left;
	}
	a{text-decoration:none;}
	
	.tt-inner{
        display:inline-block;
        line-height:12px;
        padding-top:5px;
    }
		p{
			line-height:150%;
		}
	
	.box{width:50px;text-align:center; font-szie:18px;}
	.box img {width:100%;}
</style>

<script type="text/javascript">

$(function () {
	$('#mm').menu({
	    onClick:function(item){
			//alert(item.text);
			getProductType(item.text);
	    }
	});
	
	
	
	if('${sessionScope.loginClient.name}' != '') {
		initOrderInfo('${sessionScope.loginClient.name}');
		document.getElementById('clientname').innerHTML = "登录";
	}else{
		//alert("=========================");
		document.getElementById('clientname').innerHTML = "未登录";
	}
	
	
});

function initOrderInfo(clientname){
	//alert(clientname);
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"clientName": clientname
		},
		url : '/order/getOrderListByClientName.do',
		success : function(data) {
			 if (data != null) {  
				 document.getElementById("ordernumber").innerText = data.length;
		     }
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

function updateProductList(data){
	if((data != null) && (data.length != 0)) {
		$("#product-m-list").html("");
		var thtmlbody = "";
		for(var i= 0; i< data.length; i++){
			thtmlbody += "<label for=\"价格\"> " + data[i].name + "</label><br />";
			for(var j= 0; j< data[i].productList.length; j++){
				thtmlbody += "<li><a href=\"javascript:void(0);\" onclick=\"getProductById("
					+ data[i].productList[j].id +  ")\">";
				thtmlbody += "<img src=\""+ data[i].productList[j].icon + "\"" + 
				    "alt=\"" + data[i].productList[j].name + "的图片\"  onerror=\"this.src='common/images/default.gif;this.onerror=null'\"> </a>";
				thtmlbody += "<span style=\"position: absolute; bottom: 0; left: 0;\">"
					 + data[i].productList[j].name +"</span></li>";
	        	
			}
			if(i != (data.length -1)){
				thtmlbody += "<br /><br /><br /><br /><br />";
			}
		}
		
		console.log(thtmlbody);
		$("#product-m-list").html(thtmlbody);
	}
}

function getProductType(categoryname){
	$.ajax({
		type: "POST",
		data: {
			"name" : categoryname
		},
		url : 'producttype/getTypeListByCategoryName.do',	
		success : function(data) {
			//alert("ok");			
			updateProductList(data);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("checkField fail");
		}
	});
}

function loginClient(){
	window.location.href = "login.jsp";	
	return;
}

function findGoods(){
	window.location.href = "/product/search.jsp";
	return;
}
</script> 

<body>
	<div class="easyui-navpanel">
	    <header>
			    <div class="m-toolbar">
					<div class="m-title">Devices</div>
				</div>
		</header>
	
		<footer style="margin:5px;height:60px;width:100%;z-index:1">   
			        <ul style="white-space:nowrap;">
						<li style="display:inline-block">
							    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="">
								<img src='common/images/default.gif'/></ br>首页
								</a>
						</li>
						
						<li style="display:inline-block">
							    <a href="javascript:void(0)" class="easyui-linkbutton" onclick=""> 
								<img src='common/images/default.gif'/></ br>分类
								</a>
						</li>
						
						<li style="display:inline-block">
								<a href="javascript:void(0)" class="easyui-linkbutton" onclick="editOrder()">
								<img src='common/images/default.gif'/></ br>订单
								<span class="m-badge" id="ordernumber"></span>
								</a>
							
						</li>
						<li style="display:inline-block">
								<a href="javascript:void(0)" class="easyui-linkbutton" onclick="loginClient()">
								<img src='common/images/default.gif'/></ br><label id="clientname"></label>
					    		</a>
						</li>
				</ul>
		</footer>
	
		<div  style="background:#C71585;padding:5px;height:100%;width:100%;z-index:1">
		    <div id="productlist">
			    <ul class="m-list" id="product-m-list">
			    
			    </ul>
			</div>
		</div>
    </div>	
	
	
</body>
</html>
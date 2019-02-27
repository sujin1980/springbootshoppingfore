<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>商城系统</title>
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>美酒商城</title>
	
	<link rel="stylesheet" type="text/css" href="css/client.css"/>
	<link rel="stylesheet" type="text/css" href="css/style.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">
	
	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
</head>



<script type="text/javascript">

var ordernum = 0;
$(document).ready(function (){
	if('${sessionScope.loginClient.name}' != '') {
		initOrderInfo('${sessionScope.loginClient.name}');
		//document.getElementById('clientname').innerHTML = "登录";
	}else{
		//console.log("=========================");
		//document.getElementById('clientname').innerHTML = "未登录";
	}
	
	console.log(
	"屏幕分辨率为："+screen.width+"*"+screen.height 
	+" "+
	"  屏幕可用大小："+screen.availWidth+"*"+screen.availHeight
	+" "+
	"  网页可见区域宽："+document.body.clientWidth
	+" "+
	"  网页可见区域高："+document.body.clientHeight
	+" "+
	"  网页可见区域宽(包括边线的宽)："+document.body.offsetWidth
	+" "+
	"  网页可见区域高(包括边线的宽)："+document.body.offsetHeight); 
	
	var h = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
	var w = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth; 
	
	console.log("  网页可见区域宽：" + w
			+" "+
			"  网页可见区域高：" + h);
}); 

function baseInfo(){
    window.location.href = "client/baseinfo.jsp";
	return;	
}


function findOrder(orderstatus){
	
	window.location.href = "/order/list.jsp?orderstatus=" + orderstatus;
}

function initOrderInfo(clientname){
	//console.log(clientname);
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"clientName": clientname
		},
		url : '/order/getOrderListByClientName.do',
		success : function(data) {
			 if (data != null) {  
				 ordernum = data.length;
				 document.getElementById("ordernumber").innerText = ordernum;
		     }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("fail");
		}
	});
}

function toHomePage(){
	window.location.href = "mainFrame.jsp";
}

function editOrder(){
	if(ordernum != 0){
		window.location.href = "order/Edit.jsp";
	}
}

</script> 

<body>
	<div class="easyui-navpanel" >
		<header >
		    <div class="m-toolbar" style="justify-content:center;align-items:center;height:40px;">
		    	<div class="m-title">
				    <span style="font-size:28px;">我的商城</span>
				</div>
				
		    </div>
	    </header>  
	    <div id="tt" class="easyui-tabs" data-options="tabHeight:60,fit:true,tabPosition:'bottom',border:false,pill:true,narrow:true,justified:true">
				<div>
					<div class="panel-header tt-inner">
					    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="toHomePage()">
						<img src='images/homepage.png' width="93.75" height="60"  onerror="this.src='common/images/default.gif;this.onerror=null'">
						</a>
					</div>
				</div>
				
				<div>
					<div class="panel-header tt-inner">
					    <a href="javascript:void(0)" class="easyui-linkbutton" onclick=""> 
						<img src='images/categroy.png' width="93.75" height="60" onerror="this.src='common/images/default.gif;this.onerror=null'">
						</a>
					</div>
				</div>
				
				<div>
					<div class="panel-header tt-inner">
						<span class="m-badge" id="ordernumber" style="font-size:18px;"></span>
						<a href="javascript:void(0)" class="easyui-linkbutton" onclick="editOrder()">
						<img src='images/cart.png' width="93.75" height="60" onerror="this.src='common/images/default.gif;this.onerror=null'">
						
						</a>
					</div>
					
				</div>
				<div>
					<div class="panel-header tt-inner">
						<a href="javascript:void(0)" class="easyui-linkbutton" onclick="">
						<img src='images/redman.png' width="93.75" height="60" id="clientimage" onerror="this.src='common/images/default.gif;this.onerror=null'">
			    		</a>
			        </div>
				</div>
		 </div>  
		    <div id="baseinfo" style="width:100%;background:transparent;background-color:#FF1493;color:#ffffff;border-radius:5px;text-align:center; align-items:center;">
		    	<span class = "shopping-client-smalltext">用户名：</span> 
		    	<span id="clientname" class = "shopping-client-smalltext">${sessionScope.loginClient.name}</span>&nbsp; &nbsp; &nbsp; 
		    	<a href="javascript:void(0);" onclick="baseInfo()" style="color:#ffffff;">
		    		<img src='images/setting.png' class="shopping-main-frame-icon"/>
		    		<span class = "shopping-client-smalltext">账号管理</span>
				</a>
		    </div>
		     
	</div>	
</body>
</html>

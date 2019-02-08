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

$(document).ready(function (){
	
}); 

function baseInfo(){
    window.location.href = "client/baseinfo.jsp";
	return;	
}

// /order/toEdit2?id=${order.id}
// var orderurl = "/order/list2" + "?orderstatus=" + orderstatus;

function findOrder(orderstatus){
	var orderurl = "order/list2?orderstatus=" + orderstatus;
	alert("orderurl = " + orderurl);
	$.ajax({
		type : "POST",
		url : orderurl,
		success : function(data) {	
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("退出登录失败");
		}
	});
}

</script> 

<body>
		<div class="easyui-navpanel">
			<header>
			    <div class="m-toolbar">
					<span class="m-title">我的商城</span>
			        <div class="m-left">
		                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true" onclick="$.mobile.back()">回退</a>
		            </div>   
			    </div>
			</header>
			<footer>
	            <div class="m-buttongroup m-buttongroup-justified" style="width:100%">
	                <a href="javascript:void(0);" class="easyui-linkbutton" onclick="">
						<img src='common/images/default.gif'/></ br>首页
					</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick=""> 
						<img src='common/images/default.gif'/></ br>分类
					</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="editOrder()">
						<img src='common/images/default.gif'/></ br>订单
						<span class="m-badge" id="ordernumber"></span>
					</a>
					<a href="javascript:void(0);" class="easyui-linkbutton" onclick="loginClient()">
						<img src='common/images/default.gif'/></ br><label id="clientname">我的</label>
			    	</a>
	            </div>
	        </footer>
        
			<div id="clientsinfo" style="padding:10px;height:100%;width:100%;z-index:1">
			    <div id="baseinfo" style="padding-top:20px;height:200px;width:100%;background:transparent;background-color:#FF1493;color:#ffffff;border-radius:5px;text-align:center; align-items:center;">
			    	<span id="">用户名：</span> 
			    	<span id="clientname">'${sessionScope.loginClient.name}'</span>&nbsp; &nbsp; &nbsp; 
			    	<a href="javascript:void(0);" onclick="baseInfo()" style="color:#ffffff;">
			    		<img src='images/setting.png'/>账号管理
					</a>
			    </div>
			     <div id="orderinfo" style="height:100%;width:100%;">
			        <table>
				     	<tr>
					    	<td style="width: 30%">
							    <a href="javascript:void(0);" onclick="findOrder(3)">
								<img src='images/unpayed.png'/></ br></ br>待付款
								</a>
							</td>
							
							<td style="width: 30%">
							    <a href="javascript:void(0);" onclick="findOrder(4)"> 
								<img src='images/unrecieved.png'/></ br>待收货
								</a>
							</td>
							
							<td style="width: 30%">
								<a href="javascript:void(0);"  onclick="">
								<img src='images/aftersale.png'/></ br>退货/售后
								</a>
							</td>
							<td style="width: 30%">
								<a href="order/list2.do"  onclick="findOrder(0)">
								<img src='images/allorders.png'/></ br>全部订单
								</a>
							</td>
						</tr>
					</table>
			    </div>
			</div>
										
		</div>
  </body>
  </html>

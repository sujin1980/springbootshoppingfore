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

var ordernum = 0;
$(document).ready(function (){
	if('${sessionScope.loginClient.name}' != '') {
		initOrderInfo('${sessionScope.loginClient.name}');
		document.getElementById('clientname').innerHTML = "登录";
	}else{
		//console.log("=========================");
		document.getElementById('clientname').innerHTML = "未登录";
	}
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

<body class="easyui-layout">
    <div data-options="region:'north',split:false,border:true" style="justify-content:center;align-items:center;background:#FFC0CB;overflow:hidden;height:90px;width:100%;z-index:1">
	    <div class="m-toolbar">
			<span class="m-title" style="font-size:28px;"><br>我的商城</span>
	        <div class="m-left">
                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true" onclick="$.mobile.back()">
                   <span class="shopping-client-text"><br>回退</span>  	
                 </a>
            </div>   
	    </div>
	</div> 
	<div data-options="region:'south',split:false,border:true" style="padding:5px;height:90px;width:100%;z-index:1">   
          <div id="tt" class="easyui-tabs" data-options="tabHeight:60,fit:true,tabPosition:'bottom',border:false,pill:true,narrow:true,justified:true">
					<div style="padding:10px">
						<div class="panel-header tt-inner">
						    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="toHomePage()">
							<img src='common/images/default.gif' width="30" height="30" onerror="this.src='common/images/default.gif;this.onerror=null'">
							<span class="shopping-client-text">首页</span>
							</a>
						</div>
					</div>
					
					<div style="padding:10px">
						<div class="panel-header tt-inner">
						    <a href="javascript:void(0)" class="easyui-linkbutton" onclick=""> 
							<img src='common/images/default.gif' width="30" height="30" onerror="this.src='common/images/default.gif;this.onerror=null'">
							<span class="shopping-client-text">分类</span>
							</a>
						</div>
					</div>
					
					<div style="padding:10px">
						<div class="panel-header tt-inner">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="editOrder()">
							<img src='common/images/default.gif' width="30" height="30" onerror="this.src='common/images/default.gif;this.onerror=null'">
							<span class="shopping-client-text">订单</span> 
							<span class="m-badge" id="ordernumber"></span>
							</a>
						</div>
						
					</div>
					<div style="padding:10px">
						<div class="panel-header tt-inner">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="">
							<img src='common/images/default.gif' width="30" height="30" onerror="this.src='common/images/default.gif;this.onerror=null'">
							<label id="clientname" class="shopping-client-text"></label>
				    		</a>
				        </div>
					</div>
			</div>
     </div>
    <div data-options="region:'center',split:false,border:true" style="padding:5px;height:100%;width:100%;z-index:1">   
	    <div id="baseinfo" style="padding-top:20px;height:200px;width:100%;background:transparent;background-color:#FF1493;color:#ffffff;border-radius:5px;text-align:center; align-items:center;">
	    	<span class = "shopping-client-text">用户名：</span> 
	    	<span id="clientname" class = "shopping-client-text">'${sessionScope.loginClient.name}'</span>&nbsp; &nbsp; &nbsp; 
	    	<a href="javascript:void(0);" onclick="baseInfo()" style="color:#ffffff;">
	    		<img src='images/setting.png' class="shopping-main-frame-icon"/>
	    		<span class = "shopping-client-text">账号管理</span>
			</a>
	    </div>
	     <div id="orderinfo" style="padding:20px;text-align:center;margin:0 auto;">
	        <table>
		     	<tr>
			    	<td style="width:29%">
					    <a href="javascript:void(0);" onclick="findOrder(3)">
						<img src='images/unpayed.png' class="shopping-main-frame-icon" />
							<span class="shopping-client-text"><br />待付款</span>
						</a>
					</td>
					
					<td style="width:29%">
					    <a href="javascript:void(0);" onclick="findOrder(4)"> 
						<img src='images/unrecieved.png' class="shopping-main-frame-icon"/>
							<span class="shopping-client-text"><br />待收货</span>
						</a>
					</td>
					
					<td style="width:29%">
						<a href="javascript:void(0);"  onclick="">
						<img src='images/aftersale.png' class="shopping-main-frame-icon"/>
							<span class="shopping-client-text"><br />退货/售后</span>
						</a>
					</td>
					<td style="width:29%">
						<a href="javascript:void(0);"  onclick="findOrder(0)">
						<img src='images/allorders.png' class="shopping-main-frame-icon"/>
							<span class="shopping-client-text"><br />全部订单</span>
						</a>
					</td>
				</tr>
			</table>
	    </div>
	</div>
  </body>
  </html>

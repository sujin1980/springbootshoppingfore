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

var data = [
	{"group": "", "item":"修改登录密码"},
	{"group": "", "item":"修改绑定手机"},
	{"group": "", "item":"修改收货地址"},
	{"group": "", "item":"关联账号"}
];

$(function(){
	
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
			
	$('#dl').datalist({
		data: data,
		textField: 'item',
		groupField: 'group',
		textFormatter: function(value){
			return '<a href="javascript:void(0);" class="datalist-link">' 
			+ '<span class="shopping-client-text">' + value + '</span></a>';
		},
		onClickRow: function(index,row){
			switch(index)
			{
				case 0:
					window.location.href = "client/modifypassword.jsp";
					break;
				case 1:
					window.location.href = "client/modifytelephone.jsp";
					break;
				case 2:
					window.location.href = "client/modifyaddress.jsp";
					break;
				case 3:
					break;
				default:
					break;
			};
		}
	});	
	
}) 

function logout(){
	$.ajax({
		type : "POST",
		url : "client/logout.do",
		success : function(data) {	
			//$.mobile.back();
			window.location.href = "mainFrame.jsp";
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("退出登录失败");
		}
	}); 
	return;	
}
	
</script> 

<body>
	<div class="easyui-navpanel">
			<header>
			 	<div class="m-toolbar" style="justify-content:center;align-items:center;height:40px;">
					<span class="m-title" style="font-size:20px;">账号管理</span>
					 <div class="m-left">
		                <a href="javascript::void(0)" onclick="$.mobile.back()">
		                	<img src="images/back.png" style="margin-top:5;" width="34px" height="34px" onerror="this.src='common/images/default.gif;this.onerror=null'">
		                </a>
		            </div>   
			    </div>
			</header>

			<div id="clientsinfo" style="padding:10px;height:100%;width:100%;z-index:1;" >
				<div>
				    <br />
				    <span class="shopping-client-text">当前登录账号</span>
			    	<a href="javascript:void(0);" onclick="logout()" style="float:right"> 
						<img src='images/smallman.png'/>
						<span class="shopping-client-text">退出登录</span>
					</a>
					<br /> 
			    </div> 
			    <div>
			        <br />
			        <hr style="height:1px;border:none;border-top:1px solid #555555;" />
			        <br />
			    	<img src='images/man.png'/>
			    	<span id="clientname" class="shopping-client-text">${sessionScope.loginClient.name}</span> 
			    </div> 
			    <div id="dl" data-options="
					fit: true,
					border: false,
					lines: true
					">
				</div>
			</div>		
			
	</div>
  </body>
  </html>

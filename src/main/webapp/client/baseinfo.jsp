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

var data = [
	{"group": "", "item":"修改登录密码"},
	{"group": "", "item":"修改绑定手机"},
	{"group": "", "item":"修改收货地址"},
	{"group": "", "item":"关联账号"}
];

$(function(){
	$('#dl').datalist({
		data: data,
		textField: 'item',
		groupField: 'group',
		textFormatter: function(value){
			return '<a href="javascript:void(0);" class="datalist-link">' + value + '</a>';
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
			alert("退出登录失败");
		}
	}); 
	return;	
}
	
</script> 

<body>
	<div class="easyui-navpanel">
			<header>
			    <div class="m-toolbar">
					<span class="m-title">账号管理</span>
			        <div class="m-left">
		                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true" onclick="$.mobile.back()">回退</a>
		            </div>   
			    </div>
			</header>

			<div id="clientsinfo" style="padding:10px;height:100%;width:100%;z-index:1;" >
				<div>
				    <br />
			    	<span>当前登录账号</span>
			    	<a href="javascript:void(0);" onclick="logout()" style="float:right"> 
						<img src='images/smallman.png'/>退出登录
					</a>
					<br /> <br />
			    </div> 
			    <div>
			        <br />
			        <hr style="height:1px;border:none;border-top:1px solid #555555;" />
			        <br />
			    	<img src='images/man.png'/>
			    	<span id="clientname">${sessionScope.loginClient.name}</span> 
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

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

$(function () {
	$("#clientName").textbox('textbox').css("font-size", "18px");
	$("#password").textbox('textbox').css("font-size", "18px");
			
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
})


function login(){
	if($("#clientName").val().length == 0||$("#password").val() == "密码" ||$("#password").val().length == 0){
		$("#loginValidate").html("用户名或密码不能为空");
		return;
	}  
	  
	$.ajax({
		type : "POST",
		url : "client/login.do",
		data:{
			"name":     $("#clientName").val(),
			"password": $("#password").val()
		},
		success : function(data) {
			if(data != "OK"){
			     $("#loginValidate").html("用户名或密码不正确");
				 
		   }else{
			   /*if('${sessionScope.addgoods}' != ''){
				   console.log("转入用户订单页面");
				   return;
			   }*/
			   window.location.href = "client/Edit2.jsp";	
		  }
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("error");
		}
	}); 
	
}

function register(){
	window.location.href = "client/register.jsp";	
}

</script> 
	  


<body>
	<div class="easyui-navpanel" >
	    <header >
	        <div class="m-toolbar" style="justify-content:center;align-items:center;height:40px;">
	            <span class="m-title" style="font-size:20px;">用户登录</span>
	            <div class="m-left">
	                <a href="javascript::void(0)" onclick="$.mobile.back()">
	                	<img src="images/back.png" style="margin-top:5;" width="34px" height="34px" onerror="this.src='common/images/default.gif;this.onerror=null'">
	                </a>
	            </div>
	        </div>
	    </header>
	    <div style="text-align:center;margin:10px auto">
	    	<span class="shopping-client-text" style="">用户名</span>
	        <div style="margin-top:10px">
	            <input class="easyui-textbox" id="clientName" data-options="prompt:'输入 用户名 ',iconCls:'icon-man'" style="width:80%;height:40px;">
	        </div>
	        <div style="margin-top:10px">
	        	<span  class="shopping-client-text">密码</span>
	        </div>
	        <div style="margin-top:10px">
	            <input class="easyui-passwordbox" id="password" data-options="prompt:'输入密码 '  " style="width:80%;height:40px;">
	        </div>
	        <div style="margin-top:10px">
	        	<span id="loginValidate" class="shopping-client-hint"></span>
	        </div>
	        <div style="text-align:center;margin-top:20px">
	            <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="login();" style="width:80%;height:40px"><span class="shopping-client-text">登录</span></a>
	        </div>
	        <div style="text-align:center;margin-top:20px">
	            <a href="javascript:void(0);" class="easyui-linkbutton" onclick="register();" plain="true" outline="true" style="width:80%;height:40px"><span class="shopping-client-text">注册</span></a> 
	        </div>
	    </div>
	</div>
</body>

</html>

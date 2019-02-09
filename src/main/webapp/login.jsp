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
	<link rel="stylesheet" type="text/css" href="common/css/style.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">

	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
     
</head>

<script type="text/javascript">
$(document).ready(
   
); 

function login(){
	if($("#clientName").val().length == 0||$("#password").val() == "密码"||$("#password").val().length == 0){
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
				   alert("转入用户订单页面");
				   return;
			   }*/
			   window.location.href = "client/Edit2.jsp";	
		  }
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("error");
		}
	}); 
	
}

function register(){
	window.location.href = "client/register.jsp";	
}
	
</script> 
	  

<body>
	<div class="easyui-navpanel">
	    <header>
	        <div class="m-toolbar">
	            <span class="m-title">用户登录</span>
	            <div class="m-left">
	                <a href="javascript::void(0)" class="easyui-linkbutton m-back" data-options="plain:true,outline:true" onclick="$.mobile.back()">首页</a>
	            </div>
	        </div>
	    </header>
	    <div style="margin:20px auto;width:100px;height:100px;border-radius:100px;overflow:hidden">
	        <img src="common/images/default.gif" style="margin:0;width:100%;height:100%;" onerror="this.src='common/images/default.gif;this.onerror=null'">
	    </div>
	    <div style="padding:0 20px">
	    	<span  style="font-size:14px">用户名</span>
	        <div style="margin-bottom:10px">
	            <input class="easyui-textbox" id="clientName" data-options="prompt:'输入 用户名 ',iconCls:'icon-man'" style="width:100%;height:38px">
	        </div>
	        <span  style="font-size:14px">密码</span>
	        <div>
	            <input class="easyui-passwordbox" id="password" data-options="prompt:'输入密码 '  " style="width:100%;height:38px">
	        </div>
	        <span id="loginValidate" style="color:red;font-size:14px"></span><br/>
	        <div style="text-align:center;margin-top:30px">
	            <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="login();" style="width:100%;height:40px"><span style="font-size:16px">登录</span></a>
	        </div>
	        <div style="text-align:center;margin-top:30px">
	            <a href="javascript:void(0);" class="easyui-linkbutton" onclick="register();" plain="true" outline="true" style="width:100px;height:35px"><span style="font-size:16px">注册</span></a> 
	        </div>
	    </div>
	</div>
</body>

</html>

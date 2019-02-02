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
	
	<link   rel="stylesheet" type="text/css" href="common/css/style.css"  />
	<script type="text/javascript" src="common/js/jquery.js"></script>
	<script type="text/javascript" src="common/js/cloud.js"></script>
  </head>

<script language="javascript">
$(function(){
	$('.loginbox').css({'position':'inherit','left':($(window).width()-692)/2});
    $(window).resize(function(){$('.loginbox').css({'position':'inherit','left':($(window).width()-692)/2});}) 
    
    
    
  

    
}); 



function login()
{
	$.ajax({
		type : "POST",
		url : "user/login.do",
		data:{
			userName:$("#userName").val(),
			password: $("#password").val()
		},
		success : function(data) {
			window.location.href = "mainFrame.jsp";
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			
		}
	}); 
	
}
</script> 
  
<body style="background-color:#1c77ac; background-image:url(images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
	<div id="mainBody">
    	<div id="cloud1" class="cloud"></div>
      	<div id="cloud2" class="cloud"></div>
    </div>  
	<div class="logintop">    
    	<span>欢迎登录审计管理平台</span>    
    	<ul>
    		<li><a href="javascript:void(0);">回首页</a></li>
    		<li><a href="javascript:void(0);">帮助</a></li>
    		<li><a href="javascript:void(0);">关于</a></li>
    	</ul>    
    </div>
    
    <div class="loginbody" align="center">
	    <div class="systemlogo"></div> 
	    <div class="loginbox" align="left">
		    <ul>
		    	<li><input id="userName" name="userName"  type="text" class="loginuser" value="admin" onclick="JavaScript:this.value=''"/></li>
		    	<li><input id="password" name="password"  type="text" class="loginpwd" value="密码" onclick="JavaScript:this.value=''"/></li>
		    	<li>
		    		<input name="" type="button" class="loginbtn" value="登录"  onclick="login()"  />
		    		<label><input name="" type="checkbox" value="" checked="checked" />记住密码</label><label><a href="javascript:void(0);">忘记密码？</a></label>
		    	</li>
		    </ul>
	    </div>
    </div>
    <div class="loginbm">版权所有  2016  <a href="http://www.qc.com">uimaker.com</a> www.qc.com</div>
</body>
</html>

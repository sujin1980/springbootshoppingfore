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


var $main = $cloud = mainwidth = null;
var offset1 = 450;
var offset2 = 0;

var offsetbg = 0;



/// 飘动
setInterval(function flutter() {
    if (offset1 >= mainwidth) {
        offset1 =  -580;
    }

    if (offset2 >= mainwidth) {
		 offset2 =  -580;
    }
	
    offset1 += 1.1;
	offset2 += 1;
    $cloud1.css("background-position", offset1 + "px 100px")
	
	$cloud2.css("background-position", offset2 + "px 460px")
}, 70);


setInterval(function bg() {
    if (offsetbg >= mainwidth) {
        offsetbg =  -580;
    }

    offsetbg += 0.9;
    $body.css("background-position", -offsetbg + "px 0")
}, 90 );



$(document).ready(
	
	function () {
        $main = $("#mainBody");
		$body = $("body");
        $cloud1 = $("#cloud1");
		$cloud2 = $("#cloud2");
		
        mainwidth = $main.outerWidth();
        
    	$('.loginbox').css({'position':'inherit','left':($(window).width()-692)/2});
        $(window).resize(function(){$('.loginbox').css({'position':'inherit','left':($(window).width()-692)/2});}) 
    }
	
); 



function login()
{

	  if($("#userName").val().length == 0||$("#password").val() == "密码"||$("#password").val().length == 0){
		  $("#loginValidate").html("用户名或密码不能为空");
		  return;
	  }else{
		  $("#loginValidate").html("");
		  
	  }
	$.ajax({
		type : "POST",
		url : "user/login.do",
		data:{
			userName:$("#userName").val(),
			password: $("#password").val()
		},
		success : function(data) {
			if(data==""){
				$("#loginValidate").html("用户名或密码不正确");
			}else{
				window.location.href = "mainFrame.jsp";	
			}
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			
		}
	}); 
	
}
</script> 
  
<body style="background-color:#1c77ac; background-image:url(common/css/images/style/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
	<div id="mainBody">
    	<div id="cloud1" class="cloud"></div>
      	<div id="cloud2" class="cloud"></div>
    </div>  
    <div class="loginbody" align="center">
	    <div class="systemlogo"></div> 
	    <div class="loginbox" align="left">
		    <ul>
		    	<li><input id="userName" name="userName"  type="text" class="loginuser" value="admin" onclick="JavaScript:this.value=''"/></li>
		    	<li><input id="password" name="password"  type="text" class="loginpwd" value="密码" onclick="JavaScript:this.value=''"/></li>
		    	<span id="loginValidate" style="color:red;font-size:14px"></span>
		    	<li>
		    		<br/>
		    		<input name="" type="button" class="loginbtn" value="登录"  onclick="login()"  />
		    		<label><input name="" type="checkbox" value="" checked="checked" />记住密码</label><label><a href="javascript:void(0);">忘记密码？</a></label>
		    	</li>
		    </ul>
	    </div>
    </div>
    <div class="loginbm">版权所有  2016  <a href="http://www.qc.com">www.qc.com</a></div>
</body>
</html>

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

$(function(){
	/*$('#currentpassword').textbox({
        onChange: function (newvalue, oldvalue) {
    	  checkcurrentpassword(newvalue);
	      }
	});*/
	
	$('#newpassword').textbox({
        onChange: function (newvalue, oldvalue) {
    	  checkpassword1(newvalue);
	      }
	});
  
	$('#confirmpassword').textbox({
	     onChange: function (newvalue, oldvalue) {
	    	  checkpassword1(newvalue);
	     }
	});	
	
	$("#currentpassword").textbox('textbox').css("font-size", "18px");
	$("#newpassword").textbox('textbox').css("font-size", "18px");
	$("#confirmpassword").textbox('textbox').css("font-size", "18px");
}) 

function checkpassword1(newvalue){
	if((newvalue == null) || (newvalue.length < 6)){
		$("#passwordValidate").html("请输入至少6至20个字符的密码。包括英文字符和数字以及_");
		return;
	}
	
	if(($('#confirmpassword').textbox('getValue')) != ($('#newpassword').textbox('getValue'))){
		$("#passwordValidate").html("密码和确认密码不一致");
		return;
	}
	$("#passwordValidate").html("");
}

function checkcurrentpassword(){
	$.ajax({
		type : "POST",
		url : "client/checkPassword.do",
		data:{
			"password":  $("#currentpassword").val()
		},
		success : function(data) {
			if(data != "OK"){
				$("#passwordValidate").html("输入当前密码错误！");
				$("#currentpassword").textbox('setValue',''); 
				$("#newpassword").textbox('setValue',''); 
				$("#confirmpassword").textbox('setValue',''); 
				return;
			}
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("修改密码失败");
		}
	});
	return;
}

function modifyPassword(){
	console.log("新密码为" + $("#newpassword").val());
	console.log("当前密码为" + $("#currentpassword").val());
	$.ajax({
		type : "POST",
		url : "client/modifyPassword.do",
		data:{
			"password":      $("#newpassword").val(),
			"currentpassword":  $("#currentpassword").val()
		},
		success : function(data) {
			if(data == "FAIL"){
				$("#currentpassword").textbox('setValue',''); 
				$("#newpassword").textbox('setValue',''); 
				$("#confirmpassword").textbox('setValue',''); 	
				$("#passwordValidate").html("输入当前密码错误！");
				return;
			}
			$.mobile.back();
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("修改密码失败");
			$("#currentpassword").textbox('setValue',''); 
			$("#newpassword").textbox('setValue',''); 
			$("#confirmpassword").textbox('setValue',''); 
		}
	});
}

function cancelPassword(){
	$("#currentpassword").textbox('setValue',''); 
	$("#newpassword").textbox('setValue',''); 
	$("#confirmpassword").textbox('setValue',''); 	
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

					
			<div id="passwordgroup" style="text-align:center;margin:0 auto">
					<div class="shopping-client-text-div">
			    		<span class="shopping-client-text">当前密码</span>
			    	</div>	
			    	<div style="text-align:center;margin-top:10px">
				        <input class="easyui-passwordbox" name="currentpassword"   id="currentpassword" data-options="prompt:'请输入当前密码 '  " style="width:80%;height:40px;">
				    </div>
				    <div class="shopping-client-text-div">
			    		<span class="shopping-client-text">新密码密码</span>
			    	</div>	
			    	<div style="text-align:center;margin-top:10px">
				        <input class="easyui-passwordbox" name="newpassword"   id="newpassword" data-options="prompt:'输入6至20位密码 '  " style="width:80%;height:40px;">
				    </div>
				    <div class="shopping-client-text-div">
				    	<span class="shopping-client-text" >确认密码</span>
				    </div>	
				    <div style="text-align:center;margin-top:10px">
				        <input class="easyui-passwordbox" name="confirmpassword" id="confirmpassword" data-options="prompt:'输入6至20位密码'  " style="width:80%;height:40px;">
				    </div>
				    <div class="shopping-client-text-div">
				    	<span id="passwordValidate" class="shopping-client-hint"></span>
				    </div>
				    <div style="text-align:center;margin-top:10px">
				        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="modifyPassword();" style="width:80%;height:40px;">
				        	<span class="shopping-client-text">确认</span>
				        </a>
				    </div>    
				    <div style="text-align:center;margin-top:10px">
				        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancelPassword();" plain="true" outline="true" style="width:80%;height:40px;">
				        	<span class="shopping-client-text">重置</span>
				        </a> 
				    </div>  
			</div>	
			
		  
	</div>
  </body>
  </html>

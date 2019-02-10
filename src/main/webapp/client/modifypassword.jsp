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
	
	$("#currentpassword").textbox('textbox').css("font-size", "28px");
	$("#newpassword").textbox('textbox').css("font-size", "28px");
	$("#confirmpassword").textbox('textbox').css("font-size", "28px");
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
			alert("修改密码失败");
		}
	});
	return;
}

function modifyPassword(){
	alert("新密码为" + $("#newpassword").val());
	alert("当前密码为" + $("#currentpassword").val());
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
			alert("修改密码失败");
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
				<div class="m-toolbar" style="justify-content:center;align-items:center;height:80px;">
					<span class="m-title" style="font-size:28px;"><br>账号管理</span>
			        <div class="m-left">
		                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true" onclick="$.mobile.back()">
		                	<span class="shopping-client-text">回退</span>
		                </a>
		            </div>   
			    </div>
			</header>

					
			<div id="passwordgroup" style="padding:50px;text-align:center;margin:0 auto">
				
					<div class="shopping-client-text-div">
			    		<span class="shopping-client-text">当前密码</span>
			    	</div>	
			    	<div style="text-align:center;margin-top:20px">
				        <input class="easyui-passwordbox" name="currentpassword"   id="currentpassword" data-options="prompt:'请输入当前密码 '  " style="width:80%;height:60px;">
				    </div>
				    <div class="shopping-client-text-div">
			    		<span class="shopping-client-text">新密码密码</span>
			    	</div>	
			    	<div style="text-align:center;margin-top:20px">
				        <input class="easyui-passwordbox" name="newpassword"   id="newpassword" data-options="prompt:'输入6至20位密码 '  " style="width:80%;height:60px;">
				    </div>
				    <div class="shopping-client-text-div">
				    	<span class="shopping-client-text" >确认密码</span>
				    </div>	
				    <div style="text-align:center;margin-top:20px">
				        <input class="easyui-passwordbox" name="confirmpassword" id="confirmpassword" data-options="prompt:'输入6至20位密码'  " style="width:80%;height:60px;">
				    </div>
				    <div class="shopping-client-text-div">
				    	<span id="passwordValidate" class="shopping-client-hint"></span>
				    </div>
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="modifyPassword();" style="width:80%;height:60px;">
				        	<span class="shopping-client-text">确认</span>
				        </a>
				    </div>    
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancelPassword();" plain="true" outline="true" style="width:80%;height:60px;">
				        	<span class="shopping-client-text">重置</span>
				        </a> 
				    </div>  
			</div>	
			
		  
	</div>
  </body>
  </html>

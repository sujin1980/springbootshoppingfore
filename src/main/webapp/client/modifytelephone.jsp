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
	$('#telephone').textbox({
	     onChange: function (newvalue, oldvalue) {
	    	  checktelephone(newvalue);
	     }
	});	
	
	$("#telephone").textbox('textbox').css("font-size", "28px");
}) 

function checktelephone(newvalue){
	var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
	if (!reg.test(newvalue)){
		$("#telephoneValidate").html("请输入正确的电话号码");
		return;
	}
	
	$("#telephoneValidate").html("");
	return;
}


function modifyTelephone(){
	$.ajax({
		type : "POST",
		url : "client/modifyTelephone.do",
		data:{
			"telephone":     $("#telephone").val(),
		},
		success : function(data) {
			if(data != "OK"){
				console.log("修改电话失败");
				$("#telephone").textbox('setValue',''); 
				return;
			}
			$.mobile.back();
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("修改电话失败");
		}
	});
}

function cancelTelephone(){
	$("#telephone").textbox('setValue',''); 
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
			
			<div id="telephonegroup" style="padding:50px;text-align:center;margin:0 auto">
				
			    <br />
			    <span  class="shopping-client-text">电话</span>
			    <div style="margin-top:20px">
			        <input class="easyui-textbox" id="telephone" data-options="prompt:'请输入至少6个字符。包括英文字符和数字以及_'  "  style="width:80%;height:60px;">
			    </div>
			    <span id="telephoneValidate" class="shopping-client-hint"></span><br/>
			    <div style="text-align:center;margin-top:30px">
			        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="modifyTelephone();" style="width:80%;height:60px;">
			        	<span class="shopping-client-text">确认</span>
			        </a>
			    </div>    
			    <div style="text-align:center;margin-top:30px">
			        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancelTelephone();" plain="true" outline="true" style="width:80%;height:60px;">
			        	<span class="shopping-client-text">重置</span>
			        </a> 
			    </div>
		  </div>
		 
	</div>
  </body>
  </html>

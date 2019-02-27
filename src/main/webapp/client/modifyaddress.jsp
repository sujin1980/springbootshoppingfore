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
	$("#address").textbox('textbox').css("font-size", "28px");
}) 


function modifyAddress(){
	if($("#address").val() == ''){
		$("#addressValidate").html("地址栏不能为空");
		return;
	}
	
	$.ajax({
		type : "POST",
		url : "client/modifyAddress.do",
		data:{
			"address":     $("#address").val(),
		},
		success : function(data) {
			if(data != "OK"){
				console.log("修改地址失败");
				$("#address").textbox('setValue',''); 
				return;
			}
			$.mobile.back();
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("修改地址失败");
		}
	});
}

function cancelAddress(){
	$("#address").textbox('setValue',''); 
	return;
}

</script> 

<body>
	<div class="easyui-navpanel">
		   <header>
		   		<div class="m-toolbar" style="justify-content:center;align-items:center;height:80px;">
					<span class="m-title"  style="font-size:28px;"><br>账号管理</span>
			        <div class="m-left">
		                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true" onclick="$.mobile.back()">
		                	<span class="shopping-client-text">回退</span>
		                </a>
		            </div>   
			    </div>
		  </header>
		  <div id="addressgroup" style="text-align:center;margin:0 auto">
				
		  		<div class="shopping-client-text-div">
		  			<span  class="shopping-client-text">地址</span>
		  		</div>
			    <div style="margin-top:20px">
			        <input class="easyui-textbox" id="address" data-options="prompt:'请输入至少6个字符。包括英文字符和数字以及_'  "  style="width:80%;height:60px;">
			    </div>
			    <span id="addressValidate" class="shopping-client-hint"></span><br/>
			    <div style="text-align:center;margin-top:30px">
			        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="modifyAddress();" style="width:80%;height:60px;"><span class="shopping-client-text">确认</span></a>
			    </div>    
			    <div style="text-align:center;margin-top:30px">
			        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancelAddress();" plain="true" outline="true" style="width:80%;height:60px;"><span class="shopping-client-text">重置</span></a> 
			    </div>
		  </div>
	</div>
  </body>
  </html>

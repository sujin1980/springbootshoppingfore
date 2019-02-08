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

$(function(){
	
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
				alert("修改地址失败");
				$("#address").textbox('setValue',''); 
				return;
			}
			$.mobile.back();
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("修改地址失败");
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
			    <div class="m-toolbar">
					<span class="m-title">账号管理</span>
			        <div class="m-left">
		                <a href="javascript:void(0);" class="easyui-linkbutton m-back" data-options="plain:true,outline:true" onclick="$.mobile.back()">回退</a>
		            </div>   
			    </div>
		  </header>
		  <div id="addressgroup" style="padding:10px;height:100%;width:100%;z-index:1;">
				<div>
				    <br />
				    <span  style="font-size:14px">地址</span>
				    <div style="margin-bottom:10px">
				        <input class="easyui-textbox" id="address" data-options="prompt:'请输入至少6个字符。包括英文字符和数字以及_'  "  style="width:100%;height:38px">
				    </div>
				    <span id="addressValidate" style="color:red;font-size:14px"></span><br/>
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="modifyAddress();" style="width:100%;height:40px"><span style="font-size:16px">确认</span></a>
				    </div>    
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancelAddress();" plain="true" outline="true" style="width:100px;height:35px"><span style="font-size:16px">重置</span></a> 
				    </div>
			    </div>  
		  </div>
	</div>
  </body>
  </html>

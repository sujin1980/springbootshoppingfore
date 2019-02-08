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
			return '<a href="javascript:void(0)" class="datalist-link">' + value + '</a>';
		},
		onClickRow: function(index,row){
			switch(index)
			{
				case 0:
					$('#passwordgroup').css("display", "block");
					$('#accountgroup').css("display", "none");
					$('#addressgroup').css("display", "none");
					break;
				case 1:
					$('#passwordgroup').css("display", "none");
					$('#accountgroup').css("display", "block");
					$('#addressgroup').css("display", "none");
					break;
				case 2:
					$('#passwordgroup').css("display", "none");
					$('#accountgroup').css("display", "none");
					$('#addressgroup').css("display", "block");
					break;
				case 3:
					break;
				default:
					break;
			};
			$('#clientsinfo').css("display", "none");
		}
	});
	
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
	
	$('#telephone').textbox({
	     onChange: function (newvalue, oldvalue) {
	    	  checktelephone(newvalue);
	     }
	});	
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

function checkpassword1(newvalue){
	if((newvalue == null) || (newvalue.length < 6)){
		$("#passwordValidate").html("请输入至少6至20个字符的密码。包括英文字符和数字以及_");
		return;
	}
	
	if(($('#confirmpassword').textbox('getValue')) != ($('#password').textbox('getValue'))){
		$("#passwordValidate").html("密码和确认密码不一致");
		return;
	}
	$("#passwordValidate").html("");
}

function modifyPassword(){
	$.ajax({
		type : "POST",
		url : "client/modifyPassword.do",
		data:{
			"password":      $("#password").val()
		},
		success : function(data) {
			if(data != "OK"){
				alert("修改密码失败");
			}
			$('#clientsinfo').css("display", "block");
			$('#passwordgroup').css("display", "none");
			$('#addressgroup').css("display", "none");
			$('#accountgroup').css("display", "none");
			$("#passwordValidate").html("");
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("修改密码失败");
		}
	});
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
				alert("修改电话失败");
			}
			$('#clientsinfo').css("display", "block");
			$('#passwordgroup').css("display", "none");
			$('#addressgroup').css("display", "none");
			$('#accountgroup').css("display", "none");
			$("#telephoneValidate").html("");
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("修改电话失败");
		}
	});
}

function modifyAddress(){
	$.ajax({
		type : "POST",
		url : "client/modifyAddress.do",
		data:{
			"address":     $("#address").val(),
		},
		success : function(data) {
			if(data != "OK"){
				alert("修改地址失败");
			}
			$('#clientsinfo').css("display", "block");
			$('#passwordgroup').css("display", "none");
			$('#addressgroup').css("display", "none");
			$('#accountgroup').css("display", "none");
			$("#addressValidate").html("");
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("修改地址失败");
		}
	});
}
</script> 

<body>
	<div class="easyui-navpanel">
			<header>
			    <div class="m-toolbar">
					<span class="m-title">账号管理</span>
			        <div class="m-left">
		                <a href="#" class="easyui-linkbutton m-back" data-options="plain:true,outline:true">回退</a>
		            </div>   
			    </div>
			</header>

			<div id="clientsinfo" style="padding:10px;height:100%;width:100%;z-index:1;" >
				<div>
				    <br />
			    	<span>当前登录账号</span>
			    	<a href="javascript:void(0)" onclick="" style="float:right"> 
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
			<div id="passwordgroup" style="padding:10px;height:100%;width:100%;z-index:1;display:none;">
				<div>
				    <br />
			    	<span>当前密码</span>
			    	<div>
				        <input class="easyui-passwordbox" name="currentpassword"   id="currentpassword" data-options="prompt:'请输入当前密码 '  " style="width:100%;height:38px">
				    </div>
			    	<span  style="font-size:14px">新密码密码</span>
				    <div>
				        <input class="easyui-passwordbox" name="newpassword"   id="newpassword" data-options="prompt:'输入6至20位密码 '  " style="width:100%;height:38px">
				    </div>
				    <span  style="font-size:14px">确认密码</span>
				    <div>
				        <input class="easyui-passwordbox" name="confirmpassword" id="confirmpassword" data-options="prompt:'输入6至20位密码'  " style="width:100%;height:38px">
				    </div>
				    <span id="passwordValidate" style="color:red;font-size:14px"></span><br/>
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="modifyPassword();" style="width:100%;height:40px"><span style="font-size:16px">确认</span></a>
				    </div>    
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancelPassword();" plain="true" outline="true" style="width:100px;height:35px"><span style="font-size:16px">重置</span></a> 
				    </div>
			    </div>  
			</div>	
			<div id="telephonegroup" style="padding:10px;height:100%;width:100%;z-index:1;display:none;">
				<div>
				    <br />
				    <span  style="font-size:14px">电话</span>
				    <div style="margin-bottom:10px">
				        <input class="easyui-textbox" id="telephone" data-options="prompt:'请输入至少6个字符。包括英文字符和数字以及_'  "  style="width:100%;height:38px">
				    </div>
				    <span id="telephoneValidate" style="color:red;font-size:14px"></span><br/>
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="modifyTelephone();" style="width:100%;height:40px"><span style="font-size:16px">确认</span></a>
				    </div>    
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancelTelephone();" plain="true" outline="true" style="width:100px;height:35px"><span style="font-size:16px">重置</span></a> 
				    </div>
			    </div>  
		  </div>
		  <div id="addressgroup" style="padding:10px;height:100%;width:100%;z-index:1;display:none;">
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
		  <div id="accountgroup" style="padding:10px;height:100%;width:100%;z-index:1;display:none;">
				<div>
				    <br />
			    	<span>当前密码</span>
			    	<div>
				        <input class="easyui-passwordbox" name="currentpassword"   id="currentpassword" data-options="prompt:'请输入当前密码 '  " style="width:100%;height:38px">
				    </div>
			    	<span  style="font-size:14px">新密码密码</span>
				    <div>
				        <input class="easyui-passwordbox" name="newpassword"   id="newpassword" data-options="prompt:'输入6至20位密码 '  " style="width:100%;height:38px">
				    </div>
				    <span  style="font-size:14px">确认密码</span>
				    <div>
				        <input class="easyui-passwordbox" name="confirmpassword" id="confirmpassword" data-options="prompt:'输入6至20位密码'  " style="width:100%;height:38px">
				    </div>
				    <span id="passwordValidate" style="color:red;font-size:14px"></span><br/>
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="modifyPassword();" style="width:100%;height:40px"><span style="font-size:16px">确认</span></a>
				    </div>    
				    <div style="text-align:center;margin-top:30px">
				        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancel();" plain="true" outline="true" style="width:100px;height:35px"><span style="font-size:16px">重置</span></a> 
				    </div>
			    </div>  
		 </div>
	</div>
  </body>
  </html>

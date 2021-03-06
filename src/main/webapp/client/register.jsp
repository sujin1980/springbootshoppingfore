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
	
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="css/client.css"/>
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">

	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
  </head>

<script type="text/javascript">
$(function () {
	$('#clientName').textbox({
	      onChange: function (newvalue, oldvalue) {
	    	  checkduplicatename(newvalue);
	      }
    });
  
    $('#password').textbox({
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
	
	$('#chineseName').textbox({
	     onChange: function (newvalue, oldvalue) {
	    	  checkchinesename(newvalue);
	     }
	});

	$("#clientName").textbox('textbox').css("font-size", "18px");
	$("#chineseName").textbox('textbox').css("font-size", "18px");
	$("#password").textbox('textbox').css("font-size", "18px");
	$("#confirmpassword").textbox('textbox').css("font-size", "18px");
	$("#telephone").textbox('textbox').css("font-size", "18px");
	$("#address").textbox('textbox').css("font-size", "18px");
	$("#weixin").textbox('textbox').css("font-size", "18px");
	$("#remarks").textbox('textbox').css("font-size", "18px");
			
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
}); 

function checkchinesename(newvalue){
//	var reg=/.*[/u4e00-/u9fa5]+.*$/;
//	if (!reg.test(newvalue)){
//		$("#registerValidate").html("请输入正确的中文名");
//		return;
//	}
	
	return;
}

function checktelephone(newvalue){
	var reg = /^1(3|4|5|6|7|8|9)\d{9}$/;
	if (!reg.test(newvalue)){
		$("#registerValidate").html("请输入正确的电话号码");
		return;
	}
	
	$("#registerValidate").html("");
	return;
}


function register(){
  	window.location.href = "client/register.jsp";	
}

  
function checkpassword1(newvalue){
	if((newvalue == null) || (newvalue.length < 6)){
		$("#registerValidate").html("请输入至少6至20个字符的密码。包括英文字符和数字以及_");
		return;
	}
	
	if(($('#confirmpassword').textbox('getValue')) != ($('#password').textbox('getValue'))){
		$("#registerValidate").html("密码和确认密码不一致");
		return;
	}
	$("#registerValidate").html("");
}

function checkduplicatename(newvalue){
	if((newvalue == null) || (newvalue.length < 6)){
		$("#registerValidate").html("请输入至少6至16个字符的用户名。包括英文字符和数字以及_ ");
		return;
	}
	
	var reg = /(?=.*[a-zA-Z])(?=.*\d)(?=.*[_])[a-zA-Z\d_]{6,16}/i;
	if (!reg.test(newvalue)){
		$("#registerValidate").html("请输入至少6至16个字符的用户名。包括英文字符和数字以及_");
		return;
	}

	$("#registerValidate").html("");
}	

function register(){
	$.ajax({
		type : "POST",
		url : "client/addClient.do",
		data:{
			"name":          $("#clientName").val(),
			"chinesename":   $("#chineseName").val(),
			"password":      $("#password").val(),
			"telephone":     $("#telephone").val(),
			"address":       $("#address").val(),
			"weixin":   $("#weixin").val(),
			"remarks":  $("#remarks").val(),
		},
		contentType: "application/x-www-form-urlencoded; charset=utf-8", 
		success : function(data) {
			if(data == "OK"){
				window.location.href = "client/login.jsp";	
			}else{
				console.log("注册失败");
			}
			$("#registerValidate").html("");
			
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("注册失败");
		}
	});
}

function login(){
	window.location.href = "client/login.jsp";
}

</script> 
    
<script type="text/css">


</script> 

<body>
		<div class="easyui-navpanel">
			<header>
			    <div class="m-toolbar" style="justify-content:center;align-items:center;height:40px;">
			    	<span class="m-title" style="font-size:20px;">用户注册</span>
			        <div class="m-left">
		                <a href="javascript::void(0)" onclick="$.mobile.back()">
		                	<img src="images/back.png" style="margin-top:5;" width="34px" height="34px" onerror="this.src='common/images/default.gif;this.onerror=null'">
		                </a>
		            </div>
			    </div>
			</header>
			<div style="text-align:center;margin:10px auto">

		    	<div style="margin-top:10px">
			    	<span class="shopping-client-text">用户名</span>
			    	<div>
			        	<input class="easyui-textbox" id="clientName" data-options="prompt:'请输入至少6个字符。包括英文字符和数字以及_'  "  style="width:80%;height:40px;">
			        </div>
			    </div>
			    <div style="margin-top:10px">
			    	<span class="shopping-client-text">中文名称</span>
			    	<div>
			        	<input class="easyui-textbox" id="chineseName" data-options="prompt:'请输入中文 '  "  style="width:80%;height:40px;">
			        </div>	
			    </div>
			    <div style="margin-top:10px">
			    	<span class="shopping-client-text">密码</span>
			    	<div>
			        	<input class="easyui-passwordbox" name="password"   id="password" data-options="prompt:'输入6至20位密码 '  " style="width:80%;height:40px;">
			        </div>
			    </div>
			    <div style="margin-top:10px">
			    	<span class="shopping-client-text">确认密码</span>
			    	<div>
			        	<input class="easyui-passwordbox" name="confirmpassword" id="confirmpassword" data-options="prompt:'输入6至20位密码'  " style="width:80%;height:40px;">
			        </div>
			    </div>
			    <div style="margin-top:10px">
			    	<span  class="shopping-client-text">电话</span>
			    	<div>
			            <input class="easyui-textbox" id="telephone" data-options="prompt:'请输入正确的电话号码'  "  style="width:80%;height:40px;">
			        </div>
			    </div>
			    <div style="margin-top:10px">
			    	<span  class="shopping-client-text">地址</span>
			    	<div>
			            <input class="easyui-textbox" id="address" data-options="prompt:'请输入地址信息'  "  style="width:80%;height:40px;">
			        </div>
			    </div>

			    <div style="margin-top:10px">
			    	<span  class="shopping-client-text">微信</span>
			    	<div>
			            <input class="easyui-textbox" id="weixin" data-options="prompt:'请输入微信号'  "   style="width:80%;height:40px;">
			        </div>
			    </div>
			    <div style="margin-top:10px">
			    	<span  class="shopping-client-text">自我介绍</span>
			    	<div>
			        	<input class="easyui-textbox" id="remarks" data-options="prompt:'请输入自我介绍'  "   style="width:80%;height:40px;">
			        </div>
			    </div>
			    
			    <span id="registerValidate"  class="shopping-client-hint"></span><br/>
			    <div style="text-align:center;margin-top:10px">
			        <a href="javascript:void(0);" class="easyui-linkbutton"  onclick="register();" style="width:80%;height:40px;"><span  class="shopping-client-text">注册</span></a>
			    </div>
			    <div style="text-align:center;margin-top:10px">
			        <a href="javascript:void(0);" class="easyui-linkbutton" onclick="cancel();" plain="true" outline="true" style="width:80%;height:40px;">
			        <span  class="shopping-client-text">重置</span></a> 
			    </div>
			</div>							
		</div>
  </body>
  </html>

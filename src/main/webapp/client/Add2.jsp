<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
    <base href="<%=basePath%>">
    <title>欢迎登录后台管理系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
  </head> 
  
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" name="viewport">
     <link rel="stylesheet" type="text/css" href="common/css/style.css" />
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css" />
    
	<script type="text/javascript" src="common/js/jquery.js"></script>
	<script type="text/javascript" src="common/js/jquery.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="common/easyui/locale/easyui-lang-zh_CN.js"></script>
<script src="../static/jquery-3.3.1.min.js" type="text/javascript"></script>

<script type="text/javascript">


function addRow()
{	
	$.ajax({
    	contentType : "application/json;charset=UTF-8",
		dataType : "json",
        type: "POST",
		data: {
			name:      $("#name").val(),
		    telephone: $("#telephone").val(),
		    address:   $("#address").val(),
		    weixin:    $("#weixin").val(),
		    qq:      $("#qq").val(),
			remarks: $("#remarks").val(),
		},
		url : '/client/add2.do',
		success : function(data) {			
			//alert("addRow success");
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			//alert("addRow fail");
			window.close();
			//window.location.replace("https://www.runoob.com");
		}
	});
}

</script>
  
<body  class="easyui-layout" style="width:100%;height:100%;">
     <!--- <div data-options="region:'north',split:false,border:true" style="overflow:hidden;height:90px;z-index:1">
		<iframe src="top.jsp" width="100%" name="topFrame" scrolling="No" id="topFrame" title="topFrame"></iframe>
	</div> ---> 
	
	<div data-options="region:'east',split:false" title="east" style="width:180px;"></div>
	<div data-options="region:'west',split:false" title="west" style="width:100px;"></div>
	<div data-options="region:'south',split:false" title="south" style="height:100px;"></div>
    <div data-options="region:'center',split:false,border:true" style="padding:5px;height:590px;z-index:1">
	    
		 <div class="place">
			<span>位置：</span>
			<ul class="placeul">
			<li><a href="javascript:void(0);">首页</a></li>
			<li><a href="javascript:void(0);">商家管理</a></li>
			<li><a href="javascript:void(0);">添加商家</a></li>
			</ul>
		</div>
		<br />
		<div class="box-body" style="text-align:center; align-items:center; ">	
		   <label>名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="name" name="name"><br></br>
		   <label>电话号码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="telephone" name="telephone"><br></br>
		   <label>地址&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="address" name="address"><br></br>
		   <label>微信号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="weixin" name="weixin"><br></br>
		   <label>QQ号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="qq" name="qq"><br></br>
		   <label>注释&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="remarks" name="remarks"><br></br>
		   <br></br>
		   <div class="btn-group">
		       <button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i> 新建</button>
		       &nbsp; &nbsp; &nbsp;
		        <input type="reset"  class="btn btn-default" value="重置"  />
		   </div>、
	  </div>
  </div>  	
</body>

</html>

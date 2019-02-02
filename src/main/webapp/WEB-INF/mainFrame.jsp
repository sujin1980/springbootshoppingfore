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
  </head>  
  
    <link rel="stylesheet" type="text/css" href="common/css/style.css" />
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/default/easyui.css"/>
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css" />
    
	<script type="text/javascript" src="common/js/jquery.js"></script>
	<script type="text/javascript" src="common/js/jquery.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
  
  
  <script type="text/javascript">
  jQuery(document).ready(function() {
	  var homepageId = "${sessionScope.homepage.funId}";
	  var homepageSrc = "${sessionScope.homepage.url}";  
	  if(homepageId != ""){
	  	$('#rightFrame').attr("src",homepageSrc);  
	  	$('#leftFrame').attr("src","left.jsp?homepageid="+homepageId);
	  }
  });
  /**
   *弹出添加的对话框 
   */
  function addNotice(id){
  	$('#'+id).dialog();
  }
  </script>
<!-- <frameset rows="88,*" cols="*" frameborder="no" border="0" framespacing="0"> -->
<!--   <frame src="top.jsp" name="topFrame" scrolling="No" noresize="noresize" id="topFrame" title="topFrame" /> -->
<!--   <frameset cols="187,*" frameborder="no" border="0" framespacing="0"> -->
<!--     <frame src="left.jsp" name="leftFrame" scrolling="No" noresize="noresize" id="leftFrame" title="leftFrame" /> -->
<!--     <frame src="notice/tonoticeDetail.do" name="rightFrame" id="rightFrame" title="rightFrame"/> -->
<!--   </frameset> -->
<!-- </frameset> -->
<body class="easyui-layout">
	<div data-options="region:'north',split:false,border:true" style="overflow:hidden;height:90px;z-index:1">
		<iframe src="top.jsp" width="100%" name="topFrame" scrolling="No" id="topFrame" title="topFrame"></iframe>
	</div>
	<!--
    <div data-options="region:'west',split:false" style="width:170px;overflow:hidden;z-index:1" scrolling="No">
    	<iframe src="left.jsp" height="100%" scrolling="No" name="leftFrame" noresize="noresize" id="leftFrame" title="leftFrame"></iframe>
    </div>-->
    <div data-options="region:'center',split:false,border:true" style="padding:5px;height:590px;z-index:1">
    	<iframe src="sqlEdit/index.do" height="100%" width = "100%" scrolling="No" name="rightFrame" id="rightFrame" title="rightFrame"></iframe>
    </div>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>top</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	
	<link   rel="stylesheet" type="text/css" href="common/css/style.css" />
	<link   rel="stylesheet" type="text/css" href="common/css/select.css" />
	<script type="text/javascript" src="common/js/jquery.js"></script>
  </head>

<script language="javascript">
$(function(){	
	//顶部导航切换
	$.ajax({
		type : "POST",
		url : "user/functionlist.do",
		data : {},
		success : function(data) {
			var tbodyhtmlod = '';
			var list = data;
			var d;
			if ((list != null) && (list.length > 0)) {
				
				for (var i = 1; i < list.length; i++) {
					if (0 == list[i].parentId) {
						tbodyhtmlod += '<li><a href="' + list[i].url +'" target="rightFrame" class="selected">';
						tbodyhtmlod += '<img src="common/images/' + list[i].focusIco + '"';
						tbodyhtmlod += 'title="' + list[i].name + '"';
						tbodyhtmlod += ' /><h2>' + list[i].name + '</h2></a></li>';
					}	
				}
			}
			//刷新表格数据
			$("#nav").html(tbodyhtmlod);
			$(".nav li a").click(function(){
				$(".nav li a.selected").removeClass("selected")
				$(this).addClass("selected");
			})	
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
	
})	 
</script> 
  
<body style="background:url(common/images/topbg.gif) repeat-x;">
    <div class="topleft">
    	<a href="main.html" target="_parent"><img src="common/images/logo.png" title="系统首页" /></a>
    </div>
        
    <ul class="nav" id="nav">
	    
    </ul>
            
    <div class="topright">    
	    <ul>
		    <li><span><img src="common/images/help.png" title="帮助"  class="helpimg"/></span><a href="javascript:void(0);">帮助</a></li>
		    <li><a href="javascript:void(0);">关于</a></li>
		    <li><a href="login.html" target="_parent">退出</a></li>
	    </ul>
	    <div class="user">
	    	<span>admin</span>
	    	<i>消息</i>
	    	<b>54</b>
	    </div>    
    </div>
</body>
</html>

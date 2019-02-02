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
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	
	<title>Menu on Toolbar - jQuery EasyUI Mobile Demo</title>
	<link rel="stylesheet" type="text/css" href="common/css/left.css" />  
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">
	<script type="text/javascript" src="common/js/jquery.min.js"></script>
	<script type="text/javascript" src="common/js/jquery.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
  </head>

<script language="javascript">

$(document).ready(function (){
	
	var homepageId = "${sessionScope.loginUser.name}"; //用户个人主页
	 
	//var functionListJson='${sessionScope.functionList}'; //用户功能菜单	
	//var functionList=JSON.parse(functionListJson);
	var productchildrenList =
		[
			{
			    name: "一级分类",
			    url: "productcategory/list2.do",
			},
			{
			    name: "二级分类",
			    url: "producttpe/list2.do",
			},
			{
			    name: "商品",
			    url: "product/list2.do",
			}
			
		];
	
	var clientchildrenList =
		[
			{
			    name: "商家",
			    url: "client/list2.do",
			},
			{
			    name: "商家订单",
			    url: "client/alltoOrder2.do",
			}
			
		];
	
	var userchildrenList =
		[
			{
			    name: "角色管理",
			    url: "role/list2.do",
			},
			{
			    name: "权限管理",
			    url: "right/list2.do",
			}
			
		];
	
	var orderchildrenList =
		[
			{
			    name: "订单管理",
			    url: "order/list2.do",
			}
			
		];
	
	var logchildrenList =
		[
			{
			    name: "日志管理",
			    url: "log/list2.do",
			}
			
		];
	
	var functionList =
	[
	{
		name: "商品管理",
	    url: "",
	    childrenList: productchildrenList,
	},
	{
	    name: "商家管理",
	    url: "",
	    childrenList: clientchildrenList,
	},
	
	{
	    name: "订单管理",
	    url: "",
	    childrenList: orderchildrenList,
	},
	{
	    name: "用户管理",
	    url: "",
	    childrenList: userchildrenList,
	},
	{
	    name: "日志管理",
	    url: "",
	    childrenList: logchildrenList,
	}
	];
	
    if(('${sessionScope.clientorder.userName}' != '') && ('${sessionScope.clientorder.id}' != '')
       	 && ('${sessionScope.clientorder.status}' != '')){
       	var info = new Object();
       	
       	info = '[' + '${sessionScope.clientorder.userName}' + '][' 
       	   + '${sessionScope.clientorder.id}' +  '][' + '${sessionScope.clientorder.status}' + ']';
       	//document.getElementById("orderinfo").innerHTML = info;
       	//var label=document.getElementById("orderinfo");
       	//label.innerText=info;
        document.getElementById("orderinfo").innerHTML= '<a href="<%=basePath%>order/toEdit2?id='
        	+ '${sessionScope.clientorder.id}' + '" target="rightFrame">' + info + '</a>';
        //document.getElementById("orderinfo").href= '<%=basePath%>order/toEdit2?id=' +'${sessionScope.clientorder.id}';
    }
       
    
	var menuLevel1HtmlBody = ''; //用户一级菜单
	var menuLevel2HtmlBody = ''; //用户二级菜单
    for (var i = 0; i < functionList.length; i++)
    {
    	
		var userFunction = functionList[i];
    	var selectFlag = false;
	
		var childrenFunctionList = userFunction.childrenList;
		var divMenuLevel2HtmlBody = '';
		for(var j=0; j<childrenFunctionList.length; j++)
		{
			var childrenFunction = childrenFunctionList[j];
			if(childrenFunction.funId == homepageId)
			{
				var selectFlag = true;
				divMenuLevel2HtmlBody +=  '<li  class="Select"><a href="'+childrenFunction.url+'" target="rightFrame"><b>'+ childrenFunction.name +'</b></a></li>';
			}
			else
			{
				divMenuLevel2HtmlBody +=  '<li><a href="'+childrenFunction.url+'" target="rightFrame"><b>'+ childrenFunction.name +'</b></a></li>';
			}
		 }
		
		 divMenuLevel2HtmlBody += '</ul></div>'; 
		 if(selectFlag)
		 {
			 divMenuLevel2HtmlBody = (' <div class="Menu"><ul>' + divMenuLevel2HtmlBody);
		 }
		 else
		 {
			 divMenuLevel2HtmlBody = (' <div class="Menu Hide"><ul>' + divMenuLevel2HtmlBody);
		 } 
		 menuLevel2HtmlBody += divMenuLevel2HtmlBody; 
		
		 if(selectFlag)
		 {
			 menuLevel1HtmlBody += '<li class="Select"><a href="'+userFunction.url+'" target="rightFrame"><b>';	
		 }
		 else
		 {
			 menuLevel1HtmlBody += '<li><a href="'+userFunction.url+'" target="rightFrame"><b>';
		 }
		 menuLevel1HtmlBody +=  userFunction.name;
		 menuLevel1HtmlBody += '</b></a></li>';
	} 
	
    //刷新表格数据
	$("#menuLevel1").html(menuLevel1HtmlBody);
    $("#menuLevel2").html(menuLevel2HtmlBody);
	
    
	$('#Top .Toolbar1 .CentreBox .Menu .List1 li').mouseenter(function () {
        var index = $(this).parent().children().index(this);
        $(this).parent().children().each(function () {
        	
        	
        	
            if ($(this).hasClass('Select')) {
                $(this).removeClass('Select');
            }
        });
        $(this).addClass('Select');

        $('#Top .Toolbar2 .CentreBox .Menu').each(function () {
            if (!$(this).hasClass('Hide')) {
                $(this).addClass('Hide');
            }
        });
        $('#Top .Toolbar2 .CentreBox .Menu').eq(index).removeClass('Hide');
    });

    $('#Top .Toolbar2 .CentreBox .Menu ul li a').mouseenter(function () {
        var index = $('#Top .Toolbar2 .CentreBox .Menu ul li a').index(this);
        $('#Top .Toolbar2 .CentreBox .Menu ul li').each(function () {
            if ($(this).hasClass('Select')) {
                $(this).removeClass('Select');
            }
        });
        $(this).parent().addClass('Select');
    });
    //alert('${sessionScope.loginUser.name}');
    


    document.getElementById("username").innerHTML= '你好：【' + '${sessionScope.loginUser.name}'  + '】' ;
});

</script> 
  
<body >
		<div class="easyui-navpanel">
			<header>
			    <div class="m-toolbar">
			        <div class="m-title">Menu on Toolbar</div>
			        <div class="m-left">
			            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-man',plain:true"></a>
			        </div>
			        <div class="m-right">
			            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"></a>
			            <a href="javascript:void(0)" class="easyui-menubutton" data-options="iconCls:'icon-more',plain:true,hasDownArrow:false,menu:'#mm',menuAlign:'right'"></a>
			        </div>
			    </div>
			</header>
			<div id="mm" class="easyui-menu" style="width:150px;" data-options="itemHeight:30,noline:true">
			    <div data-options="iconCls:'icon-undo'">Undo</div>
			    <div data-options="iconCls:'icon-redo'">Redo</div>
			    <div class="menu-sep"></div>
			    <div>Cut</div>
			    <div>Copy</div>
			    <div>Paste</div>
			    <div class="menu-sep"></div>
			    <div>Toolbar</div>
			    <div data-options="iconCls:'icon-remove'">Delete</div>
			    <div>Select All</div>
			</div>
	  </div>		
</body>
</html>

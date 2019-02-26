<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>商城系统</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	
	<link rel="stylesheet" type="text/css" href="css/style.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">
	
	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
</head>

<style type="text/css">
#test .l-btn{
    color:red;
    color: #fff;
    border-color: #3c8b3c;
    background: #4cae4c;
    background: -webkit-linear-gradient(top,#4cae4c 0,#449d44 100%);
    background: -moz-linear-gradient(top,#4cae4c 0,#449d44 100%);
    background: -o-linear-gradient(top,#4cae4c 0,#449d44 100%);
    background: linear-gradient(to bottom,#4cae4c 0,#449d44 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#4cae4c,endColorstr=#449d44,GradientType=0);

}
#test .l-btn-selected, .l-btn-selected:hover{
    background:rgb(230, 126, 34);
    color:#fff;
    border:0px;
}

#test .l-btn-text{
	font-size:38px;
}



</style>
<script type="text/javascript">

$(function () {
	$('#mm').menu({
	    onClick:function(item){
			//console.log(item.text);
			getProductType(item.text);
	    }
	});
	
	$('#tt').tabs({
	    border:false,
	    onSelect:function(title, index){
			//console.log(title+' is selected');
			//console.log(index);
	    }
	});
	
	if('${sessionScope.loginClient.name}' != '') {
		initOrderInfo('${sessionScope.loginClient.name}');
		$("#clientimage").attr('src', "images/login.png");
	}else{
		$("#clientimage").attr('src', "images/loginman.png");
	}
	
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

function initOrderInfo(clientname){
	//console.log(clientname);
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"clientName": clientname
		},
		url : '/order/getOrderListByClientName.do',
		success : function(data) {
			 if(data == null){
				 return;
			 }
			   
			 if(data.length > 1){
				 console.log("未付款订单为" + data.length + "条。系统错误，请联系客服解决！");
			 }else if(data.length == 1){
				 document.getElementById("ordernumber").innerText = data.length;
		     }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("fail");
		}
	});
}

function getProductById(productid){
	window.location.href = "/product/toEdit2?id=" + productid;
	return;
}

function editOrder(){
	if('${sessionScope.clientorder.id}' != ''){
		window.location.href = "order/Edit.jsp";
	}
}


function updateProductList(data){
	if((data != null) && (data.length != 0)) {
		$("#product-m-list").html("");
		var thtmlbody = "";
		for(var i= 0; i< data.length; i++){
			thtmlbody += "<label for=\"价格\"> " + data[i].name + "</label><br />";
			for(var j= 0; j< data[i].productList.length; j++){
				thtmlbody += "<li><a href=\"javascript:void(0);\" onclick=\"getProductById("
					+ data[i].productList[j].id +  ")\">";
				thtmlbody += "<img src=\""+ data[i].productList[j].icon + "\"" + 
				    "alt=\"" + data[i].productList[j].name + "的图片\"   height=\"40\" width=\"40\" onerror=\"this.src='common/images/default.gif;this.onerror=null'\"><br /></a>";
				thtmlbody += "<span style=\"position: absolute; bottom: 0; left: 0;\">"
					 + data[i].productList[j].name +"</span></li>";
	        	
			}
			if(i != (data.length -1)){
				thtmlbody += "<br><br><br><br><br><br><br><br><br>";
			}
		}
		
		console.log(thtmlbody);
		$("#product-m-list").html(thtmlbody);
	}
}

function getProductType(categoryname){
	$.ajax({
		type: "POST",
		data: {
			"name" : categoryname
		},
		url : 'producttype/getTypeListByCategoryName.do',	
		success : function(data) {
			//console.log("ok");			
			updateProductList(data);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("checkField fail");
		}
	});
}

function loginClient(){
	if('${sessionScope.loginClient.name}' != ''){
		window.location.href = "client/Edit2.jsp";
	}else{
		window.location.href = "client/login.jsp";	
		//window.location.href = "wapPaySuccess.jsp";
	}
	return;
}

function findGoods(){
	window.location.href = "/product/search.jsp";
	return;
}

function toHomePage(){
	window.location.href = "mainFrame.jsp";
}

</script> 

<body>
	<div class="easyui-navpanel" >
		<header>
            <div class="m-toolbar" style="justify-content:center;align-items:center;height:100px">
                <div class="m-title" id="test" style="padding:20px;">
                	<input class="easyui-searchbox" data-options="prompt:'搜索商品请进入'" style="width:80%;height:70px">
                </div>
                <div class="m-left">
                	<a href="javascript:void(0)" class="easyui-menubutton" data-options="iconCls:'icon-more',plain:true,hasDownArrow:false,menu:'#mm',menuAlign:'right'"></a>
                	
                </div>
                <div class="m-right">
                    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="loginClient()" data-options="iconCls:'icon-man',plain:true"></a>
                </div>
            </div>
            <div id="mm" class="easyui-menu" style="width:250px;font-size:48px;" data-options="itemHeight:50,itemHeight:50, noline:true">
	            <div>
	             	<span style="font-size:48px;"> 易耗品 </span>
	             </div>
	            <div>
	                <span style="font-size:48px;">有偿用品 </span>
	            </div>
	            <div>
	            	<span style="font-size:48px;">布草 </span>
	            </div>
	        </div>
	    </header>    
   
    
 
        <div id="tt" class="easyui-tabs"  data-options="tabHeight:160,fit:true,tabPosition:'bottom',border:false,pill:true,narrow:true,justified:true">
			<div >
				<div class="panel-header tt-inner">
				    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="toHomePage()">
					<img src='images/homepage.png' width="245.25" height="160" onerror="this.src='common/images/default.gif;this.onerror=null'">
					</a>
				</div>
			</div>
			
			<div >
				<div class="panel-header tt-inner">
				    <a href="javascript:void(0)" class="easyui-linkbutton" onclick=""> 
					<img src='images/categroy.png' width="245.25" height="160" onerror="this.src='common/images/default.gif;this.onerror=null'">
					</a>
				</div>
			</div>
			
			<div >
				<div class="panel-header tt-inner">
				<span class="m-badge" id="ordernumber" style="font-size:48px;"></span>
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="editOrder()">
					<img src='images/cart.png' width="245.25" height="160" onerror="this.src='common/images/default.gif;this.onerror=null'">
					
					</a>
				</div>
				
			</div>
			<div >
				<div class="panel-header tt-inner">
					<a href="javascript:void(0)" class="easyui-linkbutton" onclick="loginClient()">
					<img src='images/login.png' id="clientimage" width="245.25" height="160" onerror="this.src='common/images/default.gif;this.onerror=null'">
		    		</a>
		        </div>
			</div>
	</div>

    <div style="background:#C71585;padding:5px;height:100%;width:100%;z-index:1">
	    <div id="productlist">
		    <ul class="m-list" id="product-m-list">
		    
		    </ul>
		</div>
	</div>

	
	
</body>
</html>
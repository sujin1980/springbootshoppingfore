<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
	<title>Menu on Toolbar - jQuery EasyUI Mobile Demo</title>
	
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/metro/easyui.css">
    <link rel="stylesheet" type="text/css" href="common/easyui/themes/mobile.css">
	<link rel="stylesheet" type="text/css" href="common/easyui/themes/icon.css">
	
	<script type="text/javascript" src="common/js/jquery.js"></script>
	<script type="text/javascript" src="common/js/jquery.min.js"></script>
	<script type="text/javascript" src="common/easyui/jquery.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="common/easyui/jquery.easyui.mobile.js"></script>
</head>
<style  type="text/css">
	#productlist li{
		float:left;
	}
	a{text-decoration:none;}
</style>

<script type="text/javascript">

$(function () {
	$('#mm').menu({
	    onClick:function(item){
			alert(item.text);
			getProductType(item.text);
	    }
	});
	
	$('#tt').tabs({
	    border:false,
	    onSelect:function(title, index){
			//alert(title+' is selected');
			//alert(index);
	    }
	});
});

function getProductById(id){
	return;
}
function updateProductList(data){
	if((data != null) && (data.length != 0)) {
		$("#product-m-list").children().filter('li').remove();
		$("#product-m-list").children().filter('label').remove();
		var thtmlbody = "";
		for(var i= 0; i< data.length; i++){
			thtmlbody += "<label for=\"价格\"> " + data[i].name + "</label><br />";
			for(var j= 0; j< data[i].productList.length; j++){
				thtmlbody += "<li><a href=\"javascript:void(0);\" onclick=\"getProductById("
					+ data[i].productList[j].id +  ")\">";
				thtmlbody += "<img src=\""+ data[i].productList[j].icon + "\"" + 
				    "alt=\"" + data[i].productList[j].name + "的图片\"  onerror=\"this.src='common/images/default.gif;this.onerror=null'\"> </a>";
				thtmlbody += "<span style=\"position: absolute; bottom: 0; left: 0;\">"
					 + data[i].productList[j].name +"</span></li>";
	        	
			}
			if(i != (data.length -1)){
				thtmlbody += "<br /><br /><br /><br /><br />";
			}
		}
		
		console.log(thtmlbody);
		$("#product-m-list").append(thtmlbody);
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
			//alert("ok");			
			updateProductList(data);
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("checkField fail");
		}
	});
}

function loginClient(){
	window.location.href = "login.jsp";	
	return;
}

</script> 

<body class="easyui-layout">
    <div data-options="region:'north',split:false,border:true" style="overflow:hidden;height:50px;width:100%;z-index:1">
		
            <div class="m-toolbar">
                <div class="m-title">Menu on Toolbarjsp</div>
                <div class="m-left">
                	<a href="javascript:void(0)" class="easyui-menubutton" data-options="iconCls:'icon-more',plain:true,hasDownArrow:false,menu:'#mm',menuAlign:'right'"></a> 
                </div>
                <div class="m-right">
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true"></a>
                    <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-man',plain:true"></a>
                </div>
            </div>
            <div id="mm" class="easyui-menu" style="width:150px;" data-options="itemHeight:30,noline:true">
	            <div>易耗品</div>
	            <div>有偿用品</div>
	            <div>布草</div>
	        </div>
    </div> 
    
    <div data-options="region:'south',split:false,border:true" style="padding:5px;height:50px;width:100%;z-index:1">   
		       
		        <div id="tt" class="easyui-tabs" data-options="tabHeight:60,fit:true,tabPosition:'bottom',border:false,pill:true,narrow:true,justified:true">
					<div style="padding:10px">
						<div class="panel-header tt-inner">
						    <a href="javascript:void(0)" class="easyui-linkbutton" onclick="">
							<img src='common/images/default.gif'/>首页
							</a>
						</div>
						
					</div>
					<div style="padding:10px">
						<div class="panel-header tt-inner">
						    <a href="javascript:void(0)" class="easyui-linkbutton" onclick=""> 
							<img src='common/images/default.gif'/>分类
							</a>
						</div>
						
					</div>
					<div style="padding:10px">
						<div class="panel-header tt-inner">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="editOrder()">
							<img src='common/images/default.gif'/><br>订单
							</a>
						</div>
						
					</div>
					<div style="padding:10px">
						<div class="panel-header tt-inner">
							<a href="javascript:void(0)" class="easyui-linkbutton" onclick="loginClient()">
							<img src='common/images/default.gif'/><br>登录
				    		</a>
				        </div>
					</div>
				</div>
		  
	</div>
    
    <div data-options="region:'center',split:false,border:true" style="padding:5px;height:100%;width:100%;z-index:1">
	    <div id="productlist">
		    <ul class="m-list" id="product-m-list">
		    
		    </ul>
		</div>
	</div>
	
    <style scoped>
    .tt-inner{
         display:inline-block;
         line-height:12px;
         padding-top:5px;
     }
		p{
			line-height:150%;
		}
	</style>
	<style>
	.box{width:50px;text-align:center; font-szie:18px;}
	.box img {width:100%;}
	</style>
	
	
</body>
</html>
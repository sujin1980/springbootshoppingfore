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


$(document).ready(function () {
	$("#imgfileupsel").change(function() {
        var $file = $(this);
        var fileObj = $file[0];
        var windowURL = window.URL || window.webkitURL;
        var dataURL;
        var $img = $("#productimg");
        
        if(fileObj && fileObj.files && fileObj.files[0]){
	        dataURL = windowURL.createObjectURL(fileObj.files[0]);
	        $img.attr('src',dataURL);
        }else{
	        dataURL = $file.val();
	        var imgObj = document.getElementById("productimg");
	        imgObj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
	        //imgObj.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = dataURL;
	        imgObj.src = dataURL;
        }
    });
	        
	initField(2); 
});

var getTypeList = function (val)
{	
	$.ajax({
		type: "POST",
		data: {
			"id" : JSON.stringify(val)
		},
		url : 'producttype/getTypeListByCategoryStrId.do',	
		success : function(data) {
			//console.log("ok");			
			if (data != null) {
				var obj=document.getElementById('producttypesel');
				obj.options.length=0;
			    for (var i = 0; i < data.length; i++) {
			    	obj.options.add(new Option(data[i].name, data[i].id));
				} 
			    var obj2 = document.getElementById('productcategorysel' );
				for(i=0;i<obj2.length;i++){
				  if(obj2[i].value == 2)
					  obj2[i].selected = true;
				}
			    
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("checkField fail");
		}
	});
	 
}

var initField = function (val)
{	
	getTypeList(val);
}

var checkField = function (val)
{	
	var strid = null; 
	if(val.indexOf("=") > 0){
		strid = val.substring(0, val.indexOf("="));
	}else{
		strid = val;
	}
	
	getTypeList(parseInt(strid));	
}

function uploadimage(fileData) {
    var formData = new FormData();
    formData.append('file', $('#imgfileupsel')[0].files[0]);
    
    $.ajax({
		type: "POST",
		data: formData,
		processData: false,
        contentType: false,
		url: "file/upload.do",
		success : function(data) {
		    var $img = $("#productimg");
		    $img.attr('src',data); 
			console.log(data);		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("checkField fail");
		}
	});
}

function canceluploadimage(fileData) {
	document.getElementById("imgfileupsel").value = "";
	$("#icon").val = "";
    $("#productimg").val = "";
    $("#productimg").src = "";
    
    var obj = $("#productimg");
    $("productimg").removeAttr("src");
    window.URL.revokeObjectURL(obj.src); 
    return;
}



function addRow()
{
	var obj = new Object;
	var $img = $("#productimg");
	var testsrc = $("#productimg").attr('src');
	//console.log("addRow begin");
	//console.log(testsrc);
	obj.name   =$("#name").val();
	obj.typeid = $("#producttypesel").val();
	obj.price  = $("#price").val();
	obj.icon   = $("#productimg").attr('src');
	obj.remarks = $("#remarks").val();
	
	console.log("addRow");
	
	$.ajax({
    	contentType : "application/json;charset=UTF-8",
		dataType : "json",
        type: "POST",
		data: {
			name:   $("#name").val(),
			typeid: $("#producttypesel").val(),
			price: $("#price").val(),
			icon:  $("#productimg").attr('src'),
			remarks: $("#remarks").val(),
		},
		url : '/product/add2.do',
		success : function(data) {			
			console.log("addRow success");
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			console.log("addRow fail");
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
				<li><a href="javascript:void(0);">商品管理</a></li>
				<li><a href="javascript:void(0);"> 添加商品</a></li>
				</ul>
			</div>
			<br />
		<div class="box-body" style="text-align:center; align-items:center; ">	
			<table cellpadding="0" cellspacing="1" border="0">
			    <tr>    
			        
			        <!-- 用户输入文本条件 -->
			        <td><input id="userInputCondition" name="userInputCondition" type="text" style="width:200px;"></input></td>                            
			    </tr>                        
		    </table>
		   <label id="id" for="名称"  >名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label> <input class="easyui-textbox" id="name" name="name"><br></br>
		   <label for="一级分类">一级分类&nbsp;</label>
		   <select id="productcategorysel" name="dept" style="width:150px;" onchange="checkField(this.value)">
			   <option value="2">有偿用品</option>
			   <option value="3">皮草</option>
			   <option value="4">易耗品</option>
		   </select>
		   <br></br>
		   <label for="二级分类">二级分类&nbsp;</label>
		   <select id="producttypesel" style="width:150px;">
		   </select>
		   <br></br>
		   <label for="价格">价格&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="price" name="price" style="width:150px;"><br></br>
		   <div>
		      <label for="图标">图标</label><br></br>
		      <tr>	
			       <td>
			      		<img alt="" id="productimg" src="" width="100px" height="100px">	            	 
			       </td>
			       <br />
			       
			       <td> 
				       <span class="">
			              <span>上传</span>   
			              <input type="file"  id="imgfileupsel" title="选择图片"  accept="image/gif">
				       </span>
			       </td>
			       
				   <td> <button type="button" class="btn btn-default" title="上传" onclick="uploadimage()"><i class="fa fa-trash-o"></i>上传</button></td> 
				  
			   </tr>
		   <div>	 
		   <br></br>
		   <label for="商品介绍">商品介绍&nbsp;</label><input class="easyui-textbox" id="remarks" name="remarks" style="width:150px;"><br></br>
		   <div class="btn-group">
		       <button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i> 新建</button>
		       &nbsp; &nbsp; &nbsp;
		        <input type="reset"  class="btn btn-default" value="重置"  />
		   </div>、
	  </div>
  </div>  	
</body>

</html>

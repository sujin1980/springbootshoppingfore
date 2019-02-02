<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <!-- 页面meta -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>商品管理</title>
    <!-- Tell the browser to be responsive to screen width -->
    <meta content="width=device-width,initial-scale=1,maximum-scale=1,user-scalable=no" name="viewport">
    <link rel="stylesheet" href="../plugins/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/AdminLTE.css">
    <link rel="stylesheet" href="../plugins/adminLTE/css/skins/_all-skins.min.css">
    <link rel="stylesheet" href="../css/style.css">
	<script src="../plugins/jQuery/jquery-2.2.3.min.js"></script>
    <script src="../plugins/bootstrap/js/bootstrap.min.js"></script>
	
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
});

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
			alert(data);		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("checkField fail");
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

function checkField(val)
{	
	$.ajax({
		type: "POST",
		data: val,
		url : 'producttype/getTypeListByCategoryId.do',	
		success : function(data) {
			//alert("ok");			
			if (data != null) {
				var obj=document.getElementById('producttypesel');
				obj.options.length=0;
			    for (var i = 0; i < data.length; i++) {
			    	obj.options.add(new Option(data[i].name, data[i].id));
				} 
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("checkField fail");
		}
	});
	 
}

function addRow()
{
	var obj = new Object;
	var $img = $("#productimg");
	var testsrc = $("#productimg").attr('src');
	//alert("addRow begin");
	//alert(testsrc);
	obj.name   =$("#name").val();
	obj.typeid = $("#producttypesel").val();
	obj.price  = $("#price").val();
	obj.icon   = $("#productimg").attr('src');
	obj.remarks = $("#remarks").val();
	
	alert("addRow");
	
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
			alert("addRow success");
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("addRow fail");
			//window.location.replace("https://www.runoob.com");
		}
	});
}

</script>
	 
  </head>
  
<body class="hold-transition skin-red sidebar-mini" >
	<div class="box-header with-border">
        <h3 class="box-title">商品管理</h3>
    </div>

    <div class="box-body">
	   <label for="名称">名称</label> <input type="text" id="name" name="name"><br></br>
	   <label for="一级分类">一级分类</label>
	   <select onchange="checkField(this.value)">
		   <option value="2">有偿用品</option>
		   <option value="3">皮草</option>
		   <option value="4">易耗品</option>
	   </select>
	   <br></br>
	   <label for="二级分类">二级分类</label>
	   <select id="producttypesel">
	   </select>
	   <br></br>
	   <label for="价格">价格</label><input type="text" id="price" name="price"><br></br>
	   <div>
	      <label for="图标">图标</label><input type="text" id="icon" name="icon" hidden="true"><br></br>
	      <tr>					                           
		       <td>
		       
		       </td>
		       <td>
		      		<img alt="" id="productimg" src="" width="100px" height="100px">	            	 
		       </td>

		       <td><input type="file"  id="imgfileupsel" title="选择图片" accept="image/gif"> </td>
			   <td> <button type="button" class="btn btn-default" title="上传" onclick="uploadimage()"><i class="fa fa-trash-o"></i>上传</button></td> 
			   <td> <button type="button" class="btn btn-default" title="取消上传" onclick="canceluploadimage()"><i class="fa fa-trash-o"></i>取消上传</button></td> 
		   </tr>
	   <div>	 
	   <label for="商品介绍">商品介绍</label><input type="text" id="remarks" name="remarks"><br></br>
	   <div class="btn-group">
	       <button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i> 新建</button>
	       &nbsp; &nbsp; &nbsp;
	        <input type="reset" value="重置"  />
	   </div>、
  </div>	
  </body>
</html>

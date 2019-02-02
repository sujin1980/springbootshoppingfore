<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <base href="<%=basePath%>">
    
    <title>添加一级商品类型</title>
	<h1>添加一级商品类型</h1>
	
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

	initField(${product.productType.productCategory.id});
	
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
			alert("ok");			
			if (data != null) {
				var obj=document.getElementById('producttypesel');
				obj.options.length=0;
			    for (var i = 0; i < data.length; i++) {
			    	obj.options.add(new Option(data[i].name, data[i].id));
				} 
			    var obj2 = document.getElementById('productcategorysel' );
				for(i=0;i<obj2.length;i++){
				  if(obj2[i].value == ${product.productType.productCategory.id})
					  obj2[i].selected = true;
				}
			    
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("checkField fail");
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

var uploadimage = function (fileData) {
    var formData = new FormData();
    formData.append('file', $('#imgfileupsel')[0].files[0]);
    
    $.ajax({
		type: "POST",
		data: formData,
		processData: false,
        contentType: false,
		url: "file/upload.do",
		success : function(data) {
			$("#icon").val = data;
			alert("ok");		
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("checkField fail");
		}
	});
}



var addRow = function ()
{
	var obj = new Object;
	
	alert("addRow begin");
	
	obj.name   =$("#name").val(),
	obj.typeid = $("#producttypesel").val(),
	obj.price  = $("#price").val(),
	obj.icon   = $("#icon").val(),
	obj.remarks = $("#remarks").val(),
	
	alert("addRow");
	alert($("#productid").val());
	$.ajax({
    	contentType : "application/json;charset=UTF-8",
		dataType : "json",
        type: "POST",
		data: {
			id: $("#productid").val(),
			name:$("#name").val(),
			typeid:$("#producttypesel").val(),
			price:$("#price").val(),
			icon:$("#icon").val(),
			remarks:$("#remarks").val(),
		},
		url : '/product/edit2.do',
		success : function(data) {			
			alert("addRow success");
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			alert("addRow fail");
			//window.location.replace("https://www.runoob.com");
		}
	});
}

var showImg = function(fileObj,imgId) {
	 
    var file=fileObj.files[0];
           var r = new FileReader();
                r.readAsDataURL(file);
                $(r).load(function() {
                    $('#productimg').attr("src", this.result);
            })                   
     
}

</script>
	 
  </head>
  
  <body>
	<form name="productForm" >
	   <input type="text" id="productid" name="productid" hidden="true" value = "${product.id}">
	   <label for="名称">名称</label> <input type="text" id="name" name="name" value = "${product.name}"><br></br>
	   <label for="一级分类">一级分类</label>
	   <select id="productcategorysel" onchange="checkField(this.value)">
		   <option value="2">有偿用品</option>
		   <option value="3">皮草</option>
		   <option value="4">易耗品</option>
	   </select>
	   <br></br>
	   <label for="二级分类">二级分类</label>
	   <select id="producttypesel">
	   </select>
	   <br></br>
	   <label for="价格">价格</label><input type="text" id="price" name="price" value = "${product.price}"><br></br>
	   <div>
	      <label for="图标">图标</label><input type="text" id="icon" name="icon" hidden="true" value = "${product.icon}"><br></br>
	      <tr>					                           
		       <td>
		       
		       </td>
		       <td>
		      		<img alt="" id="productimg" src="${product.icon}" width="100px" height="100px">	            	 
		       </td>

		       <td><input type="file"  id="imgfileupsel" title="选择图片" accept="image/gif"> </td>
			   <td> <button type="button" class="btn btn-default" title="上传" onclick="uploadimage()"><i class="fa fa-trash-o"></i>上传</button></td> 
			   <td> <button type="button" class="btn btn-default" title="取消上传" onclick="canceluploadimage()"><i class="fa fa-trash-o"></i>取消上传</button></td> 
		   </tr>
	   <div>	 
	   <label for="商品介绍">商品介绍</label><input type="text" id="remarks" name="remarks" value = "${product.remarks}"><br></br>
	   <div class="btn-group">
	       <button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i> 新建</button>
	       &nbsp; &nbsp; &nbsp;
	        <input type="reset" value="重置"  />
	   </div>
	</form>
	<div class="modal fade" id="uploadModal" tabindex="-1" role="dialog" labelledby="myModalLabel" hidden="true">
	  <div class="modal-dialog" >
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" hidden="true">×</button>
				<h3 id="myModalLabel">上传商品图片</h3>
			</div>
			<div class="modal-body">							
				
				<table class="table table-bordered table-striped">
			      	<tr>
			      		<td>颜色</td>
			      		<td><input  class="form-control" placeholder="颜色" >  </td>
			      	</tr>			    
			      	<tr>
			      		<td>商品图片</td>
			      		<td>
							<table>
								<tr>
									<td>
									<input type="file" id="file" />				                
						                <button class="btn btn-primary" type="button" >
					                   		上传
						                </button>	
						            </td>
									<td>
										<img  src="" width="200px" height="200px">
									</td>
								</tr>						
							</table>
			      		</td>
			      	</tr>		      	
				 </table>				
				
			</div>
			<div class="modal-footer">						
				<button class="btn btn-success"  data-dismiss="modal" hidden="true">保存</button>
				<button class="btn btn-default" data-dismiss="modal" hidden="true">关闭</button>
			</div>
		  </div>
		</div>
	</div>
  </body>
</html>

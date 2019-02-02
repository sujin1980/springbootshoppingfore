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
<script>
function addRow(){
	//window.open("/product/toAdd2");
	window.location.href = "/product/toAdd2";
}

function deleteRows(){
    var che = document.getElementsByName("goodscheckbox");  
    var idlist = {};
    
    for(var i=0; i < che.length;i++){  
        if(che[i].checked == true){
        	idlist[i] = che[i].id;
        }
    }  
    
    $.ajax({
    	dataType: "json",  
        type: "POST",
		data: idlist,
		url : '/product/deleteProducts.do',
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
				  if(obj2[i].value == 2)
					  obj2[i].selected = true;
				}
			    
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
    
}

function allcheck() {
	var allche = document.getElementById("selall");  
    var che = document.getElementsByName("goodscheckbox");  
    if(allche.checked == true){  
        for(var i=0;i<che.length;i++){  
            che[i].checked="checked";  
        }  
    }else{  
        for(var i=0;i<che.length;i++){  
            che[i].checked=false;  
        }  
    }  
 }
   
 function goodsclickcheck(obj) {
	if(obj.checked==false){  
        var allche = document.getElementById("selall");  
        allche.checked = false;
    }
}
     
function  editRow(obj){
    var i = 1;
	alert(i);
	return;	 
}

function getDataRow(h){ 
	   var row = document.getElementById('productlist'); //创建行 
	   var idCell = document.createElement('td'); //创建第一列id 
	   idCell.innerHTML = h.id; //填充数据 
	   row.appendChild(idCell); //加入行 ，下面类似 
	   var nameCell = document.createElement('td');//创建第二列name 
	   nameCell.innerHTML = h.name; 
	   row.appendChild(nameCell); 
	   var jobCell = document.createElement('td');//创建第三列job 
	   jobCell.innerHTML = h.job; 
	   row.appendChild(jobCell); 
	   //到这里，json中的数据已经添加到表格中，下面为每行末尾添加删除按钮 
	   var delCell = document.createElement('td');//创建第四列，操作列 
	   row.appendChild(delCell); 
	   var btnDel = document.createElement('input'); //创建一个input控件 
	   btnDel.setAttribute('type','button'); //type="button" 
	   btnDel.setAttribute('value','删除');  
	   //删除操作 
	   btnDel.onclick=
	   delCell.appendChild(btnDel); //把删除按钮加入td，别忘了 
	   return row; //返回tr数据   
	}   
	
function getProductByName(){
	var strid = ""; 
	
	var val = $("#name").val();
	if(val.indexOf("=") > 0){
		strid = val.substring(0, val.indexOf("="));
	}else{
		strid = val;
	}
	
	$.ajax({
    	dataType: "json",  
        type: "POST",
		data: {
			"name": strid
		},
		url : '/product/getproductbyname.do',
		success : function(data) {
			 alert("ok");
			 if (data != null) {  
				 //var obj=document.getElementById('productlist');
				 $("productlist").html("");
				 var tbodyhtmlod = '';
			
				 for(var i= 0; i< data.length; i++){
					  
					  
					  tbodyhtmlod += '<tr class="odd gradeX">';
					  tbodyhtmlod += '<td> <input id=' + data[i].id + 'class="odd gradeX" type="checkbox" name="goodscheckbox" '
					      + 'style="visibility: visible" onclick="goodsclickcheck(this)"> </td>';
					  tbodyhtmlod += '<td> ' + data[i].id   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].name + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].productType.name + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].productType.productCategory.name + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].price   + '</td>';
					  tbodyhtmlod += '<td> ' + data[i].remarks + '</td>';
					  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
					      '<a href="<%=basePath%>/product/toEdit2?id=' + data[i].id + '">查看</a> ';
					  tbodyhtmlod += '<a href="<%=basePath%>ordergoods/toAdd2?id=' + data[i].id + '">加入订单</a></td> </tr>';
				 }

				 console.log(tbodyhtmlod);
				 $("#productlist").html(tbodyhtmlod);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
	
	return;
}


</script>
 
<body class="easyui-layout">
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
		<li><a href="javascript:void(0);">首页</a></li>
		<li><a href="javascript:void(0);">商品管理</a></li>
		<li><a href="javascript:void(0);">商品列表</a></li>
		</ul>
	</div>
	
	<div class="rightinfo">
		<div class="tools">
		<ul class="seachform">
		<li><label>商品名称</label><input id="name" name="name" type="text" class="scinput" /></li>
		
		<li><label>&nbsp;</label><input name="" type="button" onclick="getProductByName();" class="scbtn" value="查询"/></li>
		</ul>
		<ul class="toolbar">
		</ul>
		<ul class="toolbar1">
		</ul>
		</div>
	</div>
	
	<div class="tools">
		<ul class="toolbar">
			<button type="button" class="btn btn-default" title="新建"  onclick="addRow()" ><i class="fa fa-file-o"></i> 新建</button>
	        <button type="button" class="btn btn-default" title="删除"  onclick="deleteRows()"><i class="fa fa-trash-o"></i> 删除</button>
	        <button type="button" class="btn btn-default" title="刷新"  onclick="window.location.reload();"><i class="fa fa-refresh"></i> 刷新</button>
		</ul>
	</div>
	
	<div class="container">
	<div id="tt" class="easyui-tabs" data-options="tabWidth:150,tabHeight:40" style="width:100%;height:800">
	<div title="<span class='tt-inner'>商品列表<br></span>" style="padding:10px">
		<table class="table table-border table-bordered table-hover table-bg">
			<thead>
				<tr class="text-c">
				    <th style="width: 1%">
	                    <input id="selall" onclick="allcheck()" type="checkbox"/>
	                </th>
					<th style="width: 5%">商品ID</th>
					<th style="width: 15%">名称</th>
					<th style="width: 15%">一级分类</th>
					<th style="width: 15%">二级分类</th>
					<th style="width: 15%">商品价格</th>
					<th style="width: 10%">描述</th>
					<th style="width: 10%">明细</th>
				</tr>
			</thead>
			<tbody id="productlist">
				<c:forEach items="${ products }" var="product">
					<tr  class="odd gradeX">
					    <td><input id=${product.id} class="odd gradeX" type="checkbox" name="goodscheckbox" style="visibility: visible" onclick="goodsclickcheck(this)"> </td>
						<td> ${product.id} </td>
						<td> ${product.name} </td>
						<td> ${product.productType.name} </td>
						<td> ${product.productType.productCategory.name} </td>
						<td> ${product.price} </td>
						<td> ${product.remarks} </td>
						<td class="text-center">                                          
		             	   <a href="<%=basePath%>product/toEdit2?id=${product.id}">查看</a>  
		             	   <a href="<%=basePath%>ordergoods/toAdd2?id=${product.id}">加入订单</a>
		              </td>
		                 
					</tr>
				</c:forEach>				
		   </tbody>
		</table>
		<span><div class="easyui-pagination" data-options="total:20" id="pp" style="width:80%;margin-left:40px;"></div></span>
	</div>
	</div>
	</div>
	
	<div id="dlg" class="easyui-dialog" style="padding:10px 20px; width: 850px; height: 500px;" closed="true" buttons="#dlg-buttons">
	<form id="fm" method="post" novalidate>
	    <input type="hidden" id="id" name="id">
	    <div class="fitem">
	    	<ul class="seachform">
	        <li><label><b>标题 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b></label>
	        	<input id="titleVal" name="title" class="scinput" data-options="" required="true">
	        </li>
	        <li>
	            <label><b>公告状态&nbsp;&nbsp;</b></label>
	            <select class="scinput" id="statusVal" name="status">
					    <option value="1">已发布</option>
					    <option value="2">未发布</option>
					    <option value="3">已过期</option>
					    <option value="4">已删除</option>
				</select>
	        </li>
	        
	        <li>
	            <label><b>是否置顶&nbsp;&nbsp;</b></label>
	            <select class="scinput" id="locationVal" name="status">
					    <option value="1">置顶</option>
					    <option value="2">不置顶</option>
				</select>
	        </li>
				</ul>
				
				<ul class="seachform">
				<li><label><b>发布时间&nbsp;&nbsp;</b></label><input id="publishdate" class="easyui-datebox"  style="width:152px;height:32px"/></li>
			<li><label><b>截止时间&nbsp;&nbsp;</b></label><input id="deadtime" class="easyui-datebox"  style="width:152px;height:32px"/></li>  
			<li>
	            <label><b>公告类型&nbsp;&nbsp;</b></label>
	            <select class="scinput" id="infoType" name="status" readonly="true">
					    <option value="1">一般公告</option>
					    <option value="2">帮助</option>
				</select>
	        </li> 
			</ul>
		</div> 
	    <div class="fitem">
	        <label><b>内容&nbsp;&nbsp;</b></label>
	        <textarea id="editor_id" name="content" style="width:780px;height:300px;">
				&lt;strong&gt;&lt;/strong&gt;
			</textarea>
	    </div>
	</form>
	</div>
	<div id="dlg-buttons">
	<input name="" type="button"  class="sure"     id="saveOrUpdateConfirm"  value="确定" />&nbsp;
	<input name="" type="button"  class="cancel"   onclick="javascript:$('#dlg').dialog('close')" value="取消" />
	</div>
	<div class="tip" id="deleteNoticeTipDiv">
	<div class="tiptop"><span>删除公告</span><a id="tiptopA"></a></div>
	  	<div class="tipinfo">
	        <span><img src="common/images/ticon.png" /></span>
	        <div class="tipright">
	        <p>是否确认对信息的删除？</p>
	        <cite>如果是请点击确定按钮 ，否则请点取消。</cite>
	    </div>
	</div>
	<div class="tipbtn">
	    <input name="" type="button"  id="deleteNoticeSure"  class="sure" value="确定" />&nbsp;
	    <input name="" type="button"  id="deleteNoticeCancel" class="cancel" value="取消" />
	</div>
	</div>
</body>

</html>
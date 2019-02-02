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

function addRow(){
	window.open("toAdd2");
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
 
 </script>
</head>

<body class="hold-transition skin-red sidebar-mini" >
  <!-- .box-body -->
                
                    <div class="box-header with-border">
                        <h3 class="box-title">商品管理</h3>
                    </div>

                    <div class="box-body">

                        <!-- 数据表格 -->
                        <div class="table-box">

                            <!--工具栏-->
                            <div class="pull-left">
                                <div class="form-group form-inline">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i> 新建</button>
                                        <button type="button" class="btn btn-default" title="删除"  onclick="deleteRows()"><i class="fa fa-trash-o"></i> 删除</button>
                                        <button type="button" class="btn btn-default" title="刷新" onclick="window.location.reload();"><i class="fa fa-refresh"></i> 刷新</button>
                                    </div>
                                </div>
                            </div>
                            <div class="box-tools pull-right">
                                <div class="has-feedback">
							                  商品名称：<input >									
									<button class="btn btn-default" >查询</button>                                    
                                </div>
                            </div>
                            <!--工具栏/-->

			                  <!--数据列表-->
			                  <table id="dataList" class="table table-bordered table-striped table-hover dataTable">
			                      <thead>
			                          <tr>
			                              <th>
                                                 <input id="selall" onclick="allcheck()" type="checkbox"/>
                                          </th>
                                          <th class="sorting_asc">商品ID</th>
									      <th class="sorting">商品名称</th>
									      <th class="sorting">商品价格</th>
									      <th class="sorting">一级分类</th>
									      <th class="sorting">二级分类</th>
									      <th class="sorting">描述</th>								     						
					                      <th class="text-center">操作</th>
			                          </tr>
			                      </thead>
			                      <tbody>
											<c:forEach items="${ products }" var="product">
											<tr>
											    <td><input id=${product.id} type="checkbox" name="goodscheckbox" style="visibility: visible" onclick="goodsclickcheck(this)"> </td>
												<td> ${product.id} </td>
												<td><input type='text' name= "name"         style="width: 100%; height: 100%" value = ${product.name}> </td>
												<td><input type='text' name= "price"        style="width: 100%; height: 100%" value = ${product.price}> </td>
												<td><input type='text' name= "typename"     style="width: 100%; height: 100%" value = ${product.productType.name}> </td>
												<td><input type='text' name= "categoryname" style="width: 100%; height: 100%" value = ${product.productType.productCategory.name}> </td>
												<td><input type='text' name= "remarks"      style="width: 100%; height: 100%" value = ${product.remarks}> </td>
												<td class="text-center">                                          
			                                 	  <button type="button"  class="btn bg-olive btn-xs"><a href="<%=basePath%>/product/toEdit2?id=${product.id}">编辑</a></button>   
			                                  </td>
											</tr>
									   </c:forEach>				
			                      </tbody>
			                  </table>
			                  <!--数据列表/-->                        
							  
							 
                        </div>
                        <!-- 数据表格 /-->
                        
                        
                     </div>
                    <!-- /.box-body -->
		
</body>

</html>
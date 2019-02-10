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


$(document).ready(function(){
	var _body = window.parent;
	var _iframe1 = _body.document.getElementById('topFrame');
	_iframe1.contentWindow.location.reload(true);
});

function addRow(){
	window.location.href = "/product/list2";
}

function decGoodsNumber(goodsId){
	$.ajax({
		type: "POST",
	    async: true,
	    data: {
			"orderid": $('#orderid').val(),
			"goodsid": goodsId,
			"number": -1
		},
	    dataType : 'json',
		url : '/ordergoods/modifyGoodsNumber.do',
		success : function(data) {
			 alert("ok");
			 if (data != null) {  
				 modifygoodstable(data);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
}

function modifygoodstable(data){
	$("orderlist").html("");
	var tbodyhtmlod = '';

	 for(var i= 0; i< data.length; i++){
		 tbodyhtmlod += '<tr class="odd gradeX">';
		  tbodyhtmlod += '<td> <input id=' + data[i].goodsId + 'class="odd gradeX" type="checkbox" name="goodscheckbox" '
		      + 'style="visibility: visible" onclick="goodsclickcheck(this)"> </td>';
		  tbodyhtmlod += '<td> ' + data[i].goodsName   + '</td>';
		  tbodyhtmlod += '<td> ' + data[i].price + '</td>';
		  tbodyhtmlod += '<td> ' + data[i].goodsNumber + '</td>';
		  tbodyhtmlod += '<td> ' + data[i].goodsFee + '</td>';
		  tbodyhtmlod += '<td> ' + data[i].picture   + '</td>';
		  tbodyhtmlod += '<td> ' + data[i].remarks + '</td>';
		  tbodyhtmlod += '<td ' + 'class="text-center">' +                                           
		      '<a href="<%=basePath%>/product/toEdit2?id=' + data[i].id + '">查看</a> ';
		  tbodyhtmlod += '<a href="javascript:void(0);" onclick="addGoodsNumber('+ data[i].goodsId + ');return false;">增加数量</a>'; 	  
		  tbodyhtmlod += '<a href="javascript:void(0);" onclick="decGoodsNumber('+ data[i].goodsId + ');return false;">减少数量</a></td> </tr>';
	 }

	 console.log(tbodyhtmlod);
	 $("#orderlist").html(tbodyhtmlod);
}
function addGoodsNumber(goodsId){
	$.ajax({
		type: "POST",
	    async: true,
	    data: {
			"orderid": $('#orderid').val(),
			"goodsid": goodsId,
			"number": 1
		},
	    dataType : 'json',
		url : '/ordergoods/modifyGoodsNumber.do',
		success : function(data) {
			 alert("ok");
			 if (data != null) {  
				 modifygoodstable(data);
		   }
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
			 alert("fail");
		}
	});
}

</script>
  
<body  class="easyui-layout" style="width:100%;height:100%;">
     <!--- <div data-options="region:'north',split:false,border:true" style="overflow:hidden;height:90px;z-index:1">
		<iframe src="top.jsp" width="100%" name="topFrame" scrolling="No" id="topFrame" title="topFrame"></iframe>
	</div> ---> 
	<div data-options="region:'west',split:false,border:true" style="width:30%;">
	    
    	<div class="place">
			<span>位置：</span>
			<ul class="placeul">
			<li><a href="javascript:void(0);">首页</a></li>
			<li><a href="javascript:void(0);">订单管理</a></li>
			<li><a href="javascript:void(0);">添加商品</a></li>
			</ul>
		</div>
		<br />
		<div class="box-body" style="text-align:left; align-items:center; ">	
		   <label for="ordernum">订单号&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="orderid" name="orderid"  value = "${order.id}">
		   <br></br>
		   <label for="ordernum">订单状态&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
		   <select id="orderstatus" onchange="checkOrderStatusField(this.value)">
			   <option value="1">初始生成</option>
			   <option value="2">提交商家</option>
			   <option value="3">未付款</option>
			   <option value="4">已付款</option>
			   <option value="5">未发货</option>
			   <option value="6">已发货</option>
			   <option value="7">交易成功</option>
			   <option value="8">交易关闭</option>
			   <option value="9">待评价</option>
		   </select>
		   <br></br>
		   <label for="ordernum">支付方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
		   <select id="paymenttype" onchange="checkPaymentField(this.value)">
			   <option value="1">在线支付</option>
			   <option value="2">提交商家</option>
		   </select>
		   <br></br>
	
		   <label for="payment">金额&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="payment" name="payment" value = "${order.payment}"><br></br>
		   <label for="paymentTime">付款时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="paymenttime" name="paymenttime" value = "${order.paymentTime}"><br></br>
		   <label for="consignTime">发货时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="consigntime" name="consigntime" value = "${order.consignTime}"><br></br>
		   <label for="endTime">交易完成时间&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="endTime" name="endtime" value = "${order.endTime}"><br></br>
		   <label for="userName">买家名称&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="userName" name="username" value = "${order.userName}"><br></br>
		   <label for="receiverMobile">买家联系方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="receivermobile" name="receivermobile" value = "${order.receiverMobile}"><br></br>
		   <label for="receiverAreaName">买家地址&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><input class="easyui-textbox" id="receiverareaname" name="receiverareaname" value = "${order.receiverAreaName}"><br></br>
		   <div class="tools">
				<ul class="toolbar">
					<button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i> 确认</button>
					<button type="button" class="btn btn-default" title="刷新" onclick="window.location.reload();"><i class="fa fa-refresh"></i> 取消</button>
				</ul>
			</div>
		</div>
	  </div>
  </div> 
  
	<div data-options="region:'east',split:false" title="east" style="width:70%;">
		<div class="rightinfo">
			<div class="tools">
				<ul class="seachform">
				<li><label>商品名称</label><input id="title" name="title" type="text" class="scinput" /></li>
				<li><label>&nbsp;</label><input name="" type="button" onclick="getOrderById();" class="scbtn" value="查询"/></li>
				</ul>
				<ul class="toolbar">
				</ul>
				<ul class="toolbar1">
				</ul>
			</div>
		</div>
		
		
		
		<div class="container">
			<div id="tt" class="easyui-tabs" data-options="tabWidth:150,tabHeight:40" style="width:100%;height:800">
				<div title="<span class='tt-inner'>订单商品列表<br></span>" style="padding:10px">
					<table class="table table-border table-bordered table-hover table-bg">
						<thead>
							<tr class="text-c">
							    <th style="width: 1%">
				                    <input id="selall" onclick="allcheck()" type="checkbox"/>
				                </th>
								<th style="width: 10%">商品名称</th>
								<th style="width: 10%">商品单价</th>
								<th style="width: 10%">商品数量</th>
								<th style="width: 10%">商品总金额</th>
								<th style="width: 10%">商品图片</th>
								<th style="width: 10%">商品描述</th>
								<th style="width: 10%">操作</th>
							</tr>
						</thead>
						<tbody id="orderlist" >
							<c:forEach items="${ ordergoods }" var="ordergood">
								<tr class="odd gradeX">
								    <td><input id=${ordergood.goodsId} class="odd gradeX" type="checkbox" name="goodscheckbox" style="visibility: visible" onclick="goodsclickcheck(this)"> </td>
									<td> ${ordergood.goodsName} </td>
									<td> ${ordergood.price} </td>
									<td> ${ordergood.goodsNumber} </td>
									<td> ${ordergood.goodsFee} </td>
									<td> ${ordergood.picture} </td>
									<td> ${ordergood.remarks} </td>
									<td class="text-center">                                          
					             	  <a href="<%=basePath%>/product/toEdit2?id=${ordergood.goodsId}">查看</a></button>   
					             	  <a href="javascript:void(0);" onclick="addGoodsNumber('${ordergood.goodsId}');return false;">增加数量</a> 
					             	  <a href="javascript:void(0);" onclick="decGoodsNumber('${ordergood.goodsId}');return false;">减少数量</a> 
					                </td>
								</tr>
							</c:forEach>				
					   </tbody>
					</table>
					<span><div class="easyui-pagination" data-options="total:20" id="pp" style="width:80%;margin-left:40px;"></div></span>
				</div>
			</div>
		</div>
		
		<div class="tools">
			<ul class="toolbar">
				<button type="button" class="btn btn-default" title="新建"  onclick="addRow()"><i class="fa fa-file-o"></i>新增商品</button>
				<button type="button" class="btn btn-default" title="新建"  onclick="deleteRows()"><i class="fa fa-file-o"></i>删除商品 </button>
		        <button type="button" class="btn btn-default" title="删除"  onclick="deleteRows()"><i class="fa fa-trash-o"></i>确认</button>
			</ul>
		</div>
	
	</div>
     	
</body>

</html>

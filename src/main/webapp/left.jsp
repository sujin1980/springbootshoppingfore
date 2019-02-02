<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<title>top</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">

<link rel="stylesheet" type="text/css" href="common/css/style.css" />
<script type="text/javascript" src="common/js/jquery.js"></script>
</head>

<script type="text/javascript">
jQuery(document).ready(function() {
	var homepageId =window.location.search;
	homepageId = homepageId.substr(homepageId.indexOf("=")+1);
	
	$.ajax({
		type : "POST",
		url : "user/functionlist.do",
		data : {},
		success : function(data) {
			var tbodyhtmlod = '';
			var list = data;
			var d;
			if ((list != null) && (list.length > 0)) {
				
				tbodyhtmlod += '<dd id="id'+list[0].funId+'">';
				tbodyhtmlod += '<div class="title">';
				tbodyhtmlod += '<span><img src="common/images/' + list[0].defaultIco + '" /></span>' + list[0].name;
				tbodyhtmlod += '</div>';
				tbodyhtmlod += '<ul class="menuson">';
				for (var i = 1; i < list.length; i++) {
					if (0 == list[i].parentId) {
						tbodyhtmlod += '</ul>';
						tbodyhtmlod += '</dd>';
						tbodyhtmlod += '<dd id="id'+list[i].funId+'">';
						tbodyhtmlod += '<div class="title" id="id'+list[i].funId+'">';
						tbodyhtmlod += '<span><img src="common/images/' + list[i].defaultIco + '" /></span>' + list[i].name;
						tbodyhtmlod += '</div>';
						tbodyhtmlod += '<ul class="menuson">';
					}
					else
					{
						tbodyhtmlod += '<li id="'+list[i].funId+'"><cite></cite><a href="'
						tbodyhtmlod += list[i].url + '?pageid='+list[i].funId+'"';
						tbodyhtmlod += ' target="rightFrame">';
						tbodyhtmlod += list[i].name + '</a><i></i></li>'; 
						
					}
				}
				tbodyhtmlod += '</ul>';
				tbodyhtmlod += '</dd>';
			}
			//刷新表格数据
			$("#leftmenu").html(tbodyhtmlod);
			
			//当用户设置了首页的时候.
			if(homepageId !=""){
				//左侧菜单全部收起
				$('dd').find('ul').slideUp();
				//读取用户设置首页的id 并在左侧选中。
				$('#'+homepageId).parent().slideDown();
				$('#'+homepageId).addClass("active");
				document.cookie="currentHomePage="+homepageId; 

			}
			
			$(".menuson li").click( function() {
				$(".menuson li.active").removeClass("active");
				$(this).addClass("active");
				document.cookie="currentHomePage="+$(this).attr("id"); 
			});

			$('.title').click(function() {
				var $ul = $(this).next('ul');
				$('dd').find('ul').slideUp(); 
				if ($ul.is(':visible')) {
					$(this).next('ul').slideUp();
				} else {
					$(this).next('ul').slideDown();
				}
			});
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
		}
	});
});	

</script>

<body style="background: #f0f9fd;">
	<div class="lefttop">
		<span></span>功能导航
	</div>
	<dl class="leftmenu" id="leftmenu">	
		   
	</dl>
</body>
</html>

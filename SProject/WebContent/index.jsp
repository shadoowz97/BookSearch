<%@page contentType="text/html;charset=UTF-8"
pageEncoding="UTF-8"%>
 <%@page import="java.io.*" %>
    <%@page import="com.google.gson.Gson"%>
    <%@page import="java.net.URL"%>
    <%@page import="com.beans.*" %>
    <%@page import="org.User.*" %>
     <%@page import="com.GetDoubanSearch.*" %>
     <%@page import="java.util.*"%>
     <%@page import="com.info.*"%>
 <%User u=(User)session.getAttribute("user");
	 String name=null;
	 if(u!=null)
	  name=u.getUsername();
	 %>
<!DOCTYPE html>
<html>

	<head>
		<meta charset="UTF-8">
		<title></title>

		<script type="text/javascript" src="js/jquery-3.2.0.min.js"></script>
		<link rel="stylesheet" href="css/search.css" />
		<link rel="stylesheet" href="css/index.css" />
		<style type="text/css">
	#img{
     		position:absolute;
     		left:30px;
     		top:4px;
     		width:220px;
     		height:46px;
     		background-image: url("img/01.png");
     		background-color:"black";
     		
     	}
}
		</style>
		<script src="js/jquery-3.2.0.min.js"></script>
		<script>
var username='<%=name%>';
</script>
		<script>
			function mouseon(){
		$("#guide").animate({width:"80px"});
		$("#guide").css("text-align","center");
		}
		function mouseout(){
		$("#guide").animate({width:"10px"});
		2
		$("#guide").css("text-align","right");
		}
  
	
			function doFind() {
				$.ajax({
					cache: false,
					type: "POST",
					url: "IndexInitial.jsp", //把表单数据发送到IndexInitial.jsp
					data: $('#ajaxFrm').serialize(), //要发送的是ajaxFrm表单中的数据
					async:true,
					error: function(request) {
						alert("发送请求失败！");
					},
					success: function(data) {
						$("#ajaxFrm").html(data); //将返回的结果显示到ajaxDiv中
					}
				});
			}
		</script>
	</head>

	<body  onload="Pload()">

		<div id="bg">
			<div id="header">
			
		<div id=login>登&nbsp;&nbsp;&nbsp;录</div>
		<a href="Sign.html"><div id="signin">注&nbsp;&nbsp;&nbsp;册</div></a>
		<a id="img" href="index.jsp"> </a>
	</div>
	<form id="loginPage">
		<div id="userlable">用户名:</div>
		<input type="text" id="username" name="username" />
		<div id="passwordlabel">密&nbsp;&nbsp;码:</div>
		<input type="password" id="password" name="password" />
		<div id="returnmsg"></div>
		<hr id="loginHr" />
		<div id="loginsubmit">&nbsp;登&nbsp;录</div>
	</form>
			<div id="search">
				<form id="ss" action="Search.jsp" method="POST"> <input id="searchWord" name="query" type="text" />
				<input type="radio" id="way" name="way" value="db" checked/>
				<input type="image" src="img/s1.png" id="Simg" name=""></input>
				</form>
			</div>
			<div id="guide" onmouseover="mouseon()" onmouseleave="mouseout()">
			<a href="http://lucene.apache.org/" class="guidel">about lucene</a>
			<a href="usage.html" class="guidel">usage</a>
			<a href="setting.jsp" class="guidel">setting</a>
			<a href="otherl.html" class="guidel">other links</a>
			</div>
		</div>
<script>
		//此代码块用于控制样式
		//控制login和sigin样式
		if(username=='null'){
			$("#login").mouseover(
					function(){
						$(this).css("background","darkgray");
					}
				);
				$("#signin").mouseover(
					function(){
						$(this).css("background","darkgray");
					}
				);
				$("#login").mouseout(
					function(){
						$(this).css("background","black");
					}
				);
				$("#signin").mouseout(
					function(){
						$(this).css("background","black");
					}
				);
				var logsuit=false;
				$("#login").click(function(){
					if(!logsuit){
						$("#loginPage").css("display","block");
						logsuit=true;
					}
					else{
						$("#loginPage").css("display","none");
						logsuit=false;
					}
				})}
		else{
			$("#header").html("<a id=\"img\" href=\"index.jsp\"></a><a id=\"personalRec\" href=\"pi.jsp?target=personrec\">个性推荐</a><a id=\"personalInfo\" href=\"pi.jsp?target=personinfo\">个人信息</a><a id=\"personalPre\" href=\"pi.jsp?target=personPre\">偏好调整</a><a id=\"searcherHistory\" href=\"pi.jsp?target=searcherHistory\">浏览历史</a><div id=\"person\">欢迎："+username+"</div>");
			$("#header").children().each(function(){
				if($(this).attr("id")!="img"){
					$(this).mouseover(function(){
						$(this).css("background-color","green");
					})
					$(this).mouseout(function(){
						$(this).css("background-color","black");
					})
					$(this).click(function(){
						$(this).css("background-color","green");
					})
				}
			})
		}
			</script>
	<script>
				//此代码块用于进行登录和注册操作
				$("#loginsubmit").click(function(){
					$.ajax({
							cache: false,
							type: "POST",
							url: "login.jsp", //把表单数据发送到login.jsp
							data: $('#loginPage').serialize(), //要发送的是loginPage表单中的数据
							async:false,
							error: function(request) {
								alert("发送请求失败！");
							},
							success: function(data) {
								if(data=="123")
									{$("#returnmsg").html("密码错误！");
								    $("#username").val("");
								    $("#password").val("");
								    }
								else if(data=="null"){
									$("#username").val("");
								    $("#password").val("");
									$("#returnmsg").html("用户名错误!");
								}
								 else {
									 var sha=data;
									 alert("Login Successful!");
									 $("#loginPage").css("display","none");
									 $("#header").html("<a id=\"img\" href=\"index.jsp\"></a><a id=\"personalRec\" href=\"pi.jsp?target=personrec\">个性推荐</a><a id=\"personalInfo\" href=\"pi.jsp?target=personinfo\">个人信息</a><a id=\"personalPre\" href=\"pi.jsp?target=personPre\">偏好调整</a><a id=\"searcherHistory\" href=\"pi.jsp?target=searcherHistory\">浏览历史</a><div id=\"person\">欢迎："+sha+"</div>");
									 $("#header").children().each(function(){
											if($(this).attr("id")!="img"){
												$(this).mouseover(function(){
													$(this).css("background-color","green");
												})
												$(this).mouseout(function(){
													$(this).css("background-color","black");
												})
												$(this).click(function(){
													$(this).css("background-color","green");
												})
											}
											
										})
								 }
							}
					});
				})
				$(".bookinfoContainer").each(function(){
			
			var num=parseFloat($(this).children(".bookRating").html());
			$(this).children(".bookRating").css("width",110*num/10+"px");
			if(num>7)
			$(this).children(".bookRating").css("background-color","green");
			if(num<=7&&num>3)
			$(this).children(".bookRating").css("background-color","yellowgreen");
			if(num<=3)
			$(this).children(".bookRating").css("background-color","red");
			$(this).children(".bookRating").html("&nbsp;&nbsp;&nbsp;&nbsp;"+num);
			
		})
			$("#img").mouseover(function(){
			$(this).css("background-image","url(img/02.png)");
		})
		$("#img").mouseout(function(){
			$(this).css("background-image","url(img/01.png)");
		})
	</script>
	</body>

</html>
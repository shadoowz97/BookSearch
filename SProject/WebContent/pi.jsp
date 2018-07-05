<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.*" %>
    <%@page import="com.google.gson.Gson"%>
    <%@page import="java.net.URL"%>
    <%@page import="pri.shadoowz.beans.*" %>
    <%@page import="pri.shadoowz.User.*" %>
     <%@page import="com.GetDoubanSearch.*" %>
     <%@page import="java.util.*"%>
     <%@page import="com.info.*"%>
     <%@page import="com.ansj.vec.*" %>
    <%String target=request.getParameter("target"); 
   
	 User u=(User)session.getAttribute("user");
	 String name=null;
	 if(u!=null)
	  name=u.getUsername();
	 DoubanSearcher d=new DoubanSearcher();
	 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="css/search.css" />
<script src="js/jquery-3.2.0.min.js"></script>
<script>
var username='<%=name%>';
</script>
<style type="text/css">
		#img{
     		position:absolute;
     		left:30px;
     		top:4px;
     		width:220px;
     		height:46px;
     		background-image: url("img/01.png");
     		
     	}
		</style>
</head>
<body>
<div id="header">
		<div id=login>登&nbsp;&nbsp;&nbsp;录</div>
		<a href="Sign.html"><div id="signin">注&nbsp;&nbsp;&nbsp;册</div></a>
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
	<%if(target.equals("personrec")) {
	ArrayList<tempDoc> td=d.query(u.Similiar((Word2VEC)application.getAttribute("wv")), true);
	for(tempDoc t:td){
	%>
	<div class="BookContainer" bookname=<%=t.bookname %>>
		<a href="https://www.baidu.com"><image src=<%=t.imgsrc %>
				class="bookImage"></image></a>
		<div class="bookinfoContainer">
			<div class="booknameLabel">书&nbsp;&nbsp;名:</div>
			<div class="bookname"><%=t.bookname %></div>
			<div class="bookAuthorLabel">作&nbsp;&nbsp;者:</div>
			<div class="bookAuthor"><%=t.author%></div>
			<div class="bookPriceLabel">价&nbsp;&nbsp;格:</div>
			<div class="bookPrice"><%=t.price %></div>
			<div class="bookRatingLabel">评&nbsp;&nbsp;分:</div>
			<div class="bookRating"><%=t.Rating %></div>
			<div class="bookIsbnLabel">ISBN：</div>
			<div class="bookIsbn"><%=t.ISBN %></div>
			<div class="bookTagLabel">标&nbsp;&nbsp;签:</div>
			<div class="bookTag"><%=t.tags %></div>
			<a class="Detailed" href="BookDetailed.jsp?isbn=<%=t.ISBN%>">查看详细信息</a>
		</div>
		<hr class="divide" />
		<div class="summaryLabel"></div>
		<div class="summaryContainer"><%=t.summary.length()<160?t.summary:t.summary.substring(0, 160)+"..." %></div>
		</div>
		<hr class="averHr" />
	<%}} %>
	<%if(target.equals("searcherHistory")){
		ArrayList<tempDoc> tp=new ArrayList<tempDoc>();
		for(String s:u.getHistory()){
			doubanBean db=DoubanSearcher.search("https://api.douban.com/v2/book/isbn/name:"+s);
			 tempDoc td=new tempDoc();
			  td.bookname=db.getTitle();
			  td.author=db.getAuthor().get(0);
			  td.imgsrc=db.getImages().getMedium();
			  td.ISBN=db.getIsbn10();
			  td.price=db.getPrice();
			  td.Rating=db.getRating().getAverage();
			  td.summary=db.getSummary();
			 try{
				 td.tags=db.getTags().size()>1?db.getTags().get(0).getName()+"/"+db.getTags().get(1).getName():db.getTags().get(0).getName();
			 }
			 catch(Exception e){
				 td.tags="";
			 }
			  tp.add(td);
		}
		for(tempDoc t:tp){
		%>
		<div class="BookContainer" bookname=<%=t.bookname %>>
		<a href="https://www.baidu.com"><image src=<%=t.imgsrc %>
				class="bookImage"></image></a>
		<div class="bookinfoContainer">
			<div class="booknameLabel">书&nbsp;&nbsp;名:</div>
			<div class="bookname"><%=t.bookname %></div>
			<div class="bookAuthorLabel">作&nbsp;&nbsp;者:</div>
			<div class="bookAuthor"><%=t.author%></div>
			<div class="bookPriceLabel">价&nbsp;&nbsp;格:</div>
			<div class="bookPrice"><%=t.price %></div>
			<div class="bookRatingLabel">评&nbsp;&nbsp;分:</div>
			<div class="bookRating"><%=t.Rating %></div>
			<div class="bookIsbnLabel">ISBN：</div>
			<div class="bookIsbn"><%=t.ISBN %></div>
			<div class="bookTagLabel">标&nbsp;&nbsp;签:</div>
			<div class="bookTag"><%=t.tags %></div>
			<a class="Detailed" href="BookDetailed.jsp?isbn=<%=t.ISBN%>">查看详细信息</a>
		</div>
		<hr class="divide" />
		<div class="summaryLabel"></div>
		<div class="summaryContainer"><%=t.summary.length()<160?t.summary:t.summary.substring(0, 160)+"..." %></div>
		</div>
		<hr class="averHr" />
	<% }}%>
	
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
			$("#header").html("<a id=\"img\" href=\"index.jsp\"></a><a id=\"personalRec\" href=\"pi.jsp?target=personrec\">个性推荐</a><a id=\"personalInfo\" href=\"pi.jsp?target=personinfo\">个人信息</a><a id=\"personalPre\" href=\"pi.jsp?target=personPre\">偏好调整</a><a id=\"searcherHistory\">浏览历史</a><div id=\"person\">欢迎："+username+"</div>");
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
								    $("#password").val("");}
								 if(data=="no user"){
									$("#username").val("");
								    $("#password").val("");
									$("#returnmsg").html("用户名错误!");
								}
								 else{
									 alert("Login Successful!");
									 $("#loginPage").css("display","none");
									 $("#header").html("<a id=\"img\" href=\"index.jsp\"></a><a id=\"personalRec\" href=\"pi.jsp?target=personrec\">个性推荐</a><a id=\"personalInfo\" href=\"pi.jsp?target=personinfo\">个人信息</a><a id=\"personalPre\" href=\"pi.jsp?target=personPre\">偏好调整</a><a id=\"searcherHistory\" href=\"pi.jsp?target=searcherHistory\">浏览历史</a><div id=\"person\">欢迎："+data+"</div>");
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
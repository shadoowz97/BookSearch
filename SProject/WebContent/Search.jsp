<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="pri.shadoowz.jdbc.DataBaseConnector.*"%>
<%@page import="java.sql.*"%>
<%@page import="com.LuenceSearcher.*"%>
<%@page import="com.info.*"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.lucene.document.Document"%>
<%@page import="com.GetDoubanSearch.*"%>
<%@page import="pri.shadoowz.User.*"%>
<%@page import="com.ansj.vec.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title></title>
<link rel="stylesheet" href="css/search.css" />
<script src="js/jquery-3.2.0.min.js"></script>
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
	<%

String query;
String type;

if(request.getParameter("query")==null||request.getParameter("way")==null){
	query="中国";
	type="db";
}else{
	 query=new String(((String)request.getParameter("query")).getBytes("ISO-8859-1"),"UTF-8");
	 type=(String)request.getParameter("way");
}
ArrayList<tempDoc> td=new ArrayList<tempDoc>();
if(type.equals("Luence")){
	Searcher s=(Searcher)application.getAttribute("searcher");
	ArrayList<Document> d=s.Search(query);
	for(Document dl:d){
		tempDoc tdoc=new tempDoc();
		
		tdoc.bookname=dl.getField("bookname").stringValue();
		if(tdoc.bookname==null)
			tdoc.bookname="未知";
		tdoc.author=dl.getField("author").stringValue();
		if(tdoc.author==null||tdoc.author.equals(""))
			tdoc.author="佚名";
		tdoc.ISBN=dl.getField("isbn").stringValue();
		tdoc.price=dl.getField("price").stringValue();
		if(tdoc.price==null||tdoc.price.equals(""))
			tdoc.price="未知";
		tdoc.imgsrc=dl.getField("Img").stringValue();
		tdoc.tags=dl.getField("tags").stringValue();
		tdoc.Rating=dl.getField("rating").stringValue();
		tdoc.summary=dl.getField("summary").stringValue();
		td.add(tdoc);
	}
}
if(type.equals("db")){
	td=new DoubanSearcher().query(query,true);
}
User u=(User)session.getAttribute("user");
String name=null;
if(u!=null)
 {
	name=u.getUsername();
	if(application.getAttribute("wv")!=null)
	System.out.println("111");
	td=u.ReRanked((Word2VEC)application.getAttribute("wv"), td);
 }
%>
	<script>
var username='<%=name%>';
</script>
	<div id="header">
		<div id=login>登&nbsp;&nbsp;&nbsp;录</div>
		<a href=""><div id="signin">注&nbsp;&nbsp;&nbsp;册</div></a>
		<a id="img" href="index.jsp"></a>
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
	<form id="SearcherContainer" action="Search.jsp" method="post">
		<input type="text" id="searchinput" name="query" /> <input
			type="image" id="searcherImage" src="img/but2.png" /> <input
			type="radio" id="luence" name="way" value="Luence" checked /> <input
			type="radio" id="db" name="way" value="db" /> <input type="radio"
			id="tj" name="way" value="tj" />

	</form>
	<% for(tempDoc t:td){ %>
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
		<button class="testbutton">评 价</button>
		<form class="valueContainer">
			<textarea class="Valuetext"></textarea>
			<button class="subbutton" type="button" bookname="<%=t.bookname %>" bookisbn="<%=t.ISBN %>" suit="0">提交</button>
		</form>
	</div>
	<hr class="averHr" />
	<% }%>

	<script>
		//此代码块用于控制样式
		var bsuit=false;
		
		$(".testbutton").click(function(){
			if(!bsuit)
			{
				$(this).html("收 起")
				$(this).parent().css("height","600px");
			$(this).next().css("display","block");
			bsuit=true;
			}
			else{
				bsuit=false;
				$(this).parent().css("height","400px");
				$(this).next().css("display","none");
				$(this).html("评 价");
			}
		});
		$(".subbutton").click(function(){
			var target=$(this);
			$.ajax({
					cache: false,
					type: "POST",
					url: "BookEValueInsert.jsp", 
					data: "bookname="+$(this).attr("bookname")+"&&"+"evalue="+$(this).parent().children(".Valuetext").val()+"&&bookisbn="+$(this).attr("bookisbn"), 
					async:false,
					error: function(request) {
						alert("发送请求失败！");
					},
					success: function(data) {
						target.parent().children(".Valuetext").val("");
						target.parent().prev().click();
						alert(data);
					}
			});
		})
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
								    $("#password").val("");}
								else if(data=="no user"){
									$("#username").val("");
								    $("#password").val("");
									$("#returnmsg").html("用户名错误!");
								}
								 else{
									 alert("Login Successful!");
									 $("#loginPage").css("display","none");
									 $("#header").html("<a id=\"img\" href=\"index.jsp\"></a><a id=\"personalRec\" href=\"pi.jsp?target=personrec\">个性推荐</a><a id=\"personalInfo\" href=\"pi.jsp?target=personinfo\">个人信息</a><a id=\"personalPre\" href=\"pi.jsp?target=personPre\">偏好调整</a><a id=\"searcherHistory\  href=\"pi.jsp?target=searcherHistory\">浏览历史</a><div id=\"person\">欢迎："+data+"</div>");
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

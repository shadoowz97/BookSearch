<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.io.*" %>
    <%@page import="com.google.gson.Gson"%>
    <%@page import="java.net.URL"%>
    <%@page import="com.GetDoubanSearch.*" %>
    <%@page import="pri.shadoowz.beans.*" %>
    <%@page import="pri.shadoowz.User.*" %>
    <%@page import="pri.shadoowz.jdbc.DataBaseConnector.*"%> 
    <%@page import="com.info.*" %>
     <%@page import="java.util.*" %>
<%@page import="java.sql.*" %>
    <%String isbn=request.getParameter("isbn"); 
    String url;
	 url="https://api.douban.com/v2/book/isbn/name:"+isbn;
	 doubanBean d=DoubanSearcher.search(url);
	 User u=(User)session.getAttribute("user");
	 String name=null;
	 if(u!=null)
	  {name=u.getUsername();
	  u.getHistory().add(isbn);
	  }
	 %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/search.css" />
<link rel="stylesheet" href="css/BookDetail.css" />
<style type="text/css">
#img{
     		position:absolute;
     		left:30px;
     		top:4px;
     		width:220px;
     		height:46px;
     		background-image: url("img/01.png");
     		
     	}
     	.UserE{
				position:relative;
				width:500px;
				height:50px;
				left:60px;
				top:140px;
				border:1px dotted green;
				
			}
			.userid{
				position:relative;
				width:100px;
				height:16px;
				top:10px;
				left:50px;
				font-size:13px;
				color:green;
			}
			.date{
				position:relative;
				width:150px;
				height:16px;
				top:-7px;
				left:150px;
				display:inline-block;
				font-size:13px;
				color:gray;
				
			}
			.content{
				position:relative;
				width:400px;
				height:0px;
				top:10px;
				left:30px;
				font-size:13px;
				color:black;
			}
</style>
<script src="js/jquery-3.2.0.min.js"></script>
<script>
var username='<%=name%>';
</script>
</head>
<body>
<div id="header">
<a id="img" href="index.jsp"></a>
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
	<div id="BookDetailed"><% if(d!=null){%>
				<image src="<%=(d.getImages().getMedium()==null)?"null":d.getImages().getSmall() %>" id="BookImage"></image>
				<div id="InfoContainer">
					<div id="BooktitleLabel">书&nbsp;&nbsp;名:</div>
					<div id="Booktitle"><%=d.getTitle() %></div>
					<div id="AuthorLabel">作&nbsp;&nbsp;者:</div>
					<div id="Author"><%=DoubanSearcher.ListToString(d.getAuthor()) %></div>
					<div id="PriceLabel">价&nbsp;&nbsp;格:</div>
					<div id="Price"><%=d.getPrice() %></div>
					<div id="RatingLabel">评&nbsp;&nbsp;分</div>
					<div id="Rating"><%=d.getRating().getAverage() %></div>
					<div id="PublisherLabel">出&nbsp;版&nbsp;商:</div>
					<div id="Publisher"><%=d.getPublisher() %></div>
					<div id="PublishDateLabel">出版日期:</div>
					<div id="PublishDate"><%=d.getPubdate() %></div>
					<div id="PagesLabel">页&nbsp;&nbsp;数:</div>
					<div id="Pages"><%=d.getPages() %></div>
					<div id="ISBNLabel">ISBN:</div>
					<div id="ISBN"><%=d.getIsbn10() %></div>
					<div id="TagsLabel">标&nbsp;&nbsp;签:</div>
					<div id="Tags"><%=DoubanSearcher.TagToString(d.getTags())%></div>
				</div>
				<div id=HrBookSummary>··················&nbsp;&nbsp;书籍简介&nbsp;&nbsp;···············································································</div>
				<div id="BookSummary"><%=d.getSummary()%></div>
					<div id="HrAuthorIntro">··················&nbsp;&nbsp;作者介绍&nbsp;&nbsp;···············································································</div>
					<div id="AuthorIntro"><%=d.getAuthor_intro()%></div>
					<div id="HrEvalution">··················&nbsp;&nbsp;评论区&nbsp;&nbsp;···············································································</div>
					<% Connector c=new Connector();
					   Statement s=c.con.createStatement();
					   ResultSet rs=s.executeQuery("select * from evalutionbooks where bookname='"+d.getTitle()+"'");
					   ArrayList<tempValue> t=new ArrayList<tempValue>();
					  while(rs.next()){
						tempValue w= new tempValue();
						w.username=rs.getString(1);
						w.date=rs.getString(4);
						w.value=rs.getString(3);
						t.add(w);
					  }
					  for(tempValue tv:t){
					%>
					<div class="UserE">
						<div class="userid"><%=tv.username %></div>
						<div class="date"><%=tv.date %></div>
						<div class="content"><%=tv.value %></div>
					</div>
					
				
			
			<%} %>
			<%} %>
			</div>
			</div>
			<script>
		    var rate=$("#Rating");
			var num=parseFloat(rate.html());
			rate.css("width",110*num/10+"px");
			if(num>7)
			rate.css("background-color","green");
			if(num<=7&&num>3)
			rate.css("background-color","yellowgreen");
			if(num<=3)
			rate.children(".bookRating").css("background-color","red");
			rate.children(".bookRating").html("&nbsp;&nbsp;&nbsp;&nbsp;"+num);
			$("#BookSummary").css("height",Math.ceil($("#BookSummary").html().length/36.5)*20+"px");
			$("#AuthorIntro").css("height",Math.ceil($("#AuthorIntro").html().length/36.5)*20+"px");
		
			</script>
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
								    $("#password").val("");}
								 if(data=="no user"){
									$("#username").val("");
								    $("#password").val("");
									$("#returnmsg").html("用户名错误!");
								}
								 else{
									 alert("Login Successful!");
									 $("#loginPage").css("display","none");
									 $("#header").html("<a id=\"img\" href=\"index.jsp\"></a><a id=\"personalRec\" href=\"pi.jsp?target=personrec\">个性推荐</a><a id=\"personalInfo\" href=\"pi.jsp?target=personinfo\">个人信息</a><a id=\"personalPre\" href=\"pi.jsp?target=personPre\">偏好调整</a><a id=\"searcherHistory\"  href=\"pi.jsp?target=searcherHsitory\">浏览历史</a><div id=\"person\">欢迎："+data+"</div>");
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
			$("#img").mouseover(function(){
			$(this).css("background-image","url(img/02.png)");
		})
		$("#img").mouseout(function(){
			$(this).css("background-image","url(img/01.png)");
		})
		$(".content").each(function(){
			var vh=Math.ceil($(this).html().length/36.5)*15;
			$(this).css("height",vh+"px");
			var pa=$(this).parent();
			pa.css("height",vh+50+"px");
		})
	</script>
</body>
</html>
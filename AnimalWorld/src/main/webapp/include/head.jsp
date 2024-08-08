<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="aws.vo.*" %>
<%@ page import="aws.dto.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%
UserVO login = (UserVO)session.getAttribute("login");
String username = (String)session.getAttribute("username");

//검색어를 받는다.
request.setCharacterEncoding("euc-kr");
String keyword = request.getParameter("keyword");
if(keyword == null) keyword = "";
String tag = request.getParameter("tag");
if(tag == null) tag = "";
String kwd = request.getParameter("kwd");
if(kwd == null) kwd = "";
%>
<!DOCTYPE html>
<html>
<head>
    <title>Animal worlds</title>
    <meta charset="euc-kr"/>
    <script src="../js/jquery-3.7.1.js"></script>
    <style>
	@import url('https://fonts.googleapis.com/css2?family=Single+Day&display=swap');
	@import url('https://fonts.googleapis.com/css2?family=Dongle&family=Single+Day&display=swap');
	.ct-font{
		font-family: "Single Day", cursive;
		font-size: 15pt;
		font-style: normal;
	}
	body {
  font-family: "Dongle", sans-serif;
  font-size: 20pt;
  font-style: normal;
	}
        nav{
            background-color: #fc6e51;
            text-align: center;
            padding: 10px;
        }
        nav a{
            margin: 30px;
            color: white;
            font-weight: bold;
        }
        .search {
            position: relative;
            width: 420px; /* 적절한 너비 설정 */
            margin-left: auto;
            margin-right: auto;
        }
        input[name="kwd"] {
            width: 400px;
            border: 1px solid #bbb;
            border-radius: 8px;
            padding: 10px 12px;
            font-size: 14px;
        }
        input[type="image"] {
            position: absolute;
            width: 40px; /* 버튼의 크기 설정 */
            height: 40px; /* 버튼의 크기 설정 */
            top: 0.5em;
            right: 0;
            margin: 0;
            border-radius: 8px;
        }
        .join{
            text-align: right;
            font-weight: bold;
        }
        footer{
            text-align: center;
            font-weight: bold;
            
        }
        a{
            text-decoration-line: none;
        }
        a:link {
  		  color : blue;
		}
		a:visited {
		  color : purple;
		}
		a:hover {
		  color : blue;
		}
        .menu a {
          color: white;
        }
        .join a {
          color : blue;
        }
    </style>
</head>
<body style="background-image:url(../img/뼈다귀.jpg);">
    <table border="0" style=" margin: 0% auto; width: 1500px; background-color: white; opacity: 0.97; border:1; border-collapse: collapse; border-radius: 100px;">
        <tr>
            <td>
            <div style="display: flex; align-items: center;">
            	<div>
                <a href="../home/index.jsp">
                    <img src="../img/mainlogo.png" style="width: 300px; margin-left: 100px; ">
                </a>
                </div>
                <div class="search" style="margin-left: 150px;margin-top: 100px;">
                <form name="search" id="search" action="../search/search_list.jsp" method="get" accept-charset="utf-8">    
                    <span>
                        <input name="kwd" type="text" style="width: 400px; height: 30px;" value="<%= kwd %>">
                        <input type="image" src="../img/search.png" value="검색">
                    </span>
                </form>
                </div>
              
                
                <div class="join ct-font" style="margin-top: 150px;">
                <%
                if(login == null)
                {
                %>
                <a href="../home/join.jsp">회원가입</a>
                &nbsp;&nbsp;
                <a href="../login/login.jsp">로그인</a>
                &nbsp;&nbsp;
                <%
                }else
                {%>
                	<%= username %>님 환영합니다. &nbsp;&nbsp;<br> <a href="../home/my_page.jsp">내 정보</a> &nbsp;&nbsp; <a href="../login/logout.jsp">로그아웃</a>&nbsp;&nbsp;
               	<%
                }
                %>
                </div>
            </div>
            </td>
        </tr>
        <tr>
            <td >
                <nav class="menu ct-font">
                    <a href="../free/free_list.jsp?kind=F">자유게시판</a>
                    <a href="../food/food_list.jsp?kind=R">식품추천게시판</a>
                    <a href="../share/share_list.jsp?kind=S">나눔게시판</a>
                    <a href="../imge/imge_list.jsp?kind=I">이미지갤러리</a>
                    <a href="../qna/qna_list.jsp?kind=Q">QnA</a>
                </nav>
            </td>
        </tr>
        <tr>
            <td>
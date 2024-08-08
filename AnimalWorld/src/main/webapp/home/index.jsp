<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ include file="../include/head.jsp" %>
<%@page import="java.util.ArrayList"%>
<%
String kind = request.getParameter("kind");
if(kind == null) kind = "";

int pageno  = 1;  //현재 페이지 번호
int total   = 0;  //전체 게시물 갯수
int maxpage = 0;  //전체 페이지수
try
{
	pageno = Integer.parseInt(request.getParameter("page"));
}catch(Exception e){};

BoardDTO dto = new BoardDTO();
total = dto.GetTotal();
maxpage = total / 10;
if( total % 10 != 0 ) maxpage++;

ArrayList<BoardVO> list = dto.GetList(pageno);
%>
<!-- 콘텐츠 출력부분 -->
<h3>
<p style="text-align:center;" class="font-size">
    <strong style="color: rgb(255, 195, 74);">Animal Worlds</strong>에 오신걸 환영합니다~!<br>
    저희는 반려동물에 관심있는 모두를 위한 정보공유 사이트입니다.<br>
    많은 관심과 이용부탁드립니다~^^<br><br></p>
</h3>
<div class="img_main" style="text-align: center;">
    <img src="../img/main.png" style="width:80%;" alt="메인이미지" ><br>
</div>
<table border="0" style="width: 100%;">
<tr>
    <td>
        <span style="color: black; font-weight: bold; margin-left: 10%;">최근게시물</span><br><br> 
        <!-- 모든게시판 글을 날짜기준으로 최신순 5개 출력 -->
    </td>
    <table border="0" style="width: 80%; margin-left: auto; margin-right: auto;border-spacing: 0px;">
    <tr>
        <td style="text-align: center; width: 100px; background-color:#00BFFF;">
            게시판
        </td>
        <td style="text-align: center; width: 200px; background-color:#00BFFF;">
            제목
        </td>
        <td style="text-align: center; width: 80px; background-color:#00BFFF;">
            작성자
        </td>
        <td style="text-align: center; width: 100px; background-color:#00BFFF;">
            작성일
        </td>
        <td style="text-align: center; width: 50px; background-color:#00BFFF;">
            조회수
        </td>
    </tr>
<%
    //출력 번호 계산 = (전체 갯수) - (페이지번호 - 1) * 10
	int seqno = total - (pageno -1 ) * 10;
      
    for(BoardVO item : list)
    {
  	  String pkind = item.getBkind();
  	  String rink = "";
  	  switch(pkind)
  	  {
  	  case "F" : 
  		  pkind = "자유게시판";
  		  rink = "../free/free_view.jsp";
  		  break;
  	  case "R" : 
  		  pkind = "식품추천게시판";
  		  rink = "../food/food_view.jsp";
  		  break;
  	  case "S" : 
  		  pkind = "나눔게시판";
  		  rink = "../share/share_view.jsp";
  		  break;
  	  case "I" : 
  		  pkind = "이미지갤러리";
  		  rink = "../imge/imge_view.jsp";
  		  break;
  	  case "Q" : 
  		  pkind = "QnA";
  		  rink = "../qna/qna_view.jsp";
  		  break;
  	  }
%>
	<tr style="background-color:#f4f4f4;">
		<td style="text-align: center;"><%= pkind %></td>										
		<td style="text-align: left;">
		<a href="<%= rink %>?kind=<%= item.getBkind() %>&page=<%= pageno %>&no=<%=item.getBno()%>"><%= item.getBtitle() %></a>
		<% if(!item.getRcount().equals("0"))
		{
		%><span style="color: orange;">(<%= item.getRcount() %>)</span>
		<%
		}
		%>
		</td>
		<td style="text-align: center;"><%= item.getName() %></td>
		<td style="text-align: center;"><%= item.getBwdate() %></td>
		<td style="text-align: center;"><%= item.getBhit() %></td>					
	</tr>
	<%
	}
	%>
	</table><br>
</tr>
</td>
<!--footer 부분-->
<%@ include file="../include/tail.jsp" %>